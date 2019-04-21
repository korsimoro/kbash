#!/bin/bash
# test scope

ENTRYPOINT_print_scope_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT tstscope <SUBCOMMAND> [OPTIONS]${NC}

ENTRYPOINT tstscope is a test scope.

EOF
`\n\n"
ENTRYPOINT_print_subcommand_help_summary tstscope
}
