#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# Spacemacs
function config_spacemacs() {
    rm -f ${HOME}/.spacemacs
    rm -f ${HOME}/.spacemacs.env

    if [ -d ${HOME}/.spacemacs.d ] && [ -z ${FORCE} ]; then
        echo "WARNING: Folder ${HOME}/.spacemacs.d already exist - Skipping"
    else
        rm -rf ${HOME}/.spacemacs.d
        ln -sf $SCRIPTPATH/.spacemacs.d ${HOME}/.spacemacs.d
    fi
}

if [ -z ${HOME} ] ;then
	  echo "ERROR: now \${HOME} env. variable found"
	  exit 1
fi

[[ $1 -eq "-f" ]] && FORCE=true

config_spacemacs
