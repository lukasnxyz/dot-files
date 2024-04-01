# color
autoload -U colors && colors

# prompt
#PS1="%{$fg[cyan]%}%~%{$fg[white]%} >%{$reset_color%} "
#PS1="%n@%M:$fg[cyan]%~$fg[white]%{$reset_color%}# "
PS1="%n@%M $fg[white]%~$fg[white]%{$reset_color%} %% "
#PS1="$fg[blue]%M $fg[green]%~$fg[blue] >%{$reset_color%} "

# history
HISTSIZE=1000000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt HIST_IGNORE_ALL_DUPS
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

# vi mode
bindkey -v
export KEYTIMEOUT=1

# auto cd
setopt auto_cd

# Edit line in vim buffer ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# Enter vim buffer from normal mode
autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line

# vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey -v '^R' history-incremental-search-backward

# change cursor shape for different vi modes (change 3 or 5 for underline or beam)
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'underline' ]]; then
     echo -ne '\e[3 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'block' ]]; then
       echo -ne '\e[1 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
        zle -K viins
        echo -ne "\e[1 q"
}

zle -N zle-line-init
echo -ne '\e[1 q'
preexec() { echo -ne '\e[1 q' ;}

# custom aliases
alias ls='/bin/ls --color=auto'
alias ll='/bin/ls --color=auto -s -l -A --group-directories-first'
alias grep='/bin/grep --color=auto'
alias cp='/bin/cp -iv'
alias mv='/bin/mv -iv'
alias rm='/bin/rm -v'
alias q='exit'
alias ka='/bin/killall'
alias s='/bin/systemctl'
alias ac='/usr/bin/vim $HOME/Dokumente/pw.txt.gpg'
alias vim='/snap/bin/nvim'
