#!/bin/bash

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
