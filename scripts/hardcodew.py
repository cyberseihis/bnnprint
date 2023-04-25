import h5py
from keras.models import load_model
import numpy as np
import os
import re
from predict import quick_bnn, max_sum1


def paradump_weights(fnm):
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


def layep(mat, wids):
    neus = [neur(i, a, wids[i]) for i, a in enumerate(mat)]
    bod = '\n'.join(neus)
    return bod


def layebin(mat):
    neus = [bineur(i, a) for i, a in enumerate(mat)]
    bod = '\n'.join(neus)
    return bod


def cel(i, w):
    f = f"{'+' if w == 1 else '-'} feature_array[{i}]"
    return f


def bicel(i, w):
    x = "" if w == 1 else "_n"
    f = f"+ hidden{x}[{i}]"
    return f


def bineur(i, ar):
    bod = ' '.join([bicel(i, w) for i, w in enumerate(ar)])
    al = f"assign scores[{i}*SUM_BITS+:SUM_BITS] = {bod};"
    return al


def neur(i, ar, wid):
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


def get_weight_filenames():
    filenames = os.listdir("../models/bnn1/")
    pattern = "(.*?)_bnn1.weights.h5"
    dsets = lambda fnm: re.search(pattern, fnm).group(1)
    csv_filenames = [
        dsets(filename) for filename in filenames if (".weights.h5" in filename)]
    return csv_filenames


def dump_hard():
    for f in get_weight_filenames():
        paradump_weights(f)
