import numpy as np
import pickle as pk


def signs_to_ops(weights):
    signs = [("+ " if x else "+ ~") for x in weights]
    f = [f"{x}a[{i}]" for i, x in enumerate(signs)]
    return ' '.join(f)


def xnorprint(weights):
    ops = [signs_to_ops(x) for x in weights]
    lines = [f"assign o[{i}] = {x};" for i, x in enumerate(ops)]
    return '\n'.join(lines)


def main():
    weights = pk.load(open("pendigit_weights.pk", "rb"))
    w2 = weights["W2"]
    wi = w2.T
    print(xnorprint(wi))


if __name__ == "__main__":
    main()
