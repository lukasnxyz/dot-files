# Enabling and setting git info var to be used in prompt config.
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
# This line obtains information from the vcs.
zstyle ':vcs_info:git*' formats "- (%b) "
precmd() {
    vcs_info
}

# Enable substitution in the prompt.
setopt prompt_subst

prompt='%n@%m %2/ ${vcs_info_msg_0_}> '

# vi mode
bindkey -v
export KEYTIMEOUT=1

# custom aliases
alias ll="/bin/ls --color -slAG"
alias cp="/bin/cp -iv"
alias mv="/bin/mv -iv"
alias rm="/bin/rm -v"
alias q="exit"
alias tree="tree -C"

# remove duplicates in history
setopt HIST_EXPiRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# history 
HISTFILE=~/.cache/zsh/zsh_history
HISTSIZE=1000000
SAVEHIST=10000
setopt appendhistory
bindkey "^K" history-beginning-search-backward
bindkey "^J" history-beginning-search-forward

# auto tab complete
autoload -U compinit
zstyle ':completion*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# auto cd
setopt auto_cd

[ -f "/home/ln/.ghcup/env" ] && . "/home/ln/.ghcup/env" # ghcup-env
