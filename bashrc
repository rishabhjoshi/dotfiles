# .bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export PATH=$HOME/tools/:$PATH
export PATH=$HOME/.local/bin/:$PATH

export PATH="/usr/local/cuda-9.0/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/home/rjoshi2/tools/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/home/rjoshi2/.local/lib:$LD_LIBRARY_PATH"


export COBOT_HOME="/projects/tir1/users/rjoshi2/alexa/cobot_base"; export PATH=$COBOT_HOME/bin:$PATH

# chsh -s /bin/zsh

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias work='cd /projects/tir1/users/rjoshi2/'
alias corenlp='cd /projects/tir3/users/rjoshi2/corenlp/stanford-corenlp-full-2018-10-05'
alias alexa='cd /projects/tir1/users/rjoshi2/alexa'

dwn() {
	while true;do
		wget -T 15 -c $1 && break
	done
}

alias gpunv='watch -cn 0.5 gpustat -p --color'

#alias tmux='/home/rjoshi2/.local/bin/tmux'
alias ta='tmux -u -2 attach -t'
alias tad='tmux -u -2 attach -d -t'
alias ts='tmux -u -2 new-session -s'
alias tl='tmux -u -2 list-sessions'

alias myenv='source /home/rjoshi2/envs/myenv/bin/activate'
alias rasaenv='source /home/rjoshi2/envs/rasa/bin/activate'


#export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u \[\033[01;93m\]: \[\033[01;31m\]\w \[\033[01;93m\]: \[\033[01;96m\]\D{%d-%m-%Y %A} \@\n\[\033[01;93m\]\$ '
# Theme
# virtualenv prompts
VIRTUALENV_CHAR="ⓔ "
VIRTUALENV_THEME_PROMPT_PREFIX=""
VIRTUALENV_THEME_PROMPT_SUFFIX=""

# SCM prompts
SCM_NONE_CHAR=""
SCM_GIT_CHAR="[±] "
SCM_GIT_BEHIND_CHAR="${red}↓${normal}"
SCM_GIT_AHEAD_CHAR="${bold_green}↑${normal}"
SCM_GIT_UNTRACKED_CHAR="⌀"
SCM_GIT_UNSTAGED_CHAR="${bold_yellow}•${normal}"
SCM_GIT_STAGED_CHAR="${bold_green}+${normal}"
SCM_THEME_PROMPT_DIRTY=""
SCM_THEME_PROMPT_CLEAN=""
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

# Git status prompts
GIT_THEME_PROMPT_DIRTY=" ${red}✗${normal}"
GIT_THEME_PROMPT_CLEAN=" ${bold_green}✓${normal}"
GIT_THEME_PROMPT_PREFIX=""
GIT_THEME_PROMPT_SUFFIX=""

function virtualenv_prompt {
	[ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# Rename tab
function tabname {
  printf "\e]1;$1\a"
}

# Rename window
function winname {
  printf "\e]2;$1\a"
}

gb() {
	echo -n '(' && git branch 2>/dev/null | grep '^*' | colrm 1 2 | tr -d '\n' && echo -n ') '
}
git_branch() {
	gb | sed 's/()//'
}

PS1=' \e[00;0m\e[00;32m\u@\h \e[00;34m\w \e[00;93m(\D{%d/%m} \t) \n \e[32m$(git_branch)\e[00;31m➞ \e[0m '
#PS2=' \[\033[00;31m\]-> \e[0m \$'
