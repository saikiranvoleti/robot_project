import csv
import json
from base64 import b64encode


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
