import csv
import json
import string

import pandas as pd
from jsonpath_ng.ext import parse
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager


def read_from_csv_file(filename):
    jsonArray = []
    file = open(filename, 'r')
    csvfile = csv.DictReader(file)
    for row in csvfile:
        jsonArray.append(row)
    json_ = json.dumps(jsonArray)
    file.close()
    return json_


def read_csv_file(filename):
    file = open(filename, 'r')
    csvfile = csv.reader(file)
    return [row for row in csvfile]


def get_column_count(filePath, columnName):
    df2 = pd.read_csv(filePath)
    count = df2[columnName].count()
    print(count)
    return count


def get_column_sum(filePath, columnName):
    df2 = pd.read_csv(filePath)
    sum_ = df2[columnName].sum()
    print(sum_)
    return sum_


def get_chromedriver_path():
    driver_path = ChromeDriverManager().install()
    print(driver_path)
    return driver_path


def verify_mask(value):
    flag = True

    if len(value) > 4:
        sub_str = value[4:]
        print(sub_str)
        for str_ in sub_str:
            if str_ != '$':
                flag = False
                break
        print(flag)
    return flag
