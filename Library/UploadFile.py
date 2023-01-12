import requests


def post_file(url, endpoint, filepath):
    url = url + endpoint
    payload = {}
    files = [
        ('file',
         ('data.csv', open(filepath, 'rb'), 'text/csv'))
    ]
    headers = {
        'Accept': '*/*'
    }
    response = requests.request("POST", url, headers=headers, data=payload, files=files)
    print(response.content)
    return response

#
# post_file('http://localhost:8080', '/calculator/uploadLargeFileForInsertionToDatabase',
#           '/Users/saikiranvoleti/PycharmProjects/robot_project/Tests/invalid_dataset.csv')
