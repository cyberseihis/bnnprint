import h5py
import numpy as np


def paradump_weights(filename):
    h5 = h5py.File(filename, 'r')
    sw0 = h5['q_dense/q_dense/kernel:0'][:, :]
    sw1 = h5['q_dense_1/q_dense_1/kernel:0'][:, :]
    # Need to transpose to allign rows with neurons
    # Add param calculation
    N, M = sw0.shape
    B = 4
    _, C = sw1.shape
    paramN = f"parameter N = {N};\n"
    paramM = f"parameter M = {M};\n"
    paramC = f"parameter C = {C};\n"
    paramB = f"parameter B = {B};\n"
    params = paramN+paramM+paramB+paramC
    bw0 = biny(sw0.T)
    bw1 = biny(sw1.T)
    hard0 = layep(bw0)
    hard1 = layebin(bw1)
    print(bw0)
    h5.close()
    with open('bitstr'+filename, 'w') as file:
        file.write(params+hard0+hard1)


def layep(mat):
    neus = [neur(i, a) for i, a in enumerate(mat)]
    bod = '\n'.join(neus)
    return bod


def layebin(mat):
    neus = [bineur(i, a) for i, a in enumerate(mat)]
    bod = '\n'.join(neus)
    return bod


def cel(i):
    f = f"+ inm[{i}]"
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
    poses = [i for i, a in enumerate(ar) if a == 1]
    neges = [i for i, a in enumerate(ar) if a != 1]
    bodp = ' '.join([cel(i) for i in poses])
    bodn = ' '.join([cel(i) for i in neges])
    al = f"assign mid[{i}] = {bodp} >= {bodn};"
    return al


def biny(a):
    b = np.sign(a)
    return np.maximum(b, 0)
