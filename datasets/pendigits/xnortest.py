import tensorflow.keras as kr
import larq as lq
import numpy as np
import pickle as pk


def xnorgold(activs, weights):
    pass


def xnortest(activs, weights):
    activs = np.array(activs).astype("bool")
    weights = np.array(weights).astype("bool")
    o = np.sum(np.logical_xor(weights, activs), 1)
    return o


if __name__ == "__main__":
    weights = pk.load(open("pendigit_weights.pk", "rb"))
    w2 = weights["W2"]
    w2 = w2.T
    activs = np.ones(16)
    print(xnortest(activs, w2))
