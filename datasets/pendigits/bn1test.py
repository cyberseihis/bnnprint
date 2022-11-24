import pickle as pk
import numpy as np
import layer1print as lp


def dict_to_threshhold(w: dict):
    b = w["beta"]
    si = w["mvar"]
    mu = w["mmean"]
    thr = -b * np.sqrt(si) + mu
    ithr = np.floor(thr).astype("int")
    return ithr


def single_line(i, thr, bw):
    ar = lp.activ_repr(i, bw)
    op = "assign o["+str(i)+"] = $signed("+ar+") > "+str(thr)+";"
    return op


def thresh_to_operations(thr, bit_width):
    ops = [single_line(i, x, bit_width) for i, x in enumerate(thr)]
    return '\n'.join(ops)


def dict_to_module(weight_dict: dict, bit_width: int):
    thrs = dict_to_threshhold(weight_dict)
    ops = thresh_to_operations(thrs, bit_width)
    in_len = len(thrs)
    mod_intro = ("module bnorm(input [" +
                 lp.indx(0, bit_width * in_len) +
                 "] a, output ["+lp.indx(0, in_len)+"] o);")
    mod = '\n'.join([mod_intro, ops, "endmodule"])
    return mod


def merged_ops(thrs, mac):
    x = [f"assign t[{i}] = {m};assign o[{i}] = {t} < t[{i}];"
         for i, (t, m) in enumerate(zip(thrs, mac))]
    return x


def dict_to_merged(bnorm_weight_dict: dict, mac_weights, bit_width: int):
    thrs = dict_to_threshhold(bnorm_weight_dict)
    mac = map(' '.join, lp.pure_ops(mac_weights))
    ops = merged_ops(thrs, mac)
    in_len = len(thrs)
    mod_intro = ("module demox(input [" +
                 lp.indx(0, bit_width * in_len) +
                 "] a, output ["+lp.indx(0, in_len)+"] o);")
    mod = '\n'.join([mod_intro, *ops, "endmodule"])
    return mod


if __name__ == "__main__":
    weights = pk.load(open("pendigit_weights.pk", "rb"))
    w = weights["BW1"]
    # thr = dict_to_module(w, 11)
    xx = dict_to_merged(w, weights["W1"], 7)
    print(xx)
