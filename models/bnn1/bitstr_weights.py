import h5py
import numpy as np
import binascii
import re
import os


def bitstr_weights(filename):
    h5 = h5py.File(filename, 'r')
    pattern = "(.*?).weights.h5"
    dset = re.search(pattern, filename).group(1)
    sw0 = h5['q_dense/q_dense/kernel:0'][:, :]
    sw1 = h5['q_dense_1/q_dense_1/kernel:0'][:, :]
    bstr0 = matrix_bin_string(sw0)
    bstr1 = matrix_bin_string(sw1.T)
    bweight = f"`define WEIGHTS0 {len(bstr0)}'b{bstr0}\n" \
              f"`define WEIGHTS1 {len(bstr1)}'b{bstr1}\n"
    h5.close()
    with open(f"bitstrings/{dset}.bstr", 'w') as file:
        file.write(bweight)


def dump_bitstrings():
    for fnm in os.listdir():
        if (".weights.h5" in fnm):
            bitstr_weights(fnm)


def matrix_bin_string(mat):
    flatw = mysign(mat).flatten()
    bflat = np.maximum(flatw, 0)
    flbin = bflat.astype(np.uint8).tobytes()
    return binascii.hexlify(flbin).decode()[1::2][::-1]


def mysign(a):
    signs = np.sign(a)

# Replace the sign of the zeroes with 1 (positive) or -1 (negative)
    signs_no_zero = np.where(signs == 0, 1, signs)
    return signs_no_zero
