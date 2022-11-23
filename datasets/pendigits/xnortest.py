import tensorflow.keras as kr
import larq as lq
import numpy as np
import pickle as pk


def xnor_gold(activs):
    mac = gold_bin_dense(activs)
    return (mac + len(activs))/2


def gold_bin_dense(activs):
    activs = np.array([activs])
    model = kr.models.load_model("pendigitsbnn.h5")
    la = model.layers
    lx = la[2]
    lafn2 = kr.backend.function([lx.input], [lx.output])
    return lafn2(activs)[0][0]


def xnortest(activs, weights):
    activs = np.array(activs).astype("bool")
    weights = np.array(weights).astype("bool")
    o = np.sum(~np.logical_xor(weights, activs), 1)
    return o


if __name__ == "__main__":
    weights = pk.load(open("pendigit_weights.pk", "rb"))
    w2 = weights["W2"]
    w2 = w2.T
    activs = np.ones(16)
    print(xnortest(activs, w2))
    print(xnor_gold(activs))
