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


def csv_to_tbparams(fnm):
    df = pd.read_csv(fnm, header=None)
    dy = df.iloc[:, -1]
    df = df.iloc[:, :-1]
    C = dy.nunique()
    Ts, N = df.shape
    Ts = min(Ts,1000)
    M = 40
    B = 4
    paramN = f"parameter FEAT_CNT = {N},"
    paramM = f"parameter HIDDEN_CNT = {M},"
    paramC = f"parameter CLASS_CNT = {C},"
    paramB = f"parameter FEAT_BITS = {B},"
    paramTs = f"parameter TEST_CNT = {Ts}"
    params = [paramN, paramM, paramB, paramC, paramTs]
    hd4 = hexiby(df)
    hd5 = [f"assign testcases[{i}] = {len(a)*4}'h{a};"
           for i, a in enumerate(hd4[0:Ts])]
    write_strings_to_file(hd5, "tbparams/"+fnm+".tbp")
    write_strings_to_file(params, "tbparams/"+fnm+".par")
    # print(tbpr, "tbparams/"+fnm+".tbp")


def mnn():
    for fnm in get_csv_filenames():
        csv_to_activations(fnm)


def save_tbparams():
    for fnm in get_csv_filenames():
        csv_to_tbparams(fnm)


def chknonan():
    for fnm in get_csv_filenames():
        df = pd.read_csv(fnm, header=None)
        print(f"{fnm} - {check_constant_columns(df)}")


def check_constant_columns(df):
    for col in df.columns:
        if df[col].nunique() == 1:
            return True
    return False
