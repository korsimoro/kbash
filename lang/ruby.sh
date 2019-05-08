#!/bin/bash

report_ruby_env() {
  report_subheading "Ruby Environment"

  if check_basic_ruby_ability; then
    report_vars "Settings"\
      RUBY_GEM_PATH\
      RUBY_BIN_PATH
  else
    report_warning "No ruby detected"
  fi
}
export -f report_python_env

prepare_ruby() {
  local BASE=$1
  local VERSION=$2  # currently unused
	export RUBY_GEM_PATH=$BASE/.rubygems
	export RUBY_BIN_PATH=$BASE/.rubybin
  true
}
export -f prepare_ruby
old_prepare_rvm_and_version() {
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

function check_basic_ruby_ability() {

  local RUBY_VERSION=$(ruby --version)
  if [ -z "$RUBY_VERSION" ]; then
    report_error "Can not find ruby"
    false
  else
    local RUBY_BUNDLER_VERSION=$(bundle --version)
    if [ -z "$RUBY_BUNDLER_VERSION" ]; then
      report_error "Bundle not found, try gem install bundle"
      false
    else
      if [ ! "$RUBY_BUNDLER_VERSION" = "Bundler version 2.0.1" ]; then
	       report_error "Ruby Bundler incorrect version $RUBY_BUNDLER_VERSION, need 2.0.1"
         false
      else
        if is_linux; then
          # https://github.com/guard/listen/wiki/Increasing-the-amount-of-inotify-watchers
          if [ "$(cat /proc/sys/fs/inotify/max_user_watches)" -lt "524288" ]; then
            echo "As per: https://github.com/guard/listen/wiki/Increasing-the-amount-of-inotify-watchers"
            echo "Run This: echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p"
            echo "Current value is $(cat /proc/sys/fs/inotify/max_user_watches), and needs to be larger"
            false
          else
            report_ok "Basic ruby ability detected"
            true
          fi
        else
          report_ok "Basic ruby ability detected"
          true
        fi
      fi
    fi
  fi
}
export -f check_basic_ruby_ability
