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
parser.add_argument('-disk',        default= 100,    type = int, help = 'Disk Usage Threshold in GB')
parser.add_argument('-disk_time',   default= 1800,   type = int, help = 'Time to remind Disk in sec')

args = parser.parse_args()
channel = '#alerts'
username = 'webhookbot'
icon_emoji = ':bangbang:'
f = open('slack_url_file.txt')
for line in f:
    slackURL = line
f.close()
#slackURL = ''

DISK_THRESH = args.disk
DISK_REMINDER_TIME = args.disk_time
ONEG = 1024*1024*1024

while True:
    if psutil.disk_usage('/scratchd/')[2] <= DISK_THRESH * ONEG:
        used = psutil.disk_usage('/scratchd/')[2]
        text = 'Scratchd disk nearly full. {0:.2f} GB Remaining'.format(used / 1e9)
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
                time.sleep(DISK_REMINDER_TIME)
    else: 
        time.sleep(60)
