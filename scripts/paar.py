import numpy as np


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


def simuladd(ops, x):
    for i, j in ops:
        nu = x[i] + x[j]
        x = np.append(x, nu)
    return x


met = np.array(
    [[1, 1, 0, 0],
     [1, 1, 1, 0],
     [1, 1, 1, 1],
     [0, 1, 1, 1]]
)
