#!/bin/bash
# The KIT Workbench Documentation Environment
SHELL_PREFIX_print_scope_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX COMPONENT_NAME [SUBCOMMAND] [OPTIONS]${NC}

SHELL_PREFIX COMPONENT_NAME commands

EOF
`\n\n"
SHELL_PREFIX_print_subcommand_help_summary COMPONENT_NAME
}
