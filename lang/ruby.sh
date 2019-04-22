#!/bin/bash

if [ -d "$VAR_PREFIX/.rvm" ]; then
	export rvm_path="$VAR_PREFIX/.rvm"
	export KBASH_RUBY=true
else
	unset rvm_path
	unset KBASH_RUBY
fi

report_ruby_env() {
  local BASE=$1
	local NODE_MODULES=$BASE/ruby_modules
	local PACKAGE_JSON=$BASE/package.json

  report_subheading "Node Environment"

	if [ -z "$rvm_path" ]; then
		report_warning "Missing RVM"
	else
		report_ok "RVM Dir Present:"$rvm_path
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
		. $rvm_path/scripts/rvm
	fi

	if ! rvm use $1; then
		rvm install $1
  	rvm use $1
	fi

	pathadd $rvn_path/gems/$1/bin
	hash -r
	which ruby
	ruby --version
}
export -f prepare_rvm_and_version

function check_basic_ruby_ability() {
	if [ "$rvm_path" = "" ]; then
		echo "can not find rvm_path environment variable."
		echo "please visit https://github.com/creationix/rvm to install and configure RVM"
		false
	else
		true
	fi
}
export -f check_basic_ruby_ability
