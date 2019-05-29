# Software requirements:
#   - zsh
#   - tmux
#   - nvim
#   - git

HOME=${HOME}
PWD=`pwd`
VIM=${HOME}"/.vim"
VUNDLE=${HOME}"/.vim/bundle/Vundle.vim"

# Check if software requirements are met

check_software_req(){
    software=("tmux" "git")
    for sw in "${software[@]}"
    do
        type ${sw} > /dev/null 2>&1 ||
                { echo "ERROR: **${sw}** is not installed!"; exit 1; }
    done
}

create_symlinks(){
    dotfiles=(".tmux.conf" ".vimrc" ".bashrc")
    for dotfile in "${dotfiles[@]}"
    do
        ln -sf ${PWD}/${dotfile} ${HOME}/${dotfile}
        echo "Created symlink ${HOME}/${dotfile}"
    done
}

install_vundle(){
    if [ -d "${VUNDLE}" ]; then
        cd "${VUNDLE}"
        echo "Changing directory to `pwd`"
        cd - > /dev/null 2>&1
        echo "Changing directory back to `pwd`"
    else
        echo "${VUNDLE} not exists. Git clone to create..."
        git clone https://github.com/gmarik/Vundle.vim.git ${VUNDLE}
        vim +PluginInstall +qall
    fi
}

config_tmux(){
    echo "Creating symlink ${HOME}/.tmux.sh"
    ln -sf ${PWD}/.tmux.sh ${HOME}/.tmux.sh
}

run(){
    install_vundle
    config_tmux
    create_symlinks
}

run
