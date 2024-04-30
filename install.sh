#!/bin/bash

# check if XDG things are set
# check if laptop and if so, install auto-cpufreq?
# (check if current dir is dot-files) git clone this repo: https://github.com/lukasnxyz/dot-files
echo "\033[4;32mInstalling dot-files"

echo "\n\t\033[1;32m1. Installing packages: ${packages}"
packages="zsh alacritty neovim tmux"
sudo apt install -y ${packages} # Ubuntu(apt), Arch(pacman), Fedora(dnf)

echo "\n\t\033[1;32m2. Installing configuration files"
configs=("alacritty/", "nvim/", ".zshenv", "zsh/", "tmux/")

#packages_install=""
#for p in "${packages[@]}"
#do
#	p=${p} | sed 's/.$//' # trying to remove comma
#	echo "${p}"
#	packages_install="${packages_install}${p} " 
#done

echo "\n\t\033[1;32m3. Changing default shell to zsh"
#chsh -s /usr/bin/zsh
