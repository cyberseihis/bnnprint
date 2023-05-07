import numpy as np


def layeposnw(mat, pwid, nwid):
    neus = [neurpn(i, a, pwid[i], nwid[i]) for i, a in enumerate(mat)]
    bod = '\n'.join(neus)
    return bod


def celpn(i):
    f = f"+ feature_array[{i}]"
    return f


def neurpn(i, ar, wp, wn):
    poses = [i for i, a in enumerate(ar) if a == 1]
    neges = [i for i, a in enumerate(ar) if a == -1]
    bodp = ' '.join([celpn(i) for i in poses])
    bodn = ' '.join([celpn(i) for i in neges])
    al = f"""
    wire unsigned [{wp-1}:0] pos_{i};
    wire unsigned [{wn-1}:0] neg_{i};
    assign pos_{i} = {bodp};
    assign neg_{i} = {bodn};
    assign hidden[{i}] = pos_{i} >= neg_{i};"""
    return al
