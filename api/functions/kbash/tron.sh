#!/bin/bash

function oneline_help_ENTRYPOINT_kbash_tron() {
  echo "set KBASH_TRACE to trace KBASH internals"
}

function help_ENTRYPOINT_kbash_tron() {
printf "`cat << EOF
This is equivalent to
  export KBASH_TRACE=true
EOF
`\n"
}

function run_ENTRYPOINT_kbash_tron() {
  KBASH_TRACE=true
}
export -f run_ENTRYPOINT_kbash_tron help_ENTRYPOINT_kbash_tron oneline_help_ENTRYPOINT_kbash_tron
