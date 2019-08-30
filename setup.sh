#!/bin/bash

# Software dependencies:
#   - tmux
#   - nvim
#   - git

HOME=${HOME}
PWD=`pwd`
DEPS=("nvim" "tmux" "git")

# Check if all software dependencies are installed
for sw in "${DEPS[@]}"
do
    type ${sw} > /dev/null 2>&1 ||
        { echo "ERROR: **${sw}** is not installed!"; exit 1; }
done

# Create symlinks to the repo files
symlinks=(${HOME}/".tmux.conf" ${HOME}/".config/nvim/init.vim" ${HOME}/".bashrc")

# Create .envrc if it doesn't exist
if [ -f .envrc ]; then
    echo "Enviroment variable file already exists."
else
    echo "Creating empty .envrc"
    touch ${HOME}/.envrc
fi

# Create .dircolors.256dark if it doesn't already exist
if [ -f .dircolors.256dark ]; then
    echo "Dircolors file already exists"
else
    echo "Creating .dircolors.256dark file"
    cp ${PWD}/.dircolors.256dark ${HOME}/.dircolors.256dark
fi

for symlink in "${symlinks[@]}"
do
    if [ -h $symlink ]; then
        echo "Symlink ${symlink} already exists."
    else
        echo "Creating symlink ${symlink}."

        if [ -f $symlink ]; then
            echo "A file with that name already exists. Backing it up as $(basename ${symlink}).bak"
            cp ${symlink} ${symlink}".bak"
        fi

        ln -sf ${PWD}/$(basename ${symlink}) ${HOME}/${symlink}
    fi
done

# Prepare nvim config folder
echo "Preparing config directories for nvim."
mkdir -p ${HOME}/.config/nvim

# Install Vimplug
VIMPLUG=${HOME}"/.local/share/nvim/site/autoload/plug.vim"

if [ -f $VIMPLUG ]; then
    echo "Vimplug already installed."
else
    echo "Installing Vimplug..."
    curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install nvim plugins
nvim --headless +PlugInstall +qa
