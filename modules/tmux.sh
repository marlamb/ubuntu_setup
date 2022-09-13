#!/usr/bin/bash

function install()
{
  echo -e "\n\n Install $2...\n"
  sudo $1 install $2
}

install apt tmux
install apt ncurses-term

TMUX_PLUGINS_HOME=${HOME}/.tmux/plugins
echo ${HOME}
echo ${TMUX_PLUGINS_HOME}
exit 0
if [ ! -d "${TMUX_PLUGINS_HOME}" ]; then
    mkdir -p ${TMUX_PLUGINS_HOME}
    git clone https://github.com/tmux-plugins/tpm ${TMUX_PLUGINS_HOME}/tpm
fi

ln -f -v -s ${SETUP_CONFIG_DIR}/tmux/tmux.conf ${HOME}/.tmux.conf

echo -e "\n"
read -n 1 -p "Run <prefix> + I to fetch tmux plugins. Press any key to continue."
