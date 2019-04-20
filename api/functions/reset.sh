#!/bin/bash


function oneline_help_SHELL_PREFIX_reset() {
  echo "Reload the environment."
}

function help_SHELL_PREFIX_reset() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX reset${NC}

In this shell, execute:
  $VAR_PREFIX/activate.sh

This will cause the entire ${YELLOW}SHELL_PREFIX${NC} runtime to be reloaded,
so any changes to functions or commands will be processed.

This will update the activation count from ${YELLOW}$VAR_PREFIX_ACTIVATION_COUNT${NC} to ${YELLOW}$(expr $VAR_PREFIX_ACTIVATION_COUNT + 1)${NC}

EOF
`\n"
}

function run_SHELL_PREFIX_reset() {
  if [ ! -z "$@" ]; then
    printf "${RED}SHELL_PREFIX_reset${NC}\n"
    printf "Do not understand arguments '$@'\n"
  else
    export PATH=$VAR_PREFIX_ORIGINAL_PATH
    . $VAR_PREFIX_BASH/activate.sh
  fi
}
export -f oneline_help_SHELL_PREFIX_reset help_SHELL_PREFIX_reset run_SHELL_PREFIX_reset
