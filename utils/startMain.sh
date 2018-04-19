#!/usr/bin/zsh

tmux send-keys -Rt main:htops.1 C-c Enter
tmux send-keys -t main:htops.1 puri Enter
tmux send-keys -Rt main:htops.2 C-c Enter
tmux send-keys -t main:htops.2 peda Enter
tmux send-keys -Rt main:htops.3 C-c Enter
tmux send-keys -t main:htops.3 momo Enter
tmux send-keys -Rt main:htops.4 C-c Enter
tmux send-keys -t main:htops.4 dosa Enter
tmux send-keys -Rt main:htops.5 C-c Enter
tmux send-keys -t main:htops.5 idli Enter
tmux send-keys -Rt main:htops.6 C-c Enter
tmux send-keys -t main:htops.6 poha Enter

sleep 1

tmux send-keys -Rt main:gpu.1 C-c Enter
tmux send-keys -t main:gpu.1 puri Enter
tmux send-keys -Rt main:gpu.2 C-c Enter
tmux send-keys -t main:gpu.2 peda Enter
tmux send-keys -Rt main:gpu.3 C-c Enter
tmux send-keys -t main:gpu.3 poha Enter

tmux send-keys -t main:htops.1 mall102 Enter
tmux send-keys -t main:htops.2 mall102 Enter
tmux send-keys -t main:htops.3 mall102 Enter
tmux send-keys -t main:htops.4 mall102 Enter
tmux send-keys -t main:htops.5 mall102 Enter
tmux send-keys -t main:htops.6 mall102 Enter

sleep 1

tmux send-keys -t main:gpu.1 mall102 Enter
tmux send-keys -t main:gpu.2 mall102 Enter
tmux send-keys -t main:gpu.3 mall102 Enter

sleep 1

tmux send-keys -t main:htops.1 htop Enter
tmux send-keys -t main:htops.2 htop Enter
tmux send-keys -t main:htops.3 htop Enter
tmux send-keys -t main:htops.4 htop Enter
tmux send-keys -t main:htops.5 htop Enter
tmux send-keys -t main:htops.6 htop Enter

tmux send-keys -t main:gpu.1 "watch -cn 0.5 gpustat --color" Enter
tmux send-keys -t main:gpu.2 "watch -cn 0.5 gpustat --color" Enter
tmux send-keys -t main:gpu.3 "watch -cn 0.5 gpustat --color" Enter

tmux -u attach -t main
