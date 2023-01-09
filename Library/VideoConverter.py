import base64
import json
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager


def convert_video(filePath, payload):
    with open(filePath, "wb") as fd:
        data = json.loads(payload.replace("\'", "\""))
        fd.write(base64.b64decode(data['value']))

def startbrowser():
    driver = webdriver.Chrome(ChromeDriverManager().install())
