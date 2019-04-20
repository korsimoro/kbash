#!/bin/bash

function SHELL_PREFIX_print_component_help_summary() {
  local WIDTH=18
  if [ ! -z "$VAR_PREFIX_COMPONENT_LIST" ]; then
    printf "Component Commands\n"
    for COMPONENT in $VAR_PREFIX_COMPONENT_LIST; do
      local BASE=$VAR_PREFIX_COMPONENT_DIR/$COMPONENT/commands
      local SCRIPT_FILE="$BASE/.scope.sh"
      if [ -f "$SCRIPT_FILE" ]; then
        local ONELINER=$(head -n 2 "$SCRIPT_FILE" | tail -n 1 | colrm 1 2)
        printf "${GREEN}%-${WIDTH}s${NC} %s\n" " $COMPONENT" "$ONELINER"
      else
        echo "-no scope help available- : file="$SCRIPT_FILE
      fi
    done
  fi
}
