import pickle as pk
import numpy as np
weights = pk.load(open("pendigit_weights.pk", "rb"))
w1 = weights["W1"]
activs = [80, 100, 18, 98, 60, 66, 100, 29, 42,  0,  0, 23, 42, 61, 56, 98]
activs = np.array(activs)
wi = np.array(w1)*2-1
layer = wi.T @ activs
print(layer)
