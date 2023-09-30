import re


def read_ints(file_path):
    with open(file_path, 'r') as file:
        return [int(match) for match in re.findall(r'\b\d+\b', file.read())]


gol = read_ints("cardioS.res")
dut = read_ints("tests/vcardio_bnn1_bnnrospine.tst")
