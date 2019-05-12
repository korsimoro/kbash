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


default_ruby_setup() (
  local BASE=$1
  local VERSION=$2  # currently unused - but check versions here

  local GEM_PATH=$BASE/.rubygems
  local BIN_PATH=$BASE/.rubybin

  local LOGDIR=$BASE/setup-logs
  local SETUP_LOG=$(ensure_empty_dir $LOGDIR)
  report_heading "kbash/python default_ruby_setup, trace is in $SETUP_LOG"
  date > $SETUP_LOG/start-timestamp.txt

  report_progress "install" "bundle install --path $GEM_PATH --binstubs $BIN_PATH"
  if bundle install --path $GEM_PATH --binstubs $BIN_PATH > $SETUP_LOG/bundle-install.txt; then
    date > $SETUP_LOG/end-timestamp.txt
    report_ok "Gems installed"
    true
  else
    date > $SETUP_LOG/end-timestamp.txt
    report_error "Failed to install, trace in $SETUP_LOG/bundle-install.txt"
    false
  fi
)
export -f default_ruby_setup

activate_ruby_env() {
  local BASE=$1
  local VERSION=$2  # currently unused - but check versions here

  if [ -z "$BASE" ]; then
    report_error "activate_ruby_env called w/o base directory (arg 1)"
  else
    if [ -z "$VERSION" ]; then
      report_error "activate_ruby_env called w/o version (arg 2)"
    else
      report_progress "skipped" "Check version for $VERSION"
      local GEM_PATH=$BASE/.rubygems
	    local BIN_PATH=$BASE/.rubybin

      if [ ! -d "$GEM_PATH" ]; then
        report_warning "Missing $GEM_PATH, perhaps you need to run setup?"
      fi
      if [ ! -d "$BIN_PATH" ]; then
        report_warning "Missing $BIN_PATH, perhaps you need to run setup?"
      fi

      export RUBY_GEM_PATH="$GEM_PATH"
      export RUBY_BIN_PATH="$BIN_PATH"
      true
    fi
  fi
}
export -f activate_ruby_env


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
