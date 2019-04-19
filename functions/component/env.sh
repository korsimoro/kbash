#!/bin/bash

function oneline_help_SHELL_PREFIX_component_env() {
  echo "Describe active component environment"
}

function help_SHELL_PREFIX_component_env() {
  printf "`cat << EOF
${BLUE}SHELL_PREFIX component-env${NC}

Describe active component environment

EOF
`\n\n"
}

function run_SHELL_PREFIX_component_env() {
  describe_active_SHELL_PREFIX_environment
}
export -f run_SHELL_PREFIX_component_env help_SHELL_PREFIX_component_env oneline_help_SHELL_PREFIX_component_env
