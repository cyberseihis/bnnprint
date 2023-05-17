import numpy as np


def paar(mat):
    # get weight foreach pair
    dist = np.tril(mat.T @ mat, k=-1)
    i, j = np.unravel_index(np.argmax(dist), dist.shape)
    new = mat[:, i] * mat[:, j]
    new_n = np.logical_not(new)
    mat[:, i] *= new_n
    mat[:, j] *= new_n
    mat = np.hstack((mat, new[:, None]))
    return i, j, mat


mat = np.array(
    [[1, 1, 0, 0],
     [1, 1, 1, 0],
     [1, 1, 1, 1],
     [0, 1, 1, 1]]
)
