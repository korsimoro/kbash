#!/bin/bash

function ENTRYPOINT_print_function_help_summary() {
  printf "Functions (modify the current shell)\n"
  for FUNC in $VAR_PREFIX_FUNCTION_LIST; do
    #ONELINER="$(oneline_help_ENTRYPOINT_$FUNC)"
    ONELINER="$(oneline_help_ENTRYPOINT_$FUNC)"
    report_pair "$(function_slug_to_dashes $FUNC)" "$ONELINER"
  done
  printf "\n"
}
