#!/bin/bash

function oneline_help_SHELL_PREFIX_cd() {
  echo "cd $VAR_PREFIX/[PATH] (or base w/o arg)"
}

function help_SHELL_PREFIX_cd() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX cd [PATH]${NC}

This is a shell function, which changes the current working
directory to
  ${YELLOW}$VAR_PREFIX/[PATH]${NC}.

If no PATH is provided, this just cds into
  ${YELLOW}$VAR_PREFIX${NC}

EOF
`\n\n"
}

function run_SHELL_PREFIX_cd() {
  if [ -z "$1" ]; then
    cd $VAR_PREFIX
  else
    cd $VAR_PREFIX/$1
  fi
}
export -f run_SHELL_PREFIX_cd help_SHELL_PREFIX_cd oneline_help_SHELL_PREFIX_cd
