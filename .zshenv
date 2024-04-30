#
# ~/.zshenv
#

## --- environmental variables --- ##
export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':' -)"
export FZF_DEFAULT_COMMAND="find -L"

export GPG_TTY="tty"

export TERMINAL="alacritty"
export EDITOR="nvim"
export BROWSER="firefox"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR=$HOME/.config/zsh
export ICEAUTHORITY_DEFAULT="$XDG_RUNTIME_DIR"/ICEauthority
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export LESSHISTFILE="-"

#export CARGO_HOME="$XDG_DATA_HOME"/cargo
#. "/home/ln/.local/share/cargo/env"
export GOPATH="$XDG_DATA_HOME"/go
export GOBIN="$HOME/.local/bin/go"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
source ~/.local/share/.zsh_openai_api_key
