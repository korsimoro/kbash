#!/bin/bash

function SHELL_PREFIX_print_function_help_summary() {
  printf "Functions (modify the current shell)\n"
  local WIDTH=18
  #local FUNCS=$(find_dot_sh $K_BASHENV_FU | sed s/[/]/_/g | sed s/.sh//g | sort )
  for FUNC in $VAR_PREFIX_FUNCTION_LIST; do
    ONELINER="$(oneline_help_SHELL_PREFIX_$FUNC)"
    printf "${GREEN}%-${WIDTH}s${NC} %s\n" " $FUNC" "$ONELINER"
  done
}
