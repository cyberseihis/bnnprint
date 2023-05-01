from keras.models import load_model
import numpy as np
import os
import re
from predict import quick_bnn, max_sum1, quick_tnn, max_cntr, inthemiddle
from hardcodetnn import l2ter


def paradump_bnnce(fnm):
    mod, X, y = quick_bnn(fnm)
    wids = max_cntr(mod, X)
    oldwids = max_sum1(mod, X)
    mask = oldwids > wids
    ws = mod.get_weights()
    sw0 = ws[0]
    sw1 = ws[1]
    mids = inthemiddle(sw0, X).astype("int")
    mids = mask * mids
    # Need to transpose to allign rows with neurons
    bw0 = np.sign(sw0.T)
    bw1 = np.sign(sw1.T)
    hard0 = layep_ce(bw0, wids, mids)
    hard1 = layebin(bw1)
    print(bw0)
    with open('../models/bnn1/hardce/'+fnm+'_bnn1.hrdcd', 'w') as file:
        file.write(hard0+"\n"+hard1)


def paradump_bnn(fnm):
    mod, X, y = quick_bnn(fnm)
    wids = max_sum1(mod, X)
    ws = mod.get_weights()
    sw0 = ws[0]
    sw1 = ws[1]
    # Need to transpose to allign rows with neurons
    bw0 = biny(sw0.T)
    bw1 = biny(sw1.T)
    hard0 = layep(bw0, wids)
    hard1 = layebin(bw1)
    print(bw0)
    with open('../models/bnn1/hardw/'+fnm+'_bnn1.hrdcd', 'w') as file:
        file.write(hard0+"\n"+hard1)


def paradump_tnn(fnm):
    mod, X, y = quick_tnn(fnm)
    wids = max_sum1(mod, X)
    ws = mod.get_weights()
    sw0 = ws[0]
    sw1 = ws[1]
    # Need to transpose to allign rows with neurons
    bw0 = np.sign(sw0.T)
    bw1 = np.sign(sw1.T)
    hard0 = layep(bw0, wids)
    hard1 = l2ter(bw1)
    with open('../models/tnn1/hardw/'+fnm+'_tnn1.hrdcd', 'w') as file:
        file.write(hard0+"\n"+hard1)


def layep(mat, wids):
    neus = [neur(i, a, wids[i]) for i, a in enumerate(mat)]
    bod = '\n'.join(neus)
    return bod


def layep_ce(mat, wids, mids):
    neus = [neur_ce(i, a, wids[i], mids[i]) for i, a in enumerate(mat)]
    bod = '\n'.join(neus)
    return bod


def layebin(mat):
    neus = [bineur(i, a) for i, a in enumerate(mat)]
    bod = '\n'.join(neus)
    return bod


def cel(i, w):
    if (w == 0):
        return ""
    oper = '+' if w == 1 else '-'
    return f"{oper} feature_array[{i}]"


def bicel(i, w):
    x = "" if w == 1 else "_n"
    f = f"+ hidden{x}[{i}]"
    return f


def bineur(i, ar):
    bod = ' '.join([bicel(i, w) for i, w in enumerate(ar)])
    al = f"assign scores[{i}*SUM_BITS+:SUM_BITS] = {bod};"
    return al


def neur_ce(i, ar, wid, mid):
    if (np.max(ar) <= 0):
        return f"assign hidden[{i}] = 0;"
    if (np.min(ar) >= 0):
        return f"assign hidden[{i}] = 1;"
    bodp = ' '.join([cel(i, a) for i, a in enumerate(ar)])
    nmid = -mid
    al = f"""
    wire signed [{wid-1}:0] intra_{i};
    assign intra_{i} = {bodp} {nmid:+d};
    assign hidden[{i}] = intra_{i} >= {nmid:d};"""
    return al


def neur(i, ar, wid):
    if (np.max(ar) <= 0):
        return f"assign hidden[{i}] = 0;"
    if (np.min(ar) >= 0):
        return f"assign hidden[{i}] = 1;"
    bodp = ' '.join([cel(i, a) for i, a in enumerate(ar)])
    # wire signed [INDEX_BITS+5:0] intra_{i};
    al = f"""
    wire signed [{wid-1}:0] intra_{i};
    assign intra_{i} = {bodp};
    assign hidden[{i}] = intra_{i} >= 0;"""
    return al


def biny(a):
    b = np.sign(a)
    return np.maximum(b, 0)


def get_tnn_filenames():
    filenames = os.listdir("../models/tnn1/")
    pattern = "(.*?)_tnn1.weights.h5"
    def dsets(fnm): return re.search(pattern, fnm).group(1)
    csv_filenames = [
        dsets(filename) for filename in filenames
        if (".weights.h5" in filename)]
    return csv_filenames


def get_bnn_filenames():
    filenames = os.listdir("../models/bnn1/")
    pattern = "(.*?)_bnn1.weights.h5"
    def dsets(fnm): return re.search(pattern, fnm).group(1)
    csv_filenames = [
        dsets(filename) for filename in filenames
        if (".weights.h5" in filename)]
    return csv_filenames


def dump_hard_tnn():
    for f in get_tnn_filenames():
        paradump_tnn(f)


def dump_hard_bnn():
    for f in get_bnn_filenames():
        paradump_bnn(f)


def dump_hard_bnnce():
    for f in get_bnn_filenames():
        paradump_bnnce(f)
