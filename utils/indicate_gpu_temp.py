
# Author : Rishabh Joshi
# Insti  : IISc, Bangalore

import GPUtil as gputil
import subprocess
import requests
import json, time
import argparse
from subprocess import Popen, PIPE
import os
import numpy as np

parser = argparse.ArgumentParser(description='Check for GPU temperature')
parser.add_argument('-server',      default= 'dosa',             help = 'Server running the script', required = True)
parser.add_argument('-thresh', default=80, type = int, help = 'GPU temperature in Celsius')
parser.add_argument('-gputime', default=600, type = int, help = 'GPU reminder time')
args = parser.parse_args()

MAX_TEMP = args.thresh
GPU_REMINDER_TIME = args.gputime

channel = '#general'
username = 'webhookbot'
icon_emoji = ':bangbang:'
f = open('slack_url_file.txt')
for line in f:
    slackURL = line
f.close()

def safeFloatCast(strNumber):
    try:
        number = float(strNumber)
    except ValueError:
        number = float('nan')
    return number

def getGPUTemp():
    # Get ID, processing and memory utilization for all GPUs
    p = Popen(["nvidia-smi","--query-gpu=index,uuid,utilization.gpu,memory.total,memory.used,memory.free,driver_version,name,gpu_serial,display_active,display_mode,temperature.gpu", "--format=csv,noheader,nounits"], stdout=PIPE)
    output = p.stdout.read().decode('UTF-8')
    # output = output[2:-1] # Remove b' and ' from string added by python
    #print(output)
    ## Parse output
    # Split on line break
    lines = output.split(os.linesep)
    #print(lines)
    numDevices = len(lines)-1
    deviceIds = np.empty(numDevices,dtype=int)
    gpuUtil = np.empty(numDevices,dtype=float)
    memTotal = np.empty(numDevices,dtype=float)
    memUsed = np.empty(numDevices,dtype=float)
    memFree = np.empty(numDevices,dtype=float)
    temp = np.empty(numDevices,dtype=int)
    driver = []
    GPUs = []
    for g in range(numDevices):
        line = lines[g]
        #print(line)
        vals = line.split(', ')
        #print(vals)
        for i in range(12):
            # print(vals[i])
            if (i == 0):
                deviceIds[g] = int(vals[i])
            elif (i == 1):
                uuid = vals[i]
            elif (i == 2):
                gpuUtil[g] = safeFloatCast(vals[i])/100
            elif (i == 3):
                memTotal[g] = safeFloatCast(vals[i])
            elif (i == 4):
                memUsed[g] = safeFloatCast(vals[i])
            elif (i == 5):
                memFree[g] = safeFloatCast(vals[i])
            elif (i == 6):
                driver = vals[i]
            elif (i == 7):
                gpu_name = vals[i]
            elif (i == 8):
                serial = vals[i]
            elif (i == 9):
                display_active = vals[i]
            elif (i == 10):
                display_mode = vals[i]
            elif (i == 11):
                temp[g] = vals[i]
        #GPUs.append(GPU(deviceIds[g], uuid, gpuUtil[g], memTotal[g], memUsed[g], memFree[g], driver, gpu_name, serial, display_mode, display_active))
    #return GPUs  # (deviceIds, gpuUtil, memUtil)	
    return deviceIds, temp

while True: 
    deviceIds, temps = getGPUTemp()
    for devId in range(len(deviceIds)):
        temp = temps[devId]
        if temp > MAX_TEMP:
            text = '{}\'s GPU #{}\'s temperature is {} degrees.'.format(args.server, devId, temp)
            data = {
                    'channel' : channel,
                    'username': username,
                    'text'    : text,
                    'icon_emoji': icon_emoji
            }
            req = requests.post(slackURL, data = json.dumps(data), headers = {'Content-Type': 'application/json'})
            if req.status_code != 200:
                raise ValueError(
                        'Request to slack returned an error %s, the response is:\n%s'
                        % (req.status_code, req.text)
                )
    time.sleep(GPU_REMINDER_TIME)

