#!/usr/bin/bash

function install()
{
  echo -e "\n\n Install $2...\n"
  sudo $1 install $2
}

echo -e "\n\nUpdate apt...\n"
sudo apt update
sudo apt full-upgrade

install apt git-lfs
install apt curl
install apt software-properties-common
install apt thunderbird
install apt gimp
install snap inkscape
install snap htop
install apt silversearcher-ag
install apt tree
install apt meld
install apt fzf
install apt filezilla
install apt virtualenv

echo -e "\n\n Setting Eurkey keyboard layout...\n"
echo -e "Actual setting is currently commented out - check if it works also without additional steps!"
#install apt gnome-tweaks
#gsettings set org.gnome.desktop.input-sources show-all-sources true
echo -e "\n"
read -n 1 -p "After next reboot Eurkey layout is available. Add it as part of 'English (US)' in the respective menu. Press any key to continue."
echo -e "\n"

install apt bat
BAT_CONFIG_PATH=$(batcat --config-file)
echo -e "\n Determined bat config path: ${BAT_CONFIG_PATH}\n"
mkdir -p $(dirname ${BAT_CONFIG_PATH})
ln -f -v -s ${SETUP_CONFIG_DIR}/bat/bat_config ${BAT_CONFIG_PATH}

ln -f -v -s ${SETUP_CONFIG_DIR}/git/config.cfg ${HOME}/.gitconfig
