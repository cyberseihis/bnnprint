import h5py
import numpy as np
import os


def paradump_weights(filename):
    h5 = h5py.File(filename, 'r')
    sw0 = h5['q_dense/q_dense/kernel:0'][:, :]
    sw1 = h5['q_dense_1/q_dense_1/kernel:0'][:, :]
    # Need to transpose to allign rows with neurons
    bw0 = biny(sw0.T)
    bw1 = biny(sw1.T)
    hard0 = layep(bw0)
    hard1 = layebin(bw1)
    print(bw0)
    h5.close()
    with open('tnnprints/'+filename+'.hrdcd', 'w') as file:
        file.write(hard0+"\n"+hard1)


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
    valz = [(i, a) for i, a in enumerate(ar) if a != 0]
    bod = ' '.join([bicel(i, w) for i, w in valz])
    if not valz:
        return f"assign out[{i}*SumL+:SumL] = 0;"
    al = f"assign out[{i}*SumL+:SumL] = {bod};"
    return al


def neur(i, ar):
    valz = [(i, a) for i, a in enumerate(ar) if a != 0]
    poses = [i for i, a in valz if a == 1]
    neges = [i for i, a in valz if a != 1]
    bodp = ' '.join([cel(i) for i in poses])
    bodn = ' '.join([cel(i) for i in neges])
    if poses:
        alp = f"assign pmid[{i}] = {bodp};\n"
    else:
        alp = f"assign pmid[{i}] = 0;\n"
    if neges:
        aln = f"assign nmid[{i}] = {bodn};\n"
    else:
        aln = f"assign nmid[{i}] = 0;\n"
    ale = f"assign mid[{i}] = pmid[{i}] >= nmid[{i}];"
    return alp+aln+ale


def biny(a):
    b = np.sign(a)
    return b


def get_weight_filenames():
    filenames = os.listdir()
    csv_filenames = [filename for filename in filenames if filename.startswith("weight")]
    return csv_filenames