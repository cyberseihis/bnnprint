import h5py
import numpy as np
import binascii


def bitstr_weights(filename):
    h5 = h5py.File(filename, 'r')
    sw0 = h5['q_dense/q_dense/kernel:0'][:, :]
    sw1 = h5['q_dense_1/q_dense_1/kernel:0'][:, :]
    bstr0 = matrix_bin_string(sw0)
    bstr1 = matrix_bin_string(sw1.T)
    h5.close()
    with open('bitstr'+filename, 'w') as file:
        file.write(bstr0+'\n'+bstr1)


def matrix_bin_string(mat):
    flatw = mysign(mat).flatten()
    bflat = np.maximum(flatw, 0)
    flbin = bflat.astype(np.uint8).tobytes()
    return binascii.hexlify(flbin).decode()[1::2]


def mysign(a):
    signs = np.sign(a)

# Replace the sign of the zeroes with 1 (positive) or -1 (negative)
    signs_no_zero = np.where(signs == 0, 1, signs)
    return signs_no_zero
