export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':' -)"

export CMAKE_BUILD_PARALLEL_LEVEL=8

export EDITOR=nvim
export TERMINAL=ghostty
export BROWSER=brave
export READER="zathura"
export MANPAGER="nvim -c 'Man!'"
source ~/.local/share/.env_api_keys

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ICEAUTHORITY_DEFAULT="$XDG_RUNTIME_DIR"/ICEauthority
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export LESSHISTFILE="-"

# rust
. "$HOME/.cargo/env"

# ghc
[ -f "/home/ln/.ghcup/env" ] && . "/home/ln/.ghcup/env"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.elan/bin:$PATH"
