. "$HOME/.cargo/env"
[ -f "/home/ln/.ghcup/env" ] && . "/home/ln/.ghcup/env" # ghcup-env
export PATH="$HOME/.ghcup/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.elan/bin:$PATH"

export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':' -)"

export EDITOR=nvim

source ~/.local/share/.env_api_keys

export LNEURALNET_DIR="/Users/ln/Dev/lneuralnet"

export PATH="/Library/TeX/texbin:$PATH"
