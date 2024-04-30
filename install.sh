#!/bin/bash

COLOR_RESET="$(tput sgr0)"
COLOR_GREEN="$(tput setaf 2)"
COLOR_RED="$()"

CONFIG_DIR="$HOME/.config/"
CACHE_DIR="$HOME/.cache/"
DATA_DIR="$HOME/.local/share/"
HOME_DIR="$HOME/"

mkdir -vp ${CONFIG_DIR}
mkdir -vp ${DATA_DIR}
mkdir -vp ${CACHE_DIR}
mkdir -vp "${CACHE_DIR}/zsh/"
mkdir -vp "${DATA_DIR}/nvim/undodir/"

export XDG_CONFIG_HOME=${CONFIG_DIR}
export XDG_DATA_HOME=${DATA_DIR}
export XDG_CACHE_HOME=${CACHE_DIR}

# check if laptop and if so, install auto-cpufreq?
# (check if current dir is dot-files) git clone this repo: https://github.com/lukasnxyz/dot-files

printf "%s%s%s\n\n" $COLOR_GREEN "Installing dot-files" $COLOR_RESET

printf "%s%s%s\n" $COLOR_GREEN "1. Installing packages: ${packages}" $COLOR_RESET
packages="zsh alacritty neovim tmux"
sudo apt install -y ${packages} # Ubuntu(apt), Arch(pacman), Fedora(dnf)

printf "%s%s%s\n" $COLOR_GREEN "2. Installing configuration files" $COLOR_RESET
config=("alacritty/", "nvim/", "tmux/", "zsh/")
home=(".zshenv")
for c in "${xdg_config_home[@]}"
do
	cp -rv ${c} ${CONFIG_DIR}
done
for c in "${home[@]}"
do
	cp -rv ${c} ${HOME_DIR}
done

printf "%s%s%s\n" $COLOR_GREEN "3. Changing default shell to zsh" $COLOR_RESET
chsh -s /usr/bin/zsh
