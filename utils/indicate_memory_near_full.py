
# Author : Rishabh Joshi
# Insti  : IISc, Bangalore

# RUn this script to indicate when memory at the current server is nearly full

import psutil
import subprocess
import time
import argparse
import requests
import json

parser = argparse.ArgumentParser(description='')
parser.add_argument('-server',      default= 'dosa',             help = 'Server running the script')
parser.add_argument('-ram',         default= 98,     type = int, help = 'Ram Percentage Threshold')
parser.add_argument('-ram_time',    default= 600,    type = int, help = 'Time to remind Ram in sec')

args = parser.parse_args()
channel = '#general'
username = 'webhookbot'
icon_emoji = ':bangbang:'
f = open('slack_url_file.txt')
for line in f:
    slackURL = line
f.close()
#slackURL = ''

RAM_THRESH = args.ram
RAM_REMINDER_TIME = args.ram_time
ONEG = 1024*1024*1024

while True:
    if psutil.virtual_memory()[2] >= RAM_THRESH:
        # subprocess.call("curl -H \"Content-type: application/json\" --data \"{} in danger\" http://10.24.28.211:9999/jobComplete".format(args.server),
                # shell = True)
        # time.sleep(2)
        available = psutil.virtual_memory()[1] / ONEG
        total = psutil.virtual_memory()[0] / ONEG
        text = '{}\'s Memory nearly full. {:.2f}GB of {:.2f}GB available'.format(args.server, available, total)
        data = {
                'channel' : channel,
                'username': username,
                'text': text,
                'icon_emoji' : icon_emoji
        }
        req = requests.post(slackURL, data = json.dumps(data), headers = {'Content-Type': 'application/json'})
        if req.status_code != 200:
                raise ValueError(
                        'Request to slack returned an error %s, the response is:\n%s'
                        % (req.status_code, req.text)
                )
                continue
        else:
                time.sleep(RAM_REMINDER_TIME)

    else: 
        time.sleep(60)
