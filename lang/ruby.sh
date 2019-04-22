#!/bin/bash

if [ -d "$HOME/.rvm" ]; then
	export RVM_DIR="$HOME/.rvm"
fi

report_ruby_env() {
  local BASE=$1
	local NODE_MODULES=$BASE/ruby_modules
	local PACKAGE_JSON=$BASE/package.json

  report_subheading "Node Environment"

	if [ -z "$RVM_DIR" ]; then
		report_warning "Missing RVM"
	else
		report_ok "RVM Dir Present:"$RVM_DIR
	fi

	if [ -z "$PACKAGE_JSON" ]; then
		report_warning "Package Json Missing"
	else
		report_ok "Package Json Present:"$PACKAGE_JSON
	fi

  if [ -d "$NODE_MODULES" ]; then
    report_ok "  ruby_modules present"
		echo "  TSC=$(command -v tsc)"
		echo "  YARN=$(command -v yarn)"
  else
    report_warning "  ruby_modules not exist at $NODE_MODULES"
  fi
}
export -f report_python_env

prepare_rvm_and_version() {
	if type rvm >/dev/null 2>&1; then
		echo "Using existing rvm"
	else
		[ -s "$RVM_DIR/rvm.sh" ] && \. "$RVM_DIR/rvm.sh"  # This loads rvm
		[ -s "$RVM_DIR/bash_completion" ] && \. "$RVM_DIR/bash_completion"  # This loads rvm bash_completion
	fi

	if ! rvm use $1; then
		rvm install $1
  	rvm use $1
	fi

	hash -r
	if ! command -v yarn >/dev/null; then
  		npm install -g yarn
	fi
}
export -f prepare_rvm_and_version

function check_basic_ruby_ability() {
	if [ "$RVM_DIR" = "" ]; then
		echo "can not find RVM_DIR environment variable."
		echo "please visit https://github.com/creationix/rvm to install and configure RVM"
		false
	else
		true
	fi
}
export -f check_basic_ruby_ability
