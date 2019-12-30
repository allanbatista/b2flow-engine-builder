#!/usr/bin/env python
import os, sys, json, requests, logging

# Debug logging
logging.basicConfig()
logging.getLogger().setLevel(logging.DEBUG)
req_log = logging.getLogger('requests.packages.urllib3')
req_log.setLevel(logging.DEBUG)
req_log.propagate = True

callback = os.environ.get('B2FLOW__BUILDER__CALLBACK__URI')

if callback is None:
    print("No Callback defined")
    exit(0)

status_code = sys.argv[1]
log_file = sys.argv[2]

data = {
    'success': status_code == 0,
    'status_code': status_code,
    'log': open(log_file, 'r').read()
}

print("callback")
print(f"POST {callback}")
print(json.dumps(data))

requests.post(callback, json=data)
