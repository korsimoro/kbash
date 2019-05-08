#!/bin/bash

function oneline_help_ENTRYPOINT_kbash_env() {
  echo "Display current environment settings."
}
export -f oneline_help_ENTRYPOINT_kbash_env

function cmdline_help_ENTRYPOINT_kbash_env() {
  echo ""
}
export -f cmdline_help_ENTRYPOINT_kbash_env

function help_ENTRYPOINT_kbash_env() {
printf "`cat << EOF
${BLUE}ENTRYPOINT env${NC}

EOF
`\n"
}
export -f help_ENTRYPOINT_kbash_env

function run_ENTRYPOINT_kbash_env() {
  report_heading "KBash Core Settings"

  if is_osx; then
    report_ok "OSX Detected"
  fi
  if is_windows; then
    report_ok "Windows Detected"
  fi
  if is_linux; then
    report_ok "Linux Detected"
  fi

  report_vars "KBASH Settings" \
    KBASH\
    KBASH_CORE\
    KBASH_LANG\
    KBASH_API\
    KBASH_API_COMMAND_DIR\
    KBASH_API_FUNCTION_DIR

  report_vars "ENTRYPOINT Settings" \
    VAR_PREFIX \
    VAR_PREFIX_KBASH \
    VAR_PREFIX_KBASH_LOGS \
    VAR_PREFIX_KBASH_COMMAND \
    VAR_PREFIX_KBASH_FUNCTION \
    VAR_PREFIX_FUNCTION_LIST \
    VAR_PREFIX_COMPONENT_LIST \
    VAR_PREFIX_COMPONENT_DIR

  if [ -z "$KBASH_LANGUAGE_LIST" ]; then
    echo "No languages configured"
  else
    echo "Languages"
    for LANG in $KBASH_LANGUAGE_LIST; do
      report_${LANG}_env $VAR_PREFIX
    done
  fi
}
export -f run_ENTRYPOINT_kbash_env
