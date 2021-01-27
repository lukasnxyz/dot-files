#
# ~/.bashrc
#

shopt -s histappend # enable history appending instead of overwriting
export HISTCONTROL=ignoreboth # no duplicates in input history
shopt -s autocd # change directory without using cd
stty -ixon # Disale ctrl-s and ctrl-q
set -o vi # vi mode in bash
shopt -s checkwinsize # sigwinch
shopt -s expand_aliases # sigwinch
PS1="\[\033[0;37m\][\[\033[0;37m\]\w]\[\033[0;37m\] \u\[\033[0;37m\]> \[\033[0;37m\]" # set custom bash prompt

# custom aliases 
alias ls='ls --color=auto'
alias ll='echo "Files: $(ls -A | wc -l)" && ls --color=auto -s -l -A'
alias grep='grep --color=auto'
alias gc='git clone'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias c='clear'
alias q='exit'
alias ka='killall'
alias pkgs='pacman -Q | wc -l'
