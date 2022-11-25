import tensorflow.keras as kr
import larq as lq
import numpy as np
import pickle as pk
from bn1test import dict_to_threshhold


def xnor_gold(activs):
    mac = gold_bin_dense(activs)
    return (mac + len(activs))/2


def full_gold(activs):
    activs = np.array([activs])
    model = kr.models.load_model("pendigitsbnn.h5")
    la = model.layers
    lafn2 = kr.backend.function([model.input], [la[2].output])
    res = lafn2(activs)[0][0]
    return (res + 16)/2


def gold_bin_dense(activs):
    activs = np.array([activs])
    model = kr.models.load_model("pendigitsbnn.h5")
    la = model.layers
    lx = la[2]
    lafn2 = kr.backend.function([lx.input], [lx.output])
    return lafn2(activs)[0][0]


def gold_xnor_bnorm(activs):
    activs = np.array([activs])
    model = kr.models.load_model("pendigitsbnn.h5")
    la = model.layers
    lafn2 = kr.backend.function([la[2].input], [la[3].output])
    return lafn2(activs)[0][0]


def xnortest(activs, weights):
    activs = np.array(activs).astype("bool")
    weights = np.array(weights).astype("bool")
    o = np.sum(~np.logical_xor(weights, activs), 1)
    return o


def xnorbnormtest(activs, weights, b_dict):
    acN = weights.shape[1]
    activs = np.array(activs).astype("bool")
    weights = np.array(weights).astype("bool")
    o = np.sum(~np.logical_xor(weights, activs), 1)
    thrs = dict_to_threshhold(b_dict)
    thrs = np.floor((thrs+acN)/2).astype("int")
    return o > thrs


if __name__ == "__main__":
    weights = pk.load(open("pendigit_weights.pk", "rb"))
    w2 = weights["W2"]
    w2 = w2.T
    # activs = np.ones(16)
    bdic = weights["BW2"]
    # print(xnortest(activs, w2))
    # print(xnor_gold(activs))
    activs = [80, 100, 18, 98, 60, 66, 100, 29, 42,  0,  0, 23, 42, 61, 56, 98]
    fg = full_gold(activs)
    print(fg)
