import base64
import sys
import os

import shodan
import pymmh3 as mmh3
import requests

url = f'{sys.argv[1]}/favicon.ico'

try:
    content = requests.get(url).content
except Exception as e:
    print(e.message)
    os.exit(1)

h = mmh3.hash(base64.encodebytes(content))
print(f'http.favicon.hash:{h}')

api_key = os.getenv('API_KEY', '')
if api_key != '':
    api = shodan.Shodan(api_key)
    count = api.count(f'http.favicon.hash:{h}')
    print(f'count: {count.get("total", "not available")}')
