#!/bin/bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function link() {
	mkdir -p "${2}"
	for f in "${DIR}/"${1}
	do
		ln -sf $(realpath "${f}") "${2}/"
	done
}

link .tmux.conf "${HOME}"
link .zshrc "${HOME}"
link .alias "${HOME}"
link ".config/*" "${HOME}/.config"
link "bin/*" "${HOME}/.local/bin"
