import requests, datetime, sys, randomname, os
from akamai.edgegrid import EdgeGridAuth

c_secret = os.getenv('c_secret')
host = os.getenv('host')
a_token = os.getenv('a_token')
c_token = os.getenv('c_token')
eh_name = os.getenv('eh_name')

print(f'c_secret= {c_secret}')
print(eh_name)
print('----')