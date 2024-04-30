#!/bin/bash

COLOR_RESET="$(tput sgr0)"
COLOR_GREEN="$(tput setaf 2)"
COLOR_RED="$()"

# check if XDG things are set
# check if laptop and if so, install auto-cpufreq?
# (check if current dir is dot-files) git clone this repo: https://github.com/lukasnxyz/dot-files

printf "%s%s%s\n" $COLOR_GREEN "Installing dot-files" $COLOR_RESET

printf "\n\t%s%s%s\n" $COLOR_GREEN "1. Installing packages: ${packages}" $COLOR_RESET
packages="zsh alacritty neovim tmux"
sudo apt install -y ${packages} # Ubuntu(apt), Arch(pacman), Fedora(dnf)

printf "\n\t%s%s%s\n" $COLOR_GREEN "2. Installing configuration files" $COLOR_RESET
configs=("alacritty/", "nvim/", ".zshenv", "zsh/", "tmux/")

#packages_install=""
#for p in "${packages[@]}"
#do
#	p=${p} | sed 's/.$//' # trying to remove comma
#	echo "${p}"
#	packages_install="${packages_install}${p} " 
#done

printf "\n\t%s%s%s\n" $COLOR_GREEN 3. Changing default shell to zsh" $COLOR_RESET
#chsh -s /usr/bin/zsh
