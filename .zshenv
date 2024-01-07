#
# ~/.zshenv
#

## --- environmental variables --- ##

export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':' -)"

export LANG=de_DE.UTF-8
export FZF_DEFAULT_COMMAND="find -L"

export GPG_TTY="tty"

export TERMINAL="alacritty"
export EDITOR="vim"
export BROWSER="firefox"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR=$HOME/.config/zsh
export ICEAUTHORITY_DEFAULT="$XDG_RUNTIME_DIR"/ICEauthority
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/xcompose
export LESSHISTFILE="-"

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GOBIN="$HOME/.local/bin/go"
. "/home/ln/.local/share/cargo/env"
