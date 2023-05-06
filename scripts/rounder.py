import numpy as np


# To break ties
def add_to_rows(x, y):
    mask = np.arange(x.shape[1]) < y[:, None]
    return x + mask


# Difference of sum to the winner's sum
def deltawin(x, y):
    q = np.take_along_axis(x, y[:, None], axis=1)
    x = x-q
    return add_to_rows(x, y)


# Returns table of whether each sample will be wrong
# after some mid bit goes up by 2
def newwins(dwin, w8s, y):
    y8s = np.take_along_axis(w8s[None, :], y[:, None, None], axis=2)
    y0s = y8s[:, :, 0]
    cube=w8s[None,:,:]-y0s[:,:,None]
    dragon=dwin[:,None,:] + 2*cube
    og = np.any(dragon>0,axis=2)
    return og


# How many samples are correct after adding 2
# to the k-th mid bit
# For verification of newwins
def blusko(k, lo, sw1, y):
    vv = np.zeros(40)
    vv[k] = 2
    med = lo[2] + vv
    hmm = med @ sw1
    pro = np.argmax(hmm,axis=1)
    return np.sum(pro==y)


# Minimum value of the output sum
# of a neuron for which it wins
# aka minimum value it needs to hold to compete
def minwin(l3, y):
    my_y = np.argmax(l3, axis=1)
    sum3 = (l3+40) / 2
    sumw = sum3[my_y == y, :]
    wy = y[my_y == y]
    minw = [min(sumw[wy == k, k]) for k in range(0, sumw.shape[1])]
    return minw


# Maximum value of outsum for which
# neuron can lose
# Max value it needs to hold to compete is this+1
def maxloss(l3, y):
    my_y = np.argmax(l3, axis=1)
    sum3 = (l3+40) / 2
    sumw = sum3[my_y == y, :]
    wy = y[my_y == y]
    maxl = [max(sumw[wy != k, k]) for k in range(0, sumw.shape[1])]
    return maxl


# Which samples stay unaffected by limiting
# accumulator to k bits with overflow stop
def capbits(l0, neur, k):
    gold = np.sign(l0 @ neur + 1e-5)
    wall = l0 * neur
    pcap = 2**(k-1) - 1
    ncap = -2**(k-1)
    j = np.zeros(wall.shape[0])
    for col in wall.T:
        j = j + col
        j = np.minimum(j, pcap)
        j = np.maximum(j, ncap)
    dut = np.sign(j + 1e-5)
    return gold == dut


# capbits with mean removal to center
# didnt perform
def capmeans(l0, neur, k):
    gold = np.sign(l0 @ neur + 1e-5)
    meen = np.round(np.mean(l0 @ neur))
    wall = l0 * neur
    pcap = 2**(k-1) - 1
    ncap = -2**(k-1)
    j = -meen * np.ones(wall.shape[0])
    for col in wall.T:
        j = j + col
        j = np.minimum(j, pcap)
        j = np.maximum(j, ncap)
    dut = np.sign(j + meen + 1e-5)
    return gold == dut


def upermeen(l0, neur):
    for i in range(1, 11):
        if (np.sum(capmeans(l0, neur, i)) == len(l0)):
            return i
    return 99


# Minimum bits accum needs to be correct
# with overflow stop
def upercut(l0, neur):
    for i in range(1, 11):
        if (np.sum(capbits(l0, neur, i)) == len(l0)):
            return i
    return 99


def upershift(l0, neur):
    for i in range(1, 11):
        if (np.sum(capshift(l0, neur, i)) == len(l0)):
            return i
    return 99


def meancaps(l0, sw0):
    sw0 = np.sign(sw0)
    return [upermeen(l0, neur) for neur in sw0.T]


# Min bits with overflow stop foreach neuron
def caps(l0, sw0):
    sw0 = np.sign(sw0)
    return np.array([upercut(l0, neur) for neur in sw0.T])


def laps(l0, sw0):
    sw0 = np.sign(sw0)
    return [upershift(l0, neur) for neur in sw0.T]


# capbits when all features are missing lsb
def capshift(l0, neur, k):
    gold = np.sign(l0 @ neur + 1e-5)
    ll = l0//2
    rem = np.mean(l0 % 2, axis=0) * neur
    srem = np.sum(rem)
    mold = np.round(srem/2)
    wall = ll * neur
    pcap = 2**(k-1) - 1
    ncap = -2**(k-1)
    j = np.zeros(wall.shape[0])
    for col in wall.T:
        j = j + col
        j = np.minimum(j, pcap)
        j = np.maximum(j, ncap)
    dut = np.sign(j + mold + 1e-5)
    return gold == dut
