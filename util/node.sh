#!/bin/bash

if [ -d "$HOME/.nvm" ]; then
	export NVM_DIR="$HOME/.nvm"
fi

report_node_env() {
  local BASE=$1
	local NODE_MODULES=$BASE/node_modules
	local PACKAGE_JSON=$BASE/package.json

  report_subheading "Node Environment"

	if [ -z "$NVM_DIR" ]; then
		report_warning "Missing NVM"
	else
		report_ok "NVM Dir Present:"$NVM_DIR
	fi

	if [ -z "$PACKAGE_JSON" ]; then
		report_warning "Package Json Missing"
	else
		report_ok "Package Json Present:"$PACKAGE_JSON
	fi

  if [ -d "$NODE_MODULES" ]; then
    report_ok "  node_modules present"
		echo "  TSC=$(command -v tsc)"
		echo "  YARN=$(command -v yarn)"
  else
    report_warning "  node_modules not exist at $NODE_MODULES"
  fi
}
export -f report_python_env

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
export -f prepare_nvm_and_version

function check_basic_node_ability() {
	if [ "$NVM_DIR" = "" ]; then
		echo "can not find NVM_DIR environment variable."
		echo "please visit https://github.com/creationix/nvm to install and configure NVM"
		false
	else
		true
	fi
}
export -f check_basic_node_ability
