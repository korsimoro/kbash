#!/bin/bash

if [ -d "$HOME/.nvm" ]; then
	export NVM_DIR="$HOME/.nvm"
fi

prepare_nvm_and_version() {
	if type nvm >/dev/null 2>&1; then
		echo "Using existing nvm"
	else
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	fi

	if ! nvm use $1; then
		nvm install $1
  	nvm use $1
	fi

	hash -r
	if ! command -v yarn >/dev/null; then
  		npm install -g yarn
	fi
}

function check_basic_node_ability() {
	if [ "$NVM_DIR" = "" ]; then
		echo "can not find NVM_DIR environment variable."
		echo "please visit https://github.com/creationix/nvm to install and configure NVM"
		false
	else
		true
	fi
}
