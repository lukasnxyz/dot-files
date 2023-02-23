#
# ~/.zprofile
#

[[ -f ~/.config/zsh/.zshrc ]] && . ~/.config/zsh/.zshrc

if [[ "$(tty)" = "/dev/tty1" ]]; then
    startx
fi
