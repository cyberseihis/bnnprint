import numpy as np
import pickle as pk
from layer1print import indx


def signs_to_ops(weights):
    # signs = [("" if x else "~") for x in weights]
    f = [f"+ {'!'*(not x)}a[{i}]" for i, x in enumerate(weights)]
    f = ' '.join(f)
    return f[2:]


def xnorprint(weights):
    acN = weights.shape[1]
    count_width: int = int(np.ceil(np.log2(acN+1)))
    ops = [signs_to_ops(x) for x in weights]
    lines = [f"assign o[{indx(i, count_width)}] = {x};"
             for i, x in enumerate(ops)]
    return '\n'.join(lines)


def main():
    weights = pk.load(open("pendigit_weights.pk", "rb"))
    w2 = weights["W2"]
    wi = w2.T
    print(xnorprint(wi))


if __name__ == "__main__":
    main()
