import numpy as np
from python_tsp.heuristics import solve_tsp_local_search


# Should take weights and reorder so similar
# l1 neurons correspond to similar indices/counter values
# in hopes it simplifies lut logic
def reorg(sw0, sw1):
    # assuming neuron is row and sign
    distance_matrix = dist_mat(sw0)
    permutation, _ = solve_tsp_local_search(distance_matrix)
    nw0 = sw0[permutation]
    nw1 = sw1[:, permutation]
    return nw0, nw1


def dist_mat(mat):
    return np.sum(mat[:, np.newaxis] != mat[np.newaxis, :], axis=-1)
