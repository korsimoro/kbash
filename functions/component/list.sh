#!/bin/bash

function oneline_help_SHELL_PREFIX_component_list() {
  echo "cd home, or into $VAR_PREFIX/[C]."
}

function help_SHELL_PREFIX_component_list() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX cd <repo>${NC}

This is a shell function, which changes the current working
directory to $PREFIX/<repo>
and if no <repo> is provided this is equivalent to ${BLUE}SHELL_PREFIX home${NC}.

EOF
`\n\n"
}

function run_SHELL_PREFIX_component_list() {
  for COMPONENT in $VAR_PREFIX_COMPONENT_LIST; do
    echo "COMPONENT",$COMPONENT
  done
}
export -f run_SHELL_PREFIX_component_list help_SHELL_PREFIX_component_list oneline_help_SHELL_PREFIX_component_list
