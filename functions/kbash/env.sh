#!/bin/bash

function oneline_help_SHELL_PREFIX_kbash_env() {
  echo "Display current environment settings."
}

function help_SHELL_PREFIX_kbash_env() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX env${NC}

EOF
`\n"
}

function run_SHELL_PREFIX_kbash_env() {
  report_vars "Environment Settings" \
    VAR_PREFIX \
    VAR_PREFIX_BASH \
    VAR_PREFIX_BASH_UTIL \
    VAR_PREFIX_BASH_COMMAND \
    VAR_PREFIX_BASH_FUNCTION \
    VAR_PREFIX_SCRIPTS \
    VAR_PREFIX_FILES \
    VAR_PREFIX_LOGS \
    VAR_PREFIX_FUNCTION_LIST \
    VAR_PREFIX_COMPONENT_LIST \
    VAR_PREFIX_COMPONENT_DIR \

  report_environment

}
export -f run_SHELL_PREFIX_kbash_env help_SHELL_PREFIX_kbash_env oneline_help_SHELL_PREFIX_kbash_env
