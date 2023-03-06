import binascii
import pandas as pd
import numpy as np


def qnorm(Xa):
    return pd.DataFrame(Xa.apply(
                        lambda x: (x - np.min(x)) / (np.max(x) - np.min(x))))


def qfour(Xa):
    Xc = qnorm(Xa)
    Xb = np.round(Xc*16).astype(int)
    return np.minimum(15, Xb)


def hexdump4(X):
    N = X.astype(np.uint8).tobytes()
    return binascii.hexlify(N).decode()[1::2]


def hexiby(X):
    Y = [row.to_numpy() for index, row in qfour(X).iterrows()]
    return [hexdump4(x) for x in Y]
