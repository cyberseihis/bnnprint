from tensorflow import keras
from tensorflow.keras import layers
from keras_tuner import HyperParameters
import keras_tuner as kt
from tensorflow.keras.utils import to_categorical

import numpy as np
import pandas as pd
import os

# data and metric imports
import sklearn.model_selection
import sklearn.datasets
import sklearn.metrics


def build_model(input_shape, output_shape, hp):
    model = keras.Sequential()
    model.add(layers.Dense(units=10, input_shape=(input_shape,)))
    model.add(layers.BatchNormalization(scale=False))
    model.add(layers.Activation('relu'))
    model.add(layers.Dense(units=output_shape))
    model.add(layers.Activation('softmax'))

    model.compile(
        optimizer=keras.optimizers.Adam(
            hp.Float("learning_rate", min_value=0.001, max_value=0.02)),
        loss='categorical_crossentropy',
        metrics=['accuracy'])
    return model


def train_csv(fname):
    df = pd.read_csv(fname, header=None)
    X = df.iloc[:, :-1]
    y = df.iloc[:, -1]
    X = pd.DataFrame(X.apply(lambda x: (x - np.min(x)) / (np.max(x) - np.min(x))))
    X_train, X_test, y_train, y_test = \
        sklearn.model_selection.train_test_split(X, y, test_size=0.3, random_state=42)
    (_, input_shape) = X.shape
    output_shape = y.nunique()
    y_train = to_categorical(y_train, num_classes=output_shape)
    y_test = to_categorical(y_test, num_classes=output_shape)

    def my_builder(hp):
        return build_model(input_shape, output_shape, hp)

    tuna = kt.BayesianOptimization(
        hypermodel=my_builder,
        objective="val_accuracy",
        max_trials=20,
        project_name="proj"+fname
    )
    early_stop = keras.callbacks.EarlyStopping(monitor='val_loss', patience=5)
    tuna.search(X_train, y_train, epochs=50, validation_data=(X_test, y_test), callbacks=[early_stop])
    print(fname+"summary")
    tuna.results_summary()
    model = tuna.get_best_models(num_models=1)[0]
    model.save(fname+"fptuner.h5")
    model.evaluate(X_test, y_test)
