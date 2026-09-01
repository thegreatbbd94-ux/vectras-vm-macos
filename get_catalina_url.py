import sys
from urllib.request import Request, urlopen

headers = {
    'Host': 'osrecovery.apple.com',
    'Connection': 'close',
    'User-Agent': 'InternetRecovery/1.0',
}

req = Request('http://osrecovery.apple.com/', headers=headers)
resp = urlopen(req)
cookie = None
for k, v in resp.info().items():
    if k.lower() == 'set-cookie':
        for c in v.split('; '):
            if c.startswith('session='):
                cookie = c
                break

post_data = 'cid=0123456789ABCDEF\nsn=00000000000KXPG00\nbid=Mac-7BA5B2DFE22DDD8C\nk=0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF\nfg=0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF\nos=default'
headers['Cookie'] = cookie
headers['Content-Type'] = 'text/plain'

req2 = Request('http://osrecovery.apple.com/InstallationPayload/RecoveryImage', headers=headers, data=post_data.encode())
resp2 = urlopen(req2)
print(resp2.read().decode('utf-8'))
