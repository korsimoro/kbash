#!/bin/bash

function oneline_help_ENTRYPOINT_kbash_env() {
  echo "Display current environment settings."
}

function help_ENTRYPOINT_kbash_env() {
printf "`cat << EOF
${BLUE}ENTRYPOINT env${NC}

EOF
`\n"
}

function run_ENTRYPOINT_kbash_env() {
  report_vars "Environment Settings" \
    VAR_PREFIX \
    VAR_PREFIX_KBASH \
    VAR_PREFIX_KBASH_UTIL \
    VAR_PREFIX_KBASH_COMMAND \
    VAR_PREFIX_KBASH_FUNCTION \
    VAR_PREFIX_SCRIPTS \
    VAR_PREFIX_FILES \
    VAR_PREFIX_LOGS \
    VAR_PREFIX_FUNCTION_LIST \
    VAR_PREFIX_COMPONENT_LIST \
    VAR_PREFIX_COMPONENT_DIR \

  report_environment

}
export -f run_ENTRYPOINT_kbash_env help_ENTRYPOINT_kbash_env oneline_help_ENTRYPOINT_kbash_env
