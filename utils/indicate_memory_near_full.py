
# Author : Rishabh Joshi
# Insti  : IISc, Bangalore

# RUn this script to indicate when memory at the current server is nearly full

import psutil
import subprocess
import time
import argparse

parser = argparse.ArgumentParser(description='')
parser.add_argument('-server', default='dosa')
args = parser.parse_args()

while True:
    if psutil.virtual_memory()[2] > 97:
        subprocess.call("curl -H \"Content-type: application/json\" --data \"{} in danger\" http://10.24.28.211:9999/jobComplete".format(args.server),
                shell = True)
        time.sleep(2)
    else: 
        time.sleep(60)
