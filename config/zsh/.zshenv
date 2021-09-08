#
# ~/.zshenv
#

## --- environmental variables --- ##

export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':' -)"
export PATH="$PATH:$(du "$HOME/sr/scripts" | cut -f2 | paste -sd ':' -)"
export XCURSOR_SIZE=32 XCURSOR_THEME='Vanilla-DMZ-AA'

export TERMINAL="alacritty"
export EDITOR="vim"
export BROWSER="qutebrowser"
export READER="zathura"
export FZF_DEFAULT_COMMAND="find -L"

export CM_SELECTIONS="clipboard"
export CM_DEBUG=0
export CM_OUTPUT_CLIP=1
export CM_MAX_CLIPS=50
export CM_DIR=/home/ln/.cache/clip_history

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ICEAUTHORITY_DEFAULT="$XDG_RUNTIME_DIR"/ICEauthority
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export LESSHISTFILE="-"
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
