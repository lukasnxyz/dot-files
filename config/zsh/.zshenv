#
# ~/.zshenv
#

## --- environmental variables --- ##

export QT_QPA_PLATFORMTHEME="gtk2"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':' -)"
export PATH="$PATH:$(du "$HOME/sr/scripts" | cut -f2 | paste -sd ':' -)"
export XCURSOR_SIZE=28 XCURSOR_THEME='Vanilla-DMZ-AA'

export TERMINAL="st"
export EDITOR="vim"
export BROWSER="brave"
export READER="zathura"

export CM_SELECTIONS="clipboard"
export CM_DEBUG=0
export CM_OUTPUT_CLIP=1
export CM_MAX_CLIPS=20

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ICEAUTHORITY_DEFAULT=${XDG_RUNTIME_DIR}/ICEauthority
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export GTK2_RC_FILES="$HOME/.config/.gtkrc-2.0"
export LESSHISTFILE="-"
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
#export GNUPGHOME="$XDG_DATA_HOME"/gnupg
