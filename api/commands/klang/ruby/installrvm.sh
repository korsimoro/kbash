#!/bin/bash
# Detailed Information about KBASH
# example usage print_kidlist_help COMMAND
#
# print the top level help, subsequent subcommands will override this
# function with the appropriate help
print_help() {
  echo "help"
}
run() {
  gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	export rvm_path=$VAR_PREFIX/.rvm
  #curl -sSL https://get.rvm.io | bash -s stable --ruby
  curl -sSL https://get.rvm.io | bash -s stable

}
