#!/bin/bash


function oneline_help_SHELL_PREFIX_tron() {
  echo "Start trace execution."
}

function help_SHELL_PREFIX_tron() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX tron${NC}


EOF
`\n"
}

function run_SHELL_PREFIX_tron() {
  set -x
}
export -f oneline_help_SHELL_PREFIX_tron help_SHELL_PREFIX_tron run_SHELL_PREFIX_tron
