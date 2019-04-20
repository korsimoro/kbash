#!/bin/bash

SHELL_PREFIX_run_component_func() {
  local FUNC=$1
  shift 1
  local COMPONENT=$(slugify $1)

  if SHELL_PREFIX_help_on_empty_or_help $FUNC "$COMPONENT"; then
    clear
    local CMD=""$FUNC"_environment_SHELL_PREFIX_"$COMPONENT
    if vet_environment_SHELL_PREFIX_$COMPONENT; then
    	if ! $CMD "$@"; then
        echo "Failed to $CMD for $COMPONENT"
        false
      else
        true
      fi
    else
      false
    fi
  else
    false
  fi
}
SHELL_PREFIX_load_component() {
  local COMPONENT=$1
  local COMP_DIR="${VAR_PREFIX_COMPONENT_DIR}/$COMPONENT"

  for FUNCTION_FILE in $(find_dot_sh "$COMP_DIR"); do
    k_bashenv_shell_integrate "SHELL_PREFIX" "VAR_PREFIX" "$COMP_DIR/$FUNCTION_FILE"
  done

  local COMPONENT_NAME=$(echo "$COMPONENT" | sed s/[/]/_/g | sed s/.sh//g )
  eval VAR_PREFIX_COMPONENT_LIST=\"$(sorted_key_list "${VAR_PREFIX_COMPONENT_LIST} $COMPONENT_NAME")\"
}

SHELL_PREFIX_load_components() {


  local BASHENV_COMPLIST_VAR="${VAR_PREFIX}_COMPONENT_LIST"
  local BASHENV_COMPDIR_VAR="${VAR_PREFIX}_COMPONENT_DIR"

  for COMPONENT in $(ls ${VAR_PREFIX_COMPONENT_DIR} 2>/dev/null); do
    local COMP_DIR="${VAR_PREFIX_COMPONENT_DIR}/$COMPONENT"
    if [ -d "$COMP_DIR" ]; then
      SHELL_PREFIX_load_component $COMPONENT
    fi
  done

  if [ ! -z "$VAR_PREFIX_COMPONENT_LIST" ]; then
    k_bashenv_load_functions_from_dir "SHELL_PREFIX" "VAR_PREFIX" "$K_BASHENV_BASE/util/components/api"
  fi

}
export -f SHELL_PREFIX_load_components SHELL_PREFIX_load_component SHELL_PREFIX_run_component_func
