import pickle as pk
import numpy as np
weights = pk.load(open("pendigit_weights.pk", "rb"))
wi = weights["W1"]
acbits = 7
acN = wi.shape[1]
l1bits: int = int(np.ceil(np.log2(acN)) + acbits)


def indx(i: int, bw: int):
    return str(i * bw + bw - 1)+':'+str(i * bw)


def activ_repr(i: int, bw: int):
    return " a["+indx(i, bw)+"]"


def operation_line(weights):
    ops = [("+"if x else "-")+activ_repr(y, acbits)
           for y, x in enumerate(weights)]
    return ops


def pure_ops(weights):
    return map(operation_line, weights.T)


def single_line(i: int, weights: list[bool]):
    ops = operation_line(weights)
    p1 = "assign t["+str(i)+"] = "+' '.join(ops)+";"
    p2 = "assign o["+indx(i, l1bits)+"] = t["+str(i)+"];"
    return p1+"\n"+p2


def fp_bin_weights_to_operations(weights):
    return '\n'.join([single_line(y, x) for y, x in enumerate(weights.T)])


if __name__ == "__main__":
    print(fp_bin_weights_to_operations(wi))
