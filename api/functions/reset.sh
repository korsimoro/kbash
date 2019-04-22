#!/bin/bash


function oneline_help_ENTRYPOINT_reset() {
  echo "Reload the environment."
}
export -f oneline_help_ENTRYPOINT_reset

function cmdline_help_ENTRYPOINT_reset() {
  echo ""
}
export -f cmdline_help_ENTRYPOINT_reset


function help_ENTRYPOINT_reset() {
printf "`cat << EOF
In this shell, execute:
  $VAR_PREFIX/activate.sh

This will cause the entire ${YELLOW}ENTRYPOINT${NC} runtime to be reloaded,
so any changes to functions or commands will be processed.

This will update the activation count from ${YELLOW}$VAR_PREFIX_ACTIVATION_COUNT${NC} to ${YELLOW}$(expr $VAR_PREFIX_ACTIVATION_COUNT + 1)${NC}

EOF
`\n"
}
export -f help_ENTRYPOINT_reset

function run_ENTRYPOINT_reset() {
  if [ ! -z "$1" ]; then
    if [ "--trace" = "$1" ]; then
      KBASH_TRACE=false
      . $VAR_PREFIX_KBASH/activate.sh
      KBASH_TRACE=true
      shift 1
      kbash_trace reset-trace "of $@"
      $@
    else
      printf "${RED}ENTRYPOINT_reset${NC}\n"
      printf "Do not understand arguments '$@'\n"
    fi
  else
    export PATH=$VAR_PREFIX_ORIGINAL_PATH
    . $VAR_PREFIX_KBASH/activate.sh
  fi
}
export -f run_ENTRYPOINT_reset
