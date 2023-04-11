import requests, datetime, sys, randomname
from akamai.edgegrid import EdgeGridAuth

if len(sys.argv) > 1:
    c_secret = sys.argv[1]
    host = sys.argv[2]
    a_token = sys.argv[3]
    c_token = sys.argv[4]
    
else:
    print('Usage: createEdgehostname.py client_secret host access_token client_token eh_name')
    exit()

# host = 'akab-omo2alokxehw6u75-g5fsb3ceydj7ikva.luna.akamaiapis.net'
baseurl = 'https://'+ host +'/'
url = baseurl + '/papi/v1/edgehostnames' + "?contractId=ctr_V-41DUHPB&groupId=grp_232865"
domainPrefix = str(datetime.datetime.now().strftime("%y%m%d%H%M%S")) + "-" + randomname.get_name() + ".akamai-lab.com"
s = requests.Session()
s.auth = EdgeGridAuth(
    client_secret=c_secret,
    access_token=a_token,
    client_token=c_token
)

payload = {
    "domainPrefix": domainPrefix,
    "domainSuffix": "edgesuite.net",
    "ipVersionBehavior": "IPV6_COMPLIANCE",
    "productId": "prd_Fresca"
}
headers = {
    "accept": "application/json",
    "content-type": "application/json"
}

result = s.post(url, json=payload, headers=headers)
# print(result.status_code)
# print(result.json())
if result.status_code == 201:
    print(f'Congrats! {domainPrefix}.edgesuite.net is created.')
else:
    print('Sorry. We could not create a new edge hostname.')