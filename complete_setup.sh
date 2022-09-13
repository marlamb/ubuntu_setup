#!/usr/bin/bash

set -x

SCRIPT_DIR=$(dirname -- $(readlink -e $0))
export SETUP_CONFIG_DIR="${SCRIPT_DIR}/config"

${SCRIPT_DIR}/modules/others.sh
${SCRIPT_DIR}/modules/zsh.sh
${SCRIPT_DIR}/modules/tmux.sh
${SCRIPT_DIR}/modules/vim.sh
