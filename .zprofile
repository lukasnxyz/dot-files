# Source zshenv
source ~/.zshenv

# Source zshrc if exists (but avoid full interactive setup)
[[ -f ~/.config/zsh/.zshrc ]] && . ~/.config/zsh/.zshrc

# Autostart dwm on tty1
if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep dwm || exec startx
fi
