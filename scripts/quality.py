import re
import os


def get_numbers_from_file(filename):
    numbers = []
    with open(filename, 'r') as f:
        file_content = f.read()
        number_strings = re.findall(r'\d+', file_content)
        numbers = [int(num) for num in number_strings]
    return numbers


def compare_numbers_in_files(file1, file2):
    nums1 = get_numbers_from_file(file1)
    nums2 = get_numbers_from_file(file2)

    # resize the arrays to be the length of the shorter one
    min_len = min(len(nums1), len(nums2))
    nums1 = nums1[:min_len]
    nums2 = nums2[:min_len]

    # compare the arrays
    if nums1 == nums2:
        print("The arrays are equal.")
    else:
        print("The arrays differ at the following positions:")
        for i in range(min_len):
            if nums1[i] != nums2[i]:
                print(f"Index {i}: {nums1[i]} (from {file1}) vs {nums2[i]} (from {file2})")


def get_testsn(folder_path):
    filenames = os.listdir(folder_path)
    result = []
    for filename in filenames:
        name_parts = filename.split("_")
        if len(name_parts) > 2:
            dset = name_parts[0][1:]
            typee = name_parts[1]
            gold_path = f"../models/{typee}/results/results_{dset}.results"
            dut_path = folder_path + filename
            result.append((dut_path, gold_path))
    return result


def allright(design):
    test_folder = f"../designs/{design}/tests/"
    x = get_testsn(test_folder)
    for i, j in x:
        compare_numbers_in_files(i, j)
