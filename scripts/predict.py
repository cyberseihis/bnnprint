from keras.models import load_model
import pandas as pd
import numpy as np
from qkeras import QActivation, QDense


def get_results(model_f, dset_f):
    df = pd.read_csv(dset_f, header=None)
    X = df.iloc[:, :-1]
    X = pd.DataFrame(X.apply(
        lambda x: (x - np.min(x)) / (np.max(x) - np.min(x))))
    model = load_model(
        model_f,
        custom_objects={'QActivation': QActivation, 'QDense': QDense})
    output = model.predict(X)
    clases = np.argmax(output, axis=1)
    return clases
