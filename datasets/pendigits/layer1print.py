import pickle as pk
import numpy as np
weights = pk.load(open("pendigit_weights.pk", "rb"))
w1 = weights["W1"]
wi = w1.T
acbits = 7
acN = wi.shape[1]
l1bits: int = int(np.ceil(np.log2(acN)) + acbits)


def indx(i: int, bw: int):
    return str(i * bw + bw - 1)+':'+str(i * bw)


def activ_repr(i: int, bw: int):
    return " a["+indx(i, bw)+"]"


def single_line(i: int, bweights: list[bool]):
    ops = [("+"if x else "-")+activ_repr(y, acbits)
           for y, x in enumerate(bweights)]
    p1 = "assign t["+str(i)+"] = "+' '.join(ops)+";"
    p2 = "assign o["+indx(i, l1bits)+"] = t["+str(i)+"];"
    return p1+"\n"+p2


wo = [single_line(y, x) for y, x in enumerate(wi)]
for w in wo:
    print(w)
