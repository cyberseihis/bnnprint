from autoPyTorch.api.tabular_classification import TabularClassificationTask
import numpy as np
import pandas as pd
import os

# data and metric imports
import sklearn.model_selection
import sklearn.datasets
import sklearn.metrics


def get_csv_filenames():
    filenames = os.listdir()
    csv_filenames = [filename for filename in filenames if filename.endswith(".csv")]
    return csv_filenames


def train_all():
    for fname in get_csv_filenames():
        auto_full_pre(fname)


def auto_full_pre(fname):
    df = pd.read_csv(fname, header=None)
    X_train, X_test, y_train, y_test = \
        sklearn.model_selection.train_test_split(df.iloc[:, :-1], df.iloc[:, -1], random_state=1)

# initialise Auto-PyTorch api
    api = TabularClassificationTask()

# Search for an ensemble of machine learning algorithms
    api.search(
        X_train=X_train,
        y_train=y_train,
        X_test=X_test,
        y_test=y_test,
        optimize_metric='accuracy',
        total_walltime_limit=300,
        func_eval_time_limit_secs=50
    )

# Calculate test accuracy
    y_pred = api.predict(X_test)
    score = api.score(y_pred, y_test)
    print(fname, " Accuracy score", score)
