
# Author : Rishabh Joshi
# Insti  : IISc, Bangalore

# RUn this script to indicate when memory at the current server is nearly full

import psutil
import subprocess

while True:
    if psutil.virtual_memory()[2] > 98:
        subprocess.call("curl -h \"Content-type: application/json\" --data \"Done\" http://10.24.28.211:9999/jobComplete",
                shell = True)
