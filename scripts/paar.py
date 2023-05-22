import numpy as np
from itertools import chain


def paar_ter(met):
    mat = np.copy(met)
    # 1->1 -1->i
    cmat = np.sqrt(mat+0j)
    i, j = 4, 5
    ops = []
    while (i != j):
        # get weight foreach pair
        samt = cmat.conjugate().T
        dift = cmat.T * -1j
        both = np.stack((samt, dift))
        xdist = both @ cmat
        dist = np.tril(xdist, k=-1)
        # indexes of max hamming of pair and operation
        s, i, j = np.unravel_index(np.argmax(dist), dist.shape)
        if (i == j):
            break
        if (s == 0):
            new = np.where(cmat[:, i] == cmat[:, j], cmat[:, i], 0)
        else:
            new = np.where(cmat[:, i] * cmat[:, j] == 1j, cmat[:, i], 0)
        new_n = np.logical_not(new)
        cmat[:, i] *= new_n
        cmat[:, j] *= new_n
        cmat = np.hstack((cmat, new[:, None]))
        ops.append((s, i, j))
    # return cmat, dist
    ymap = list(zip(np.nonzero(cmat)[1], np.sum(cmat, axis=1)))
    return ops, ymap


smat = np.array([[1, 0],
                 [1, -1],
                 [-1, -1],
                 [1, 1]])


def paar(met):
    mat = np.copy(met)
    i, j = 4, 5
    ops = []
    while (i != j):
        # get weight foreach pair
        dist = np.tril(mat.T @ mat, k=-1)
        # indexes of max hamming of pair
        i, j = np.unravel_index(np.argmax(dist), dist.shape)
        new = mat[:, i] * mat[:, j]
        new_n = np.logical_not(new)
        mat[:, i] *= new_n
        mat[:, j] *= new_n
        mat = np.hstack((mat, new[:, None]))
        ops.append((i, j))
    ymap = np.nonzero(mat)[1]
    return ops[:-1], ymap


def simulsub(ops, x):
    for s, i, j in ops:
        if (s == 0):
            nu = x[i] + x[j]
        else:
            nu = x[i] - x[j]
        x = np.append(x, nu)
    return x


def fullsim(ops, ymap, x):
    h = simulsub(ops, x)
    return [(s**2) * h[i] for i, s in ymap]


def simuladd(ops, x):
    for i, j in ops:
        nu = x[i] + x[j]
        x = np.append(x, nu)
    return x


def decompose_layer(sw0):
    mat = np.sign(sw0)
    fmat = np.hstack((mat > 0, mat < 0)).astype(int)
    ops, ymap = paar(fmat)
    oops = list(chain.from_iterable(ops))
    return np.array(oops), ymap


def decompose_ter(sw0):
    mat = np.sign(sw0)
    ops, ymap = paar_ter(mat)
    oops = list(chain.from_iterable(ops))
    ym = [(i, np.real(s)) for i, s in ymap]
    ym = np.array(list(chain.from_iterable(ym))).astype("int")
    return np.array(oops), ym
