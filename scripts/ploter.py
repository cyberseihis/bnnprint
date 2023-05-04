import pandas as pd
import matplotlib.pyplot as plt


def build_dataframe(data):
    # Get the list of unique row and column indexes
    rows = list(set([i for i, _, _ in data]))
    cols = list(set([j for _, j, _ in data]))
    
    # Create an empty dataframe with named indexes
    df = pd.DataFrame(index=rows, columns=cols)
    
    # Fill in the dataframe with the values from the input data
    for i, j, v in data:
        df.loc[i, j] = v
    
    return df


def data_in(fname):
    df = pd.read_csv(fname, header=None, skipinitialspace=True).values.tolist()
    ars = []
    prs = []
    for dname, area, power in df:
        dset, _, design = dname.split("_")
        ars.append((dset, design, area))
        prs.append((dset, design, power))
    return ars, prs


def plot_compare(fname):
    ars, prs = data_in(fname)
    ars = build_dataframe(ars)
    prs = build_dataframe(prs)
    ax = ars.plot(kind="bar")
    px = prs.plot(kind="bar")
    ax.set_ylabel('Area')
    px.set_ylabel('Power')
    ax.set_title("Area comparison")
    px.set_title("Power comparison")
    plt.show()
