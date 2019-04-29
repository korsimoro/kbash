#!/bin/bash


ENTRYPOINT_load_component() {
  local COMPONENT=$1
  local COMP_DIR="${VAR_PREFIX_COMPONENT_DIR}/$COMPONENT"

  for FUNCTION_FILE in $(find_dot_sh "$COMP_DIR"); do
    kbash_shell_integrate "ENTRYPOINT" "VAR_PREFIX" "$COMP_DIR/$FUNCTION_FILE"
  done

  local COMPONENT_NAME=$(echo "$COMPONENT" | sed s/[/]/_/g | sed s/.sh//g )
  eval VAR_PREFIX_COMPONENT_LIST=\"$(sorted_key_set "${VAR_PREFIX_COMPONENT_LIST} $COMPONENT_NAME")\"
}
export -f ENTRYPOINT_load_component
