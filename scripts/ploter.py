import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D


def build_dataframe(data):
    # Get the list of unique row and column indexes
    rows = list(set([i for i, _, _ in data]))
    cols = list(set([j for _, j, _ in data]))
    df = pd.DataFrame(index=rows, columns=cols)
    for i, j, v in data:
        df.loc[i, j] = v
    df = df.sort_index()
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
    return ars, prs


def scatter_comp(fname, designs):
    ars, prs = data_in(fname)
    ars = build_dataframe(ars)
    prs = build_dataframe(prs)
    marker_styles = ['o', 's', 'D', '^', 'v', 'p']
    colors = ['red', 'blue', 'green', 'purple']
    legend_elements = []
    for i, dataset in enumerate(ars.index):
        marker = marker_styles[i % len(marker_styles)]
        legend_elements.append(Line2D([0], [0], marker=marker, color='w', label=dataset, markerfacecolor='black', markersize=8))
    for j, accelerator in enumerate(designs):
        color = colors[j % len(colors)]
        legend_elements.append(Line2D([0], [0], marker='o', color='w', label=accelerator, markerfacecolor=color, markersize=8))
# Assuming 'df' is your dataframe containing the data
    for i, dataset in enumerate(ars.index):
        for j, accelerator in enumerate(designs):
            area = ars.loc[dataset, accelerator]
            power = prs.loc[dataset, accelerator]
            plt.scatter(power, area,
                        marker=marker_styles[i], color=colors[j])

# Add legend
    plt.legend(handles=legend_elements)

# Set axis labels
    plt.xlabel('Power')
    plt.ylabel('Area')

# Add a title
    plt.title(f"{designs[0]} vs {designs[1]}")

    desmerg = '_'.join(designs)
    plt.savefig(f"{desmerg}.svg")


def tablecomp(fn, designs):
    ars, prs = data_in(fn)
    ars = build_dataframe(ars)/10**8
    prs = build_dataframe(prs)*10**3
    ars = ars.loc[:, designs].astype("float").round(2)
    prs = prs.loc[:, designs].astype("float").round(2)
    ars = ars.add_suffix(" area")
    prs = prs.add_suffix(" power")
    da = 100*(ars.iloc[:, 1] - ars.iloc[:, 0])/ars.iloc[:, 0]
    dp = 100*(prs.iloc[:, 1] - prs.iloc[:, 0])/prs.iloc[:, 0]
    ars["area change"] = ["{:+.1f}%".format(val) for val in da]
    prs["power change"] = ["{:+.1f}%".format(val) for val in dp]
    res = pd.concat([ars, prs], axis=1).to_markdown()
    desmerg = '_'.join(designs)
    with open(f"{desmerg}tab.md", "w") as f:
        f.write(res)
    print(res)
