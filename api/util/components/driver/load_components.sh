#!/bin/bash

ENTRYPOINT_load_components() {


  local BASHENV_COMPLIST_VAR="${VAR_PREFIX}_COMPONENT_LIST"
  local BASHENV_COMPDIR_VAR="${VAR_PREFIX}_COMPONENT_DIR"

  for COMPONENT in $(ls ${VAR_PREFIX_COMPONENT_DIR} 2>/dev/null); do
    local COMP_DIR="${VAR_PREFIX_COMPONENT_DIR}/$COMPONENT"
    if [ -d "$COMP_DIR" ]; then
      ENTRYPOINT_load_component $COMPONENT
    fi
  done

  if [ ! -z "$VAR_PREFIX_COMPONENT_LIST" ]; then
    kbash_load_functions_from_dir "ENTRYPOINT" "VAR_PREFIX" "$KBASH_UTIL/components/api"
  fi

}
export -f ENTRYPOINT_load_components
