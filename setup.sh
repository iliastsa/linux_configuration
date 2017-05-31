# Software requirements:
#   - zsh
#   - tmux
#   - nvim
#   - git

HOME=${HOME}
PWD=`pwd`
OH_MY_ZSH=${HOME}"/.oh-my-zsh"
VIM=${HOME}"/.vim"

# Check if software requirements are met

check_software_req(){
    software=("zsh" "tmux" "nvim" "git")
    for sw in "${software[@]}"
    do
        type ${sw} > /dev/null 2>&1 ||
                { echo "ERROR: **${sw}** is not installed!"; exit 1; }
    done
}

create_synlinks(){
    dotfiles=(".bashrc" ".zshrc" ".tmux.conf" ".vimrc" ".gitconfig" ".config/nvim/init.vim")
    for dotfile in "${dotfiles[@]}"
    do
        ln -sf ${PWD}/${dotfile} ${HOME}/${dotfile}
        echo "Created symlink ${HOME}/${dotfile}"
    done
}

install_oh_my_zsh(){
    if [ -d "${OH_MY_ZSH}" ]; then
        cd "${OH_MY_ZSH}"
        echo "Changed directory to `pwd`"
        echo "${OH_MY_ZSH} exists. Git pull to update..."
        git pull
        cd - > /dev/null 2>&1
        echo "Change directory back to `pwd`"
    else
        echo "${OH_MY_ZSH} doesn't exist. Installing..."
        git clone https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
    fi
}

install_vundle(){
    if [ -d "${VUNDLE}" ]; then
        cd "${VUNDLE}"
        echo "Changing directory to `pwd`"
        echo "${VUNDLE} exists. Git pull to update..."
        git pull
        cd - > /dev/null 2>&1
        echo "Changing directory back to `pwd`"
    else
        echo "${VUNDLE} not exists. Git clone to create..."
        git clone https://github.com/gmarik/Vundle.vim.git ${VUNDLE}
        vim +PluginInstall +qall
    fi
}

config_zsh(){
	echo "Creating symlink ${HOME}/.common"
	ln -sf ${PWD}/.common ${HOME}/.common
	echo "Creating symlink ${HOME}/tools"
	ln -sf ${PWD}/tools ${HOME}/tools
	ln -sf ${PWD}/tanky.zsh-theme ${OH_MY_ZSH}/themes/tanky.zsh-theme
	chsh -s `which zsh`
	source ${HOME}/.zshrc
}

config_tmux(){
    echo "Creating symlink ${HOME}/.tmux.sh"
    ln -sf ${PWD}/.tmux.sh ${HOME}/.tmux.sh
}

config_pip(){
    echo "Creating symlink ${HOME}/.pip/pip.conf"
    mkdir ${HOME}/.pip
    ln -sf ${PWD}/.pip/pip.conf ${HOME}/.pip/pip.conf
}

run(){
    check_software_req
    install_oh_my_zsh
    install_vundle
    create_synlinks
    config_zsh
    config_pip
    config_tmux
}