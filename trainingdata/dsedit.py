import pandas as pd
import numpy as np
import os


def replace_with_index(df):
    column_name = df.columns[-1]
    unique_values = df[column_name].unique()
    sorted_unique_values = np.sort(unique_values)
    assoc_list = enumerate(sorted_unique_values)
    value_to_index = {value: index for index, value in assoc_list}
    df[column_name] = df[column_name].map(value_to_index)
    return df


def get_csv_filenames():
    filenames = os.listdir()
    csv_filenames = [filename for filename in filenames if filename.endswith(".csv")]
    return csv_filenames


def modify_and_save_csv(filename, modify_func):
    df = pd.read_csv(filename, header=None)
    df = modify_func(df)
    df.to_csv(filename, index=False, header=False)


def norm_labels():
    for fname in get_csv_filenames():
        modify_and_save_csv(fname, replace_with_index)


def normalize_df(df):
    df_without_last = df.iloc[:, :-1].apply(lambda x: (x - np.min(x)) / (np.max(x) - np.min(x)))
    return df_without_last, df.iloc[:, -1]

def split_and_normalize_df(df):
    df_without_last, df_last = normalize_df(df)
    return pd.DataFrame(df_without_last), pd.DataFrame(df_last)
