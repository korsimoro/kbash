#!/bin/bash

function oneline_help_ENTRYPOINT_kbash_troff() {
  echo "disable KBASH_TRACE"
}

function help_ENTRYPOINT_kbash_troff() {
printf "`cat << EOF
This is equivalent to
  export KBASH_TRACE=false
EOF
`\n"
}

function run_ENTRYPOINT_kbash_troff() {
  KBASH_TRACE=false
}
export -f run_ENTRYPOINT_kbash_troff help_ENTRYPOINT_kbash_troff oneline_help_ENTRYPOINT_kbash_troff
