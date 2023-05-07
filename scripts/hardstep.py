import numpy as np


def layestep(mat, widicts):
    neus = [neursw(i, a, widicts[i]) for i, a in enumerate(mat)]
    bod = '\n'.join(neus)
    return bod


def neursw(i, weighs, wdict):
    if (np.max(weighs) <= 0):
        return f"assign hidden[{i}] = 0;"
    if (np.min(weighs) >= 0):
        return f"assign hidden[{i}] = 1;"
    steps = [neurstep(i, j, weighs, ind, wid) for j, (wid, ind)
             in enumerate(wdict.items())]
    stair = "\n".join(steps)
    return f"""{stair}
    assign hidden[{i}] = intra_{i}_{len(wdict)-1} >= 0;"""


def neurstep(i, j, weights, indices, wid):
    war = weights[indices]
    bodp = ' '.join([cel(i, a) for i, a in zip(indices, war)])
    if (j > 0):
        prev = f" + intra_{i}_{j-1}"
    else:
        prev = ""
    al = f"""
    wire signed [{wid-1}:0] intra_{i}_{j};
    assign intra_{i}_{j} = {bodp}{prev};"""
    return al


def cel(i, w):
    if (w == 0):
        return ""
    oper = '+' if w == 1 else '-'
    return f"{oper} feature_array[{i}]"
