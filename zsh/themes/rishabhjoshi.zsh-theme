VIRTUAL_ENV_DISABLE_PROMPT=1
# VCS
RJ_VCS_PROMPT_PREFIX1=" %{$fg[green]%}("
RJ_VCS_PROMPT_PREFIX2="%{$fg[green]%}"
RJ_VCS_PROMPT_SUFFIX="%{$fg[green]%})%{$reset_color%}"
RJ_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
RJ_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${RJ_VCS_PROMPT_PREFIX1}${RJ_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$RJ_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$RJ_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$RJ_VCS_PROMPT_CLEAN"


local exit_code="%(?,, %{$fg[red]%}%?%{$reset_color%})"

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

#$terminfo[bold]
PROMPT="%{$fg[red]%}$(virtualenv_info)%{$reset_color%} \
%F{green}%n%f@%F{green}%m%f \
%{$fg[blue]%}%~%{$reset_color%}\
$exit_code\

${git_info} "


RPROMPT="%{$fg[yellow]%}[%*]%{$reset_color%}"

PROMPT+="%{$fg[red]%}➞  %{$reset_color%}"
