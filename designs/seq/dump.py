import subprocess
import os

datasets = [
    "cardio",
    "gasId",
    "Har",
    "pendigits",
    "winequality_red",
    "winequality_white"]


def replace_string_in_file(
        input_file_path, search_string, replace_string, output_file_path):
    with open(input_file_path, 'r') as input_file:
        content = input_file.read()

    modified_content = content.replace(search_string, replace_string)

    with open(output_file_path, 'w') as output_file:
        output_file.write(modified_content)


def write_cmdfile(datasetname):
    replace_string_in_file(
        "template.cmd", "DATASETNAME", datasetname, "cmdfile.cmd")


def mk_dut(name):
    cmd = f"iverilog -c cmdfile.cmd -y ../argmax/ " \
        f"wrap_seq_bnn.v -o bnndumpster/{name}_bs.v -E"
    res = subprocess.check_output(cmd, shell=True)
    print(res)


def mk_tb(name):
    cmd = f"iverilog -c cmdfile.cmd " \
        f"tbwrap_seq_bnn.v -o bnndumpster/tb{name}_bs.v -E"
    res = subprocess.check_output(cmd, shell=True)
    print(res)


def mk_dump(name):
    write_cmdfile(name)
    mk_dut(name)
    mk_tb(name)


def dump_all():
    for dset in datasets:
        mk_dump(dset)
