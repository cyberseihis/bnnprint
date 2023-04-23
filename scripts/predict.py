from keras.models import load_model
import pandas as pd
import numpy as np
from qkeras import QActivation, QDense
import keras.backend as K


def get_model(model_f):
    model = load_model(
        model_f,
        custom_objects={'QActivation': QActivation, 'QDense': QDense})
    return model


def preped_dset(dset_f):
    df = pd.read_csv(dset_f, header=None)
    X = df.iloc[:, :-1]
    y = df.iloc[:, -1]
    X = pd.DataFrame(X.apply(
        lambda x: (x - np.min(x)) / (np.max(x) - np.min(x))))
    return X, y


def get_results_f(model_f, dset_f):
    X, _ = preped_dset(dset_f)
    model = get_model(model_f)
    return get_results(model, X)


def get_results(model, X):
    output = model.predict(X)
    clases = np.argmax(output, axis=1)
    return clases


def get_layer_outputs(model, X):
    layer_outputs = [layer.output for layer in model.layers]
    layer_eval_fn = K.function(inputs=[model.input], outputs=layer_outputs)
    output_values = layer_eval_fn([X])
    return output_values


def winner_args(model, X, y):
    dut = get_results(model, X)
    if len(dut) != len(y):
        raise ValueError("Arrays must be the same length")
    equal_indexes = [i for i in range(len(y)) if y[i] == dut[i]]
    return X.iloc[equal_indexes]


def quant(x):
    kkk = (np.round(x*16)).astype(int) / 16
    kj = np.minimum(kkk, 15/16)
    return kj


def redo(model, X):
    ws = model.get_weights()
    sw0 = ws[0]
    sw1 = ws[1]
    l0 = quant(X)
    l1 = l0 @ sw0
    l2 = mysign(l1)
    l3 = l2 @ sw1
    return [l0, l1, l2, l3]


def mysign(a):
    signs = np.sign(a)
    signs_no_zero = np.where(signs == 0, 1, signs)
    return signs_no_zero
