#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

if [ -z ${HOME} ]
then
	echo "ERROR: now \${HOME} env. variable found"
	exit 1
fi

# Spacemacs
rm -f ${HOME}/.spacemacs
ln -sf $SCRIPTPATH/.spacemacs.d ${HOME}/.spacemacs.d
