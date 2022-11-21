import pickle as pk
import numpy as np


def weight_to_threshhold(w: dict):
    b = w["beta"]
    si = w["mvar"]
    mu = w["mmean"]
    thr = -b * np.sqrt(si) + mu
    ithr = np.floor(thr).astype("int")
    return ithr


if __name__ == "__main__":
    weights = pk.load(open("pendigit_weights.pk", "rb"))
    w = weights["BW1"]
    thr = weight_to_threshhold(w)
