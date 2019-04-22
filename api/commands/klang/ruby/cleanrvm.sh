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
	export rvm_path=$VAR_PREFIX/.rvm
  rm -rf $rvm_path
  unset rvm_path
}
