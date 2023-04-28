import numpy as np


# To break ties
def add_to_rows(x, y):
    mask = np.arange(len(y)) < y[:, np.newaxis]
    return x + mask


def deltawin(x, y):
    idx = np.arange(y.size), y
    w = x[idx]
    w = w[:, np.newaxis]
    x = x-w
    return add_to_rows(x)
