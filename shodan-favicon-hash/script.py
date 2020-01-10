import pymmh3 as mmh3
import requests
import base64
import sys

url = "{}/favicon.ico".format(sys.argv[1])

try:
    content = requests.get(url).content
except Exception as e:
    print(e.message)
    os.exit(1)

print(mmh3.hash(base64.encodebytes(content)))
