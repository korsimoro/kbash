#!/bin/bash

function oneline_help_SHELL_PREFIX_component_list() {
  echo "List components, if any."
}

function help_SHELL_PREFIX_component_list() {
  printf "`cat << EOF
${BLUE}SHELL_PREFIX component-list${NC}

List all available components

EOF
`\n\n"
  run_SHELL_PREFIX_component_list
}

function run_SHELL_PREFIX_component_list() {
  local WIDTH=15
  for COMPONENT in $VAR_PREFIX_COMPONENT_LIST; do
    local HELP_FUNC="oneline_description_of_SHELL_PREFIX_$COMPONENT"
    printf "${GREEN}%-${WIDTH}s${NC} %s\n" "$COMPONENT" "$($HELP_FUNC )"
  done
}
export -f run_SHELL_PREFIX_component_list help_SHELL_PREFIX_component_list oneline_help_SHELL_PREFIX_component_list
