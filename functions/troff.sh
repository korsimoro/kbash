#!/bin/bash


function oneline_help_SHELL_PREFIX_troff() {
  echo "Stop trace execution."
}

function help_SHELL_PREFIX_troff() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX troff${NC}


EOF
`\n"
}

function run_SHELL_PREFIX_troff() {
  set +x
}
export -f oneline_help_SHELL_PREFIX_troff help_SHELL_PREFIX_troff run_SHELL_PREFIX_troff
