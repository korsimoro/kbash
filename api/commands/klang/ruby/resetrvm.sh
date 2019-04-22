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
	ENTRYPOINT klang ruby cleanrvm
	ENTRYPOINT klang ruby installrvm
}
