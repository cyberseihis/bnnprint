import h5py
import numpy as np
import binascii


def paradump_weights(filename):
    h5 = h5py.File(filename, 'r')
    sw0 = h5['q_dense/q_dense/kernel:0'][:, :]
    sw1 = h5['q_dense_1/q_dense_1/kernel:0'][:, :]
    # Need to transpose to allign rows with neurons
    # Add param calculation
    bw0 = biny(sw0.T)
    bw1 = biny(sw1.T)
    h5.close()
    with open('bitstr'+filename, 'w') as file:
        file.write(bstr0+'\n'+bstr1)


def layep(mat):
    neus = [neur(i, a) for i, a in enumerate(mat)]
    bod = '\n'.join(neus)
    return bod


def layebin(mat):
    neus = [bineur(i, a) for i, a in enumerate(mat)]
    bod = '\n'.join(neus)
    return bod


def cel(i, w):
    x = "+" if w == 1 else "-"
    f = f"{x} inm[{i}*B+:B]"
    return f


def bicel(i, w):
    x = "" if w == 1 else "_n"
    f = f"+ mid{x}[{i}]"
    return f


def bineur(i, ar):
    bod = ' '.join([bicel(i, w) for i, w in enumerate(ar)])
    al = f"assign out[{i}*SumL+:SumL] = {bod};"
    return al


def neur(i, ar):
    bod = ' '.join([cel(i, w) for i, w in enumerate(ar)])
    al = f"assign mid[{i}] = {bod} >= 0;"
    return al


def biny(a): np.maximum(a, 0)
