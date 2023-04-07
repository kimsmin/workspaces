import requests
from akamai.edgegrid import EdgeGridAuth
from urllib.parse import urljoin

host = 'akab-omo2alokxehw6u75-g5fsb3ceydj7ikva.luna.akamaiapis.net'
baseurl = 'https://'+ host +'/'
s = requests.Session()
s.auth = EdgeGridAuth(
    client_secret='hu2weHR8RptSexLjDYbuYwj1RgWkRMM+tH+6WhsF/KI=',
    access_token='akab-habkuhimfz3hxeoq-ylvbsfsbdbmzmxgm',
    client_token='akab-j7sjpxb2gs3t54ee-3x6xfoy4rtgpcezb'
)

result = s.get(urljoin(baseurl, '/contract-api/v1/contracts/identifiers'))
print(result.status_code)
print(result.json())