#!/bin/bash


function oneline_help_SHELL_PREFIX_reset() {
  echo "Reload the environment."
}

function help_SHELL_PREFIX_reset() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX reset${NC}

Load and execute $PREFIX_BASHENV/activate.sh in this shell.

This will cause the entire SHELL_PREFIX runtime to be reloaded, so any changes to
functions or core abilities (e.g. SHELL_PREFIX-repl, SHELL_PREFIX-help, activate) will be
processed.

Example Run:
  bashenv > SHELL_PREFIX reset
  Successful Reset : SHELL_PREFIX setenv =  /Users/kisia/Desktop @test:77eeddf, has changes

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
