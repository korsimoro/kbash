#!/bin/bash

ENTRYPOINT_print_component_list() {
  if [ -z "$VAR_PREFIX_COMPONENT_LIST" ]; then
    printf "No components configured, use ${BLUE}ENTRYPOINT add-component${NC} to add components.\n"
  else
    printf "Components\n"
    for COMPONENT in $VAR_PREFIX_COMPONENT_LIST; do
      local HELP_FUNC="oneline_description_of_ENTRYPOINT_$COMPONENT"
      report_pair $COMPONENT  "$($HELP_FUNC )"
    done
  fi
}
export -f ENTRYPOINT_print_component_list
