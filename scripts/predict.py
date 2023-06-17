from keras.models import load_model
import pandas as pd
import numpy as np
from qkeras import QActivation, QDense
import keras.backend as K
from functools import reduce
from collections import defaultdict
from numba import njit


def groupBy(key, seq):
    return reduce(lambda grp, val:
                  grp[key(val)].append(val)
                  or grp, seq, defaultdict(list))


def get_model(model_f):
    model = load_model(
        model_f,
        custom_objects={'QActivation': QActivation, 'QDense': QDense})
    return model


def preped_dset(dset_f):
    df = pd.read_csv(dset_f, header=None)
    X = df.iloc[:, :-1]
    y = df.iloc[:, -1]
    X = pd.DataFrame(X.apply(
        lambda x: (x - np.min(x)) / (np.max(x) - np.min(x))))
    return X, y


def get_results_f(model_f, dset_f):
    X, _ = preped_dset(dset_f)
    model = get_model(model_f)
    return get_results(model, X)


def get_results(model, X):
    output = model.predict(X)
    clases = np.argmax(output, axis=1)
    return clases


def get_layer_outputs(model, X):
    layer_outputs = [layer.output for layer in model.layers]
    layer_eval_fn = K.function(inputs=[model.input], outputs=layer_outputs)
    output_values = layer_eval_fn([X])
    return output_values


def winners_only(model, X, y):
    dut = get_results(model, X)
    if len(dut) != len(y):
        raise ValueError("Arrays must be the same length")
    equal_indexes = [i for i in range(len(y)) if y[i] == dut[i]]
    return X.iloc[equal_indexes]


def quant(x):
    kkk = (np.round(x*16)).astype(int) / 16
    kj = np.minimum(kkk, 15/16)
    return kj


# for whatever reason f32 f32 byte is the fastest combo
def get_results_qx(sw0, sw1, X):
    l1 = X @ sw0
    l2 = np.sign(2*l1+1)
    l3 = l2 @ sw1
    return np.argmax(l3, axis=1)


def redo(model, X):
    ws = model.get_weights()
    sw0 = ws[0]
    sw1 = ws[1]
    l0 = quant(X)
    l1 = l0 @ sw0
    l2 = mysign(l1)
    l3 = l2 @ sw1
    return [l0, l1, l2, l3]


def binredo(model, X):
    ws = model.get_weights()
    sw0 = ws[0]
    sw1 = ws[1]
    l0 = quant(X)
    l1 = l0 @ np.sign(sw0)
    l2 = mysign(l1)
    l3 = l2 @ sw1
    return [l0, l1, l2, l3]


def split_posneg(mat):
    pos = np.maximum(0, mat)
    neg = np.minimum(0, mat)
    return pos, neg


def mysign(a):
    signs = np.sign(a)
    signs_no_zero = np.where(signs == 0, 1, signs)
    return signs_no_zero


def first_second(row):
    s = sorted(enumerate(row), key=lambda x: -x[1])[:2]
    return s


def oponents(X):
    s = [first_second(x) for x in X]
    s = [((x[0][0], x[1][0]), (x[0][1], x[1][1])) for x in s]
    sj = groupBy(key=lambda x: x[0], seq=s)
    lol = {k: [x[1] for x in v] for k, v in sj.items()}
    return lol


def quickt():
    mod = "../models/tnn1/pendigits_tnn1.h5"
    mod = get_model(mod)
    X, y = preped_dset("../trainingdata/pendigits.csv")
    return mod, X, y


def quick_tnn(dset):
    mod = f"../models/tnn1/{dset}_tnn1.h5"
    mod = get_model(mod)
    X, y = preped_dset(f"../trainingdata/{dset}.csv")
    return mod, X, y


def quick_bnn(dset):
    mod = f"../models/bnn1/{dset}_bnn1.h5"
    mod = get_model(mod)
    X, y = preped_dset(f"../trainingdata/{dset}.csv")
    return mod, X, y


# Removes values that are not the max of their row
def max_row_elements(matrix):
    max_vals = np.max(matrix, axis=1)
    return (matrix == max_vals[:, None]) * matrix


# Max winner per column
def max_legit(mat):
    x = max_row_elements(mat)
    return np.max(x, axis=0)


# Actual sums in output
def max_bnnouts(mod, X):
    lo = redo(mod, X)
    _, n = lo[2].shape
    sum3 = (lo[3] + n) / 2
    return sum3


# Min bit range
def max_sum1(model, X):
    ws = model.get_weights()
    sw0 = ws[0]
    l0 = quant(X)
    l1 = l0 @ np.sign(sw0)
    return maxbits(l1)


# Min bit range after removing the midle value
def max_cntr(model, X):
    ws = model.get_weights()
    sw0 = ws[0]
    l0 = quant(X) * 16
    l1 = l0 @ np.sign(sw0)
    mid = (np.max(l1, axis=0) + np.min(l1, axis=0))/2
    cntr = l1 - np.round(mid)
    return maxbits(cntr/16)


def inthemiddle(sw0, X):
    l0 = quant(X) * 16
    l1 = l0 @ np.sign(sw0)
    mid = (np.max(l1, axis=0) + np.min(l1, axis=0))/2
    return np.round(mid)


# Min bits needed to hold each column
def maxbits(l1):
    mx = np.max(l1, axis=0)
    mn = np.min(l1, axis=0)
    mx = np.maximum(mx*16, 0).astype(int)
    mn = np.minimum(mn*16, 0).astype(int)
    wn = [min_bits_signed(x) for x in mn]
    wx = [min_bits_signed(x) for x in mx]
    wx = np.maximum(wx, wn)
    return wx


def posneg_bits(mod, X):
    mp, mn = max_posneg(mod, X)
    posb = np.array([x.bit_length() for x in mp])
    nosb = np.array([x.bit_length() for x in mn])
    return posb, nosb


def max_posneg(model, X):
    ws = model.get_weights()
    sw0 = np.sign(ws[0])
    l0 = quant(X)*16
    p0, n0 = split_posneg(sw0)
    lp1 = l0 @ p0
    ln1 = - l0 @ n0
    # np.ceil(np.log2(pp*16))
    return np.max(lp1, axis=0).astype("int"), np.max(ln1, axis=0).astype("int")


def loser_posneg(model, X):
    ws = model.get_weights()
    sw0 = ws[0]
    l0 = quant(X)
    p0, n0 = split_posneg(np.sign(sw0))
    lp1 = l0 @ p0
    ln1 = - l0 @ n0
    sp = np.where(lp1 < ln1, lp1, 0)
    sn = np.where(ln1 < lp1, ln1, 0)
    # np.ceil(np.log2(pp*16))
    return np.max(sp, axis=0), np.max(sn, axis=0)


# WRONG FOR NEGATIVE POWERS OF TWO
def min_bits_signed(num):
    n = int(num)
    if (n < 0):
        n = -n - 1
    return n.bit_length() + 1


npminbits = np.vectorize(min_bits_signed)


def width_by_step(l0, sw0):
    if (np.max(l0[0]) < 1):
        l0 = l0 * 16
    sw0 = np.sign(sw0)
    cube = l0[:, :, None] * sw0[None, :, :]
    cs = np.cumsum(cube, axis=1)
    mcs = np.max(cs, axis=0).astype("int")
    ncs = np.min(cs, axis=0).astype("int")
    wmax = npminbits(mcs)
    wmin = npminbits(ncs)
    widf = np.maximum(wmax, wmin)
    # make it nondecreasing,
    # if a later width is smaller the previous neednt be larger
    nond_widths = np.minimum.accumulate(widf[::-1, :], axis=0)[::-1]
    return nond_widths


def widthstepforgraph(l0, sw0):
    if (np.max(l0[0]) < 1):
        l0 = l0 * 16
    sw0 = np.sign(sw0)
    cube = l0[:, :, None] * sw0[None, :, :]
    cs = np.cumsum(cube, axis=1)
    mcs = np.max(cs, axis=0).astype("int")
    ncs = np.min(cs, axis=0).astype("int")
    wmax = npminbits(mcs)
    wmin = npminbits(ncs)
    widf = np.maximum(wmax, wmin)
    # make it nondecreasing,
    # if a later width is smaller the previous neednt be larger
    nond_widths = np.minimum.accumulate(widf[::-1, :], axis=0)[::-1]
    return cs, nond_widths


def index_dict(lst):
    return {val: [i for i, x in enumerate(lst) if x == val]
            for val in sorted(set(lst))}


def stepwidth_dicts(wbs):
    # if only the first is 5 group with others
    wbs[0] = wbs[1]
    dcs = [index_dict(col)for col in wbs.T]
    return dcs
