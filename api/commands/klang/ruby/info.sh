#!/bin/bash
# Where
# example usage print_kidlist_help COMMAND
#
# print the top level help, subsequent subcommands will override this
# function with the appropriate help
print_help() {
	printf "`cat << EOF
	inspect the local ruby environment

EOF
`\n\n"
}
run() {
	report_vars "Ruby"\
		rvm_path

	ruby --version
	bundle --version
}
