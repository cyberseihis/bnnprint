import numpy as np


# To break ties
def add_to_rows(x, y):
    mask = np.arange(x.shape[1]) < y[:, None]
    return x + mask


def deltawin(x, y):
    q = np.take_along_axis(x, y[:, None], axis=1)
    x = x-q
    return add_to_rows(x, y)


def newwins(dwin, w8s, y):
    y8s = np.take_along_axis(w8s[None, :], y[:, None, None], axis=2)
    y0s = y8s[:, :, 0]
    cube=w8s[None,:,:]-y0s[:,:,None]
    dragon=dwin[:,None,:] + 2*cube
    og = np.any(dragon>0,axis=2)
    return og


def blusko(k, lo, sw1, y):
    vv = np.zeros(40)
    vv[k] = 2
    med = lo[2] + vv
    hmm = med @ sw1
    pro = np.argmax(hmm,axis=1)
    return np.sum(pro==y)


def minwin(l3, y):
    my_y = np.argmax(l3, axis=1)
    sum3 = (l3+40) / 2
    sumw = sum3[my_y == y, :]
    wy = y[my_y == y]
    minw = [min(sumw[wy == k, k]) for k in range(0, sumw.shape[1])]
    return minw


def maxloss(l3, y):
    my_y = np.argmax(l3, axis=1)
    sum3 = (l3+40) / 2
    sumw = sum3[my_y == y, :]
    wy = y[my_y == y]
    maxl = [max(sumw[wy != k, k]) for k in range(0, sumw.shape[1])]
    return maxl
