import h5py
import numpy as np
import binascii
import re
import os
from scipy.sparse import csr_matrix


def bitstr_weights(filename):
    h5 = h5py.File(filename, 'r')
    pattern = "(.*?).weights.h5"
    dset = re.search(pattern, filename).group(1)
    sw0 = h5['q_dense/q_dense/kernel:0'][:, :]
    sw1 = h5['q_dense_1/q_dense_1/kernel:0'][:, :]
    h5.close()
    with open(f"bitstrings/{dset}.bstr", 'w') as file:
        file.write(firstStr(sw0)+'\n'+secondStr(sw1))


def duck(filename):
    h5 = h5py.File(filename, 'r')
    sw0 = h5['q_dense/q_dense/kernel:0'][:, :]
    return sw0


def dump_bitstrings():
    for fnm in os.listdir():
        if (".weights.h5" in fnm):
            bitstr_weights(fnm)


def firstlayernums(mat):
    matz = np.sign(mat)
    abz = np.abs(matz)
    sinz = np.maximum(matz, 0)
    cnz = np.count_nonzero(mat, axis=0)
    return abz, sinz, cnz


def firstStr(mat):
    abz, sinz, cnz = firstlayernums(mat)
    stabz = binst(abz.flatten())
    stinz = binst(sinz.flatten())
    cntnnz = dbytes(cnz[::-1])
    v = f"`define WVALS {len(stinz)}'b{stinz}"
    s = f"`define WZERO {len(stabz)}'b{stabz}"
    n = f"`define WNNZ {len(cntnnz)*8}'h{cntnnz}"
    return '\n'.join([v, s, n])


def secondStr(mat):
    spa = csr_matrix(mat.T)
    svals = binst(np.maximum(spa.data, 0))
    scols = dbytes(spa.indices[::-1])
    srows = dbytes(spa.indptr[::-1])
    v = f"`define WVALSX {len(svals)}'b{svals}"
    c = f"`define WCOLX {len(svals)*8}'h{scols}"
    r = f"`define WROWX {(len(mat.T)+1)*8}'h{srows}"
    return '\n'.join([v, c, r])


def dbytes(mat):
    kay = mat.flatten().astype(np.uint8).tobytes()
    return binascii.hexlify(kay).decode()


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
