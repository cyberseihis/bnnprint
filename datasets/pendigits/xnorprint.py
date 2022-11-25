import numpy as np
import pickle as pk
from layer1print import indx
from bn1test import dict_to_threshhold


def signs_to_ops(weights):
    # signs = [("" if x else "~") for x in weights]
    f = [f"+ {'!'*(not x)}a[{i}]" for i, x in enumerate(weights.T)]
    f = ' '.join(f)
    return f[2:]


def xnorprint(weights):
    acN = weights.shape[1]
    count_width: int = int(np.ceil(np.log2(acN+1)))
    ops = [signs_to_ops(x) for x in weights]
    lines = [f"assign o[{indx(i, count_width)}] = {x};"
             for i, x in enumerate(ops)]
    return '\n'.join(lines)


def xnor_bnorm_print(weights, bnorm_dict):
    acN = weights.shape[0]
    print(f"acN is {acN}")
    ops = [signs_to_ops(x) for x in weights.T]
    thrs = dict_to_threshhold(bnorm_dict)
    thrs = np.floor((thrs+acN)/2).astype("int")
    lines = [f"assign o[{i}] = {x} > {t};"
             for i, (t, x) in enumerate(zip(thrs, ops))]
    return '\n'.join(lines)


def main():
    weights = pk.load(open("pendigit_weights.pk", "rb"))
    w2 = weights["W2"]
    bw2 = weights["BW2"]
    res = xnor_bnorm_print(w2, bw2)
    print(res)


if __name__ == "__main__":
    main()
