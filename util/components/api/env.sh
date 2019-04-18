#!/bin/bash

function oneline_help_SHELL_PREFIX_env() {
  echo "Display current environment settings."
}

function help_SHELL_PREFIX_env() {
printf "`cat << EOF
${BLUE}kd env${NC}

EOF
`\n"
}

function run_SHELL_PREFIX_env() {
  report_vars "Environment Settings" \
    KITWB_ACTIVATION_COUNT \
    KITWB_ACTIVE_DEVENV \
    KITWB_BASE_DIR \
    KITWB_BASH_COMMAND_DIR \
    KITWB_BASH_DIR \
    KITWB_BASH_FUNCTION_DIR \
    KITWB_BASH_UTIL_DIR \
    KITWB_FILES_DIR \
    KITWB_PYTHON3 \
    KITWB_SCRIPTS_DIR \
    KITWB_TEMPLATES_DIR \
    KITWB_VIRTUALENV

  report_environment

}
export -f run_SHELL_PREFIX_env help_SHELL_PREFIX_env oneline_help_SHELL_PREFIX_env
