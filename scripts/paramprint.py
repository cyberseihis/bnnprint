import h5py
import numpy as np
import binascii
import re
import os
from hardcodew import get_bnn_filenames, get_tnn_filenames
from predict import quick_bnn, max_sum1, quick_tnn, quant
from rounder import caps
from tsp import reorg
from paar import decompose_layer, decompose_ter


def capd_weights(fnm):
    mod, X, y = quick_bnn(fnm)
    l0 = (quant(X)*16).to_numpy()
    wids0 = max_sum1(mod, X)
    ws = mod.get_weights()
    sw0 = np.sign(ws[0])
    sw1 = ws[1]
    wids = np.maximum(caps(l0, sw0), 5)
    good = np.where(wids0 > wids, 1, 0)
    bstr0 = matrix_bin_string(sw0.T)
    bstr1 = matrix_bin_string(sw1.T)
    bgood = ''.join(map(str, good[::-1]))
    bwids = dbytes(wids)
    bweight = f"""\
`define WEIGHTS0 {len(bstr0)}'b{bstr0}
`define WEIGHTS1 {len(bstr1)}'b{bstr1}
`define WIDTHS {8*sw0.shape[1]}'h{bwids}
`define SATURE {len(bgood)}'b{bgood}"""
    with open(f"../models/bnn1/sats/{fnm}_bnn1.bstr", 'w') as file:
        file.write(bweight)


def permu_weights(fnm):
    mod, X, y = quick_bnn(fnm)
    wids = max_sum1(mod, X)
    ws = mod.get_weights()
    sw0 = np.sign(ws[0])
    sw1 = np.sign(ws[1])
    zw0, zw1, perm = reorg(sw0.T, sw1.T)
    wids = np.array(wids)[perm]
    bstr0 = matrix_bin_string(zw0)
    bstr1 = matrix_bin_string(zw1)
    bwids = dbytes(wids)
    bweight = f"""\
`define WEIGHTS0 {len(bstr0)}'b{bstr0}
`define WEIGHTS1 {len(bstr1)}'b{bstr1}
`define WIDTHS {8*sw0.shape[1]}'h{bwids}"""
    with open(f"../models/bnn1/permutew/{fnm}_bnn1.bstr", 'w') as file:
        file.write(bweight)


def paarter_weights(fnm):
    mod, X, y = quick_bnn(fnm)
    wids = max_sum1(mod, X)
    ws = mod.get_weights()
    sw0 = ws[0]
    sw1 = ws[1]
    paar0, ymap = paarterams(sw0.T)
    bstr1 = matrix_bin_string(sw1.T)
    bwids = dbytes(wids)
    bweight = f"""\
`define PAAR0 {4*len(paar0)}'h{paar0}
`define YMAP {4*len(ymap)}'h{ymap}
`define WEIGHTS1 {len(bstr1)}'b{bstr1}
`define WIDTHS {8*sw0.shape[1]}'h{bwids}"""
    with open(f"../models/bnn1/paarter/{fnm}_bnn1.bstr", 'w') as file:
        file.write(bweight)


def paarX_weights(fnm):
    mod, X, y = quick_bnn(fnm)
    # wids = max_sum1(mod, X)
    ws = mod.get_weights()
    sw0 = ws[0]
    sw1 = ws[1]
    paar0, ymap = paarams(sw0.T)
    paar1, ymap1 = paarams(sw1.T)
    # bwids = dbytes(wids)
    bweight = f"""\
`define PAAR0 {4*len(paar0)}'h{paar0}
`define YMAP {4*len(ymap)}'h{ymap}
`define PAAR1 {4*len(paar1)}'h{paar1}
`define YMAP1 {4*len(ymap1)}'h{ymap1}"""
    with open(f"../models/bnn1/paarx/{fnm}_bnn1.bstr", 'w') as file:
        file.write(bweight)


def paar_weights(fnm, tnn=False):
    quick = quick_tnn if tnn else quick_bnn
    mod, _, _ = quick(fnm)
    ws = mod.get_weights()
    sw0 = ws[0]
    sw1 = ws[1]
    paar0, ymap = paarams(sw0.T)
    swadd1 = np.maximum(sw1.T, 0)
    swnnz = np.abs(sw1.T)
    bstr1 = bin_string(swadd1)
    bstr1nz = bin_string(swnnz)
    bweight = f"""\
`define PAAR0 {4*len(paar0)}'h{paar0}
`define YMAP {4*len(ymap)}'h{ymap}
`define WEIGHTS1 {len(bstr1)}'b{bstr1}
`define WNNZ1 {len(bstr1nz)}'b{bstr1nz}"""
    fil = "tnn1" if tnn else "bnn1"
    with open(f"../models/{fil}/paar/{fnm}_{fil}.bstr", 'w') as file:
        file.write(bweight)


def ortho_weights(fnm):
    mod, X, y = quick_bnn(fnm)
    wids = max_sum1(mod, X)
    ws = mod.get_weights()
    sw0 = ws[0]
    sw1 = ws[1]
    bstr0 = matrix_bin_string(sw0.T)
    bstr1 = matrix_bin_string(sw1.T)
    bwids = dbytes(wids)
    bweight = f"""\
`define WEIGHTS0 {len(bstr0)}'b{bstr0}
`define WEIGHTS1 {len(bstr1)}'b{bstr1}
`define WIDTHS {8*sw0.shape[1]}'h{bwids}"""
    with open(f"../models/bnn1/orthow/{fnm}_bnn1.bstr", 'w') as file:
        file.write(bweight)


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


def dump_sats():
    for fnm in get_bnn_filenames():
        capd_weights(fnm)


def dump_orthos():
    for fnm in get_bnn_filenames():
        ortho_weights(fnm)


def dump_bitstrings():
    for fnm in os.listdir():
        if (".weights.h5" in fnm):
            bitstr_weights(fnm)


def bin_string(mat):
    bflat = np.maximum(np.sign(mat), 0).flatten()
    flbin = bflat.astype(np.uint8).tobytes()
    return binascii.hexlify(flbin).decode()[1::2][::-1]


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


def dbytes(mat):
    kay = mat[::-1].flatten().astype(np.uint8).tobytes()
    return binascii.hexlify(kay).decode()


def dwords(mat):
    kay = mat[::-1].flatten().astype(np.uint16).byteswap().tobytes()
    return binascii.hexlify(kay).decode()


def paarams(sw0):
    ops, ymap = decompose_layer(sw0)
    return dwords(ops), dwords(ymap)


def paarterams(sw0):
    ops, ymap = decompose_ter(sw0)
    return dwords(ops), dwords(ymap)
