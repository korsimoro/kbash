#!/bin/bash

function oneline_help_ENTRYPOINT_kbash_os() {
  echo "Display current environment settings."
}
export -f oneline_help_ENTRYPOINT_kbash_os

function cmdline_help_ENTRYPOINT_kbash_os() {
  echo ""
}
export -f cmdline_help_ENTRYPOINT_kbash_os

function help_ENTRYPOINT_kbash_os() {
printf "`cat << EOF
${BLUE}ENTRYPOINT env${NC}

EOF
`\n"
}
export -f help_ENTRYPOINT_kbash_os

function run_ENTRYPOINT_kbash_os() {
  echo "Checking os: uname ='$(uname -a )'"
  if is_osx; then
    report_ok "OSX"
  else
    if is_windows; then
      report_ok "Windows Detected"
    else
      if is_linux; then
        report_ok "Linux Detected"
      else
        report_error "No OS Detected"
      fi
    fi
  fi

}
export -f run_ENTRYPOINT_kbash_os
