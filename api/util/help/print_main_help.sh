#!/bin/bash

# print the top level help, subsequent subcommands will override this
# function with the appropriate help
function ENTRYPOINT_print_main_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT [COMMAND] [help|--help|-help|-h|?] ... ${NC}

${BLUE}ENTRYPOINT${NC} is a bash environment supporting development.

EOF
`\n\n"
ENTRYPOINT_print_function_help_summary
ENTRYPOINT_print_scope_help_summary
ENTRYPOINT_print_component_list
printf "\n"

printf "Use ${BLUE}ENTRYPOINT [FUNCTION|COMMAND|COMPONENT] help${NC} for more information.\n"

}
