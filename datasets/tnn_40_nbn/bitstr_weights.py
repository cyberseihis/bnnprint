import h5py
import numpy as np
import binascii
import re
import os


def bitstr_weights(filename):
    h5 = h5py.File(filename, 'r')
    pattern = "weightnn(.*?).h5"
    dset = re.search(pattern, filename).group(1)
    sw0 = h5['q_dense/q_dense/kernel:0'][:, :]
    sw1 = h5['q_dense_1/q_dense_1/kernel:0'][:, :]
    h5.close()
    with open(f"bitstrings/{dset}.bstr", 'w') as file:
        file.write(firstStr(sw0))


def dump_bitstrings():
    for fnm in os.listdir():
        if (fnm.startswith("weightnn")):
            bitstr_weights(fnm)


def firstlayernums(mat):
    matz = np.sign(mat)
    abz = np.abs(matz)
    sinz = np.maximum(matz, 0)
    cnz = np.count_nonzero(mat, axis=0)
    return abz, sinz, cnz


def firstStr(mat):
    abz, sinz, cnz = firstlayernums(mat)
    stabz = binst(abz.flatten())[::-1]
    stinz = binst(sinz.flatten())[::-1]
    cntnnz = dbytes(cnz)
    v = f"`define WVALS {len(stinz)}'b{stinz}"
    s = f"`define WZERO {len(stabz)}'b{stabz}"
    n = f"`define WNNZ {len(cntnnz)*8}'h{cntnnz}"
    return '\n'.join([v, s, n])


def dbytes(mat):
  kay=mat.flatten().astype(np.uint8).tobytes()
  return binascii.hexlify(kay).decode()


def matrix_bin_string(mat):
    flatw = mysign(mat).flatten()
    bflat = np.maximum(flatw, 0)
    flbin = bflat.astype(np.uint8).tobytes()
    return binascii.hexlify(flbin).decode()[1::2]


def binst(yy):
    yozo = np.maximum(yy, 0)
    asbin = yozo.astype(np.uint8).tobytes()
    bs = binascii.hexlify(asbin).decode()[1::2]
    return bs[::-1]


def mysign(a):
    signs = np.sign(a)

# Replace the sign of the zeroes with 1 (positive) or -1 (negative)
    signs_no_zero = np.where(signs == 0, 1, signs)
    return signs_no_zero
