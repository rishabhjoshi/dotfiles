
# Author : Rishabh Joshi
# Insti  : IISc, Bangalore

# This script created new tmux with panes and runs the command on them

import os, sys, pdb, numpy as np, random, argparse, codecs, pickle, time, json
import subprocess
from pprint import pprint
from collections import defaultdict as ddict
from joblib import Parallel, delayed
from pymongo import MongoClient
import argparse

parser = argparse.ArgumentParser(description='Sets up tmux with specified number of windows')
parser.add_argument('-session_name', default='execute_new')
parser.add_argument('-panes', default='24', type = int)
parser.add_argument('-cmd', required = True)
parser.add_argument('-port', default='6001')
args = parser.parse_args()

new_session = f'tmux new-session -d -s {args.session_name}',
rename_window = 'tmux rename-window \'new\''
new_pane = 'tmux split-window -h -d'
new_layout = 'tmux select-layout tiled'
#pane_space = f'tmux send-keys -t {args.session_name}:1 \"C-a =\" Enter'
#pane_space = f'tmux send-keys -t <F2> Enter'

subprocess.call(new_session, shell = True)
subprocess.call(rename_window, shell = True)

for i in range(args.panes):
    subprocess.call(new_pane, shell = True)
    subprocess.call(new_layout, shell = True)


#subprocess.call('tmux synchronize-panes')
#subprocess.call(f'tmux send-keys -t {args.session_name}:new.1 \"{args.cmd}\" Enter', shell = True)
for i in range(args.panes):
    subprocess.call(f'tmux send-keys -t {args.session_name}:new.{i+1} \"ssh n{i}\" Enter', shell = True)

for i in range(args.panes):
    if args.cmd == 'htop':
        cmd = args.cmd
    else :
        cmd = f'{args.cmd} --port {int(args.port) + i}'
    subprocess.call(f'tmux send-keys -t {args.session_name}:new.{i+1} \"{cmd}\" Enter', shell = True)
