import numpy as np
from python_tsp.heuristics import solve_tsp_local_search


# Should take weights and reorder so similar
# l1 neurons correspond to similar indices/counter values
# in hopes it simplifies lut logic
def reorg(sw0, sw1):
    # assuming neuron is row and sign
    distance_matrix = dist_mat(sw0)
    bclks = binclk(sw0.shape[0])
    dclks = dist_mat(bclks)
    permutation, _ = solve_tsp_local_search(distance_matrix)
    permclks, _ = solve_tsp_local_search(dclks)
    # Combine permutations
    # Mostly sure but not completely
    invclk = inv_perm(permclks)
    trueperm = np.array(permutation)[invclk]
    nw0 = sw0[trueperm]
    nw1 = sw1[:, trueperm]
    return nw0, nw1, trueperm


def dist_mat(mat):
    return np.array(np.sum(mat[:, np.newaxis] != mat[np.newaxis, :], axis=-1))


def binclk(n):
    x1 = [bin(i)[2:].zfill(6) for i in range(0, n)]
    x2 = [list(map(int, x)) for x in x1]
    return np.array(x2)


def inv_perm(perm):
    return [perm.index(i) for i in range(len(perm))]
