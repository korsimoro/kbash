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
  for COMPONENT in $VAR_PREFIX_COMPONENT_LIST; do
    local HELP_FUNC="oneline_description_of_$COMPONENT"
    echo "   $COMPONENT  $($HELP_FUNC )"
  done
}

function run_SHELL_PREFIX_component_list() {
  for COMPONENT in $VAR_PREFIX_COMPONENT_LIST; do
    echo $COMPONENT
  done
}
export -f run_SHELL_PREFIX_component_list help_SHELL_PREFIX_component_list oneline_help_SHELL_PREFIX_component_list
