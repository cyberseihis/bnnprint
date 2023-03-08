import binascii
import pandas as pd
import numpy as np
from dsedit import get_csv_filenames


def qnorm(Xa):
    return pd.DataFrame(Xa.apply(
                        lambda x: (x - np.min(x)) / (np.max(x) - np.min(x)))
                        ).fillna(0)


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


def write_strings_to_file(strings, file_path):
    with open(file_path, 'w') as file:
        for string in strings:
            file.write(string + '\n')


def csv_to_activations(fnm):
    df = pd.read_csv(fnm, header=None)
    df = df.iloc[:, :-1]
    hd4 = hexiby(df)
    write_strings_to_file(hd4, fnm+".activations")


def mnn():
    for fnm in get_csv_filenames():
        csv_to_activations(fnm)


def chknonan():
    for fnm in get_csv_filenames():
        df = pd.read_csv(fnm, header=None)
        print(f"{fnm} - {check_constant_columns(df)}")


def check_constant_columns(df):
    for col in df.columns:
        if df[col].nunique() == 1:
            return True
    return False
