#!/bin/bash
# The KIT Workbench Documentation Environment
kd_print_scope_help() {
printf "`cat << EOF
${BLUE}kd kernel [SUBCOMMAND] [OPTIONS]${NC}

kd kernel commands

EOF
`\n\n"
kd_print_subcommand_help_summary kernel
}
