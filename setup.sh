#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

function link_folder() {
	if [ -z $WIN ]; then
		ln -sf ${1} ${2}
	else
		link="$(cygpath -w ${1})"
		target="$(cygpath -w ${2})"
		cmd <<< "mklink /D \"${target}\" \"${link}\"" > /dev/null
	fi
}

# Spacemacs
function config_spacemacs() {
    rm -f ${HOME}/.spacemacs
    rm -f ${HOME}/.spacemacs.env

    if [ -d ${HOME}/.spacemacs.d ] && [ -z ${FORCE} ]; then
        echo "WARNING: Folder ${HOME}/.spacemacs.d already exist - Skipping"
    else
        rm -rf ${HOME}/.spacemacs.d
        link_folder $SCRIPTPATH/.spacemacs.d ${HOME}/.spacemacs.d
    fi
}

if [ -z ${HOME} ] ;then
	  echo "ERROR: now \${HOME} env. variable found"
	  exit 1
fi

[[ $1 -eq "-f" ]] && FORCE=true
[[ $(uname -a | grep -o MINGW) == MINGW ]] && WIN=true

config_spacemacs
