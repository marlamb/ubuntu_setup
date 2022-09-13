#!/usr/bin/bash

function install()
{
  echo -e "\n\n Install $2...\n"
  sudo $1 install $2
}

echo -e "\n\n Add neovim apt repository...\n"
sudo add-apt-repository ppa:neovim-ppa/stable

echo -e "\n\n Rerun apt update...\n"
sudo apt update

install apt neovim

mkdir -p ${HOME}/.config/nvim
ln -f -v -s ${SETUP_CONFIG_DIR}/vim/init.vim ${HOME}/.config/nvim/init.vim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo -e "\n"
read -n 1 -p "Run 'PlugInstall' within vim to install plugins. Press any key to continue."
