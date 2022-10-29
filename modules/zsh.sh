#!/usr/bin/bash

function install()
{
  echo -e "\n\n Install $2...\n"
  sudo $1 install $2
}

install apt zsh

echo -e "\n\n Install oh-my-zsh\n"
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

echo -e "\n\n Copy .zshrc from oh-my-zsh template...\n"
cp -v ${HOME}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME}/.zshrc

install apt zsh-syntax-highlighting

echo -e "\n\n Create link for .zsh.local...\n"
ln -f -v -s ${SETUP_CONFIG_DIR}/zsh/zsh.local ${HOME}/.zsh.local

echo -e "\n\n Copy fonts to ~/.fonts...\n"
cp -r -v ${SETUP_CONFIG_DIR}/zsh/fonts/. ${HOME}/.local/share/fonts/

echo -e "\n\n Clone powerlevel10k as oh-my-zsh scheme...\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo -e "\n\n Create link for p10k config...\n"
ln -f -v -s ${SETUP_CONFIG_DIR}/zsh/p10k.zsh ${HOME}/.p10k.zsh

echo -e "\n\n Setting powerlevel10k as ZSH_THEME in .zshrc...\n"
sed -i '/ZSH_THEME=".*"/c\ZSH_THEME="powerlevel10k/powerlevel10k"' ${HOME}/.zshrc

if grep -Fqx "# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc." ${HOME}/.zshrc
then
    echo -e "\nAdditional header for Powerlevel10k instant prompt is already present. No insertion needed.\n"
else
    echo -e "\nAdd header for Powerlevel10k instant prompt to .zshrc\n"
    cp ${SETUP_CONFIG_DIR}/zsh/zshrc_header.zsh /tmp/newfile
    cat ${HOME}/.zshrc >> /tmp/newfile
    mv /tmp/newfile ${HOME}/.zshrc
fi

echo -e "\n\n Installing zsh-autosuggestions...\n"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo -e "\n\n Settings zsh plugins...\n"
sed -i 's/^plugins=\(.*\)$/plugins=(git zsh-autosuggestions)/' ${HOME}/.zshrc

if grep -Fqx "source ~/.zsh.local" ${HOME}/.zshrc
then
    echo -e "\nSourcing of .zsh.local is already present. No action required."
else
    echo -e "\n Add sourcing of .zsh.local in .zshrc.\n"
    echo -e "source ~/.zsh.local" >> ${HOME}/.zshrc
fi

echo -e "\n"
read -n 1 -p "Set the used font of the terminal to 'Meslo NF' to use p10k setup. Press any key to continue."
