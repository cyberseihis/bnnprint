import pickle as pk
import numpy as np
weights = pk.load(open("pendigit_weights.pk", "rb"))
w1 = weights["W1"]
wi = w1.T

def indx(i: int, bw: int):
    return str(i * bw)+':'+str(i * bw + bw - 1)

wo = [["+"if x else "-" for x in ww] for ww in wi]
wo = [zip(ww,range(0,len(ww))) for ww in wo]
wo = [''.join([x+" a["+indx(y,7)+"] " for x,y in ww]) for ww in wo]
