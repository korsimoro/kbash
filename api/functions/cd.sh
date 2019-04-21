#!/bin/bash

function oneline_help_ENTRYPOINT_cd() {
  echo "cd $VAR_PREFIX/[PATH] (or base w/o arg)"
}
export -f oneline_help_ENTRYPOINT_cd

function cmdline_help_ENTRYPOINT_cd() {
  echo "[PATH]"
}
export -f cmdline_help_ENTRYPOINT_cd

function help_ENTRYPOINT_cd() {
printf "`cat << EOF
This is a shell function, which execute cd as follows:
  cd ${YELLOW}$VAR_PREFIX/[PATH]${NC}.

If no PATH is provided, this just cds into
  cd ${YELLOW}$VAR_PREFIX${NC}
EOF
`"
}
export -f help_ENTRYPOINT_cd

function run_ENTRYPOINT_cd() {
  if [ -z "$1" ]; then
    cd $VAR_PREFIX
  else
    cd $VAR_PREFIX/$1
  fi
}
export -f run_ENTRYPOINT_cd
