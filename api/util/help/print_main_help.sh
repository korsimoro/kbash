#!/bin/bash

# print the top level help, subsequent subcommands will override this
# function with the appropriate help
function SHELL_PREFIX_print_main_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX [COMMAND] [help|--help|-h|?] ... ${NC}

${BLUE}SHELL_PREFIX${NC} is a bash environment supporting development.

EOF
`\n\n"
SHELL_PREFIX_print_kbash_command_help_summary
SHELL_PREFIX_print_function_help_summary
SHELL_PREFIX_print_command_help_summary .
SHELL_PREFIX_print_component_help_summary
printf "\n"

printf "Use ${BLUE}COMMAND [cmd] help${NC} for more information.\n"

}
