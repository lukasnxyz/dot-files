#
# ~/.zprofile
#

[[ -f ~/.config/zsh/.zshrc ]] && . ~/.config/zsh/.zshrc

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep dwm || startx
fi
