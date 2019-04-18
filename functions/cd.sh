#!/bin/bash

function oneline_help_SHELL_PREFIX_cd() {
  echo "cd home, or into $VAR_PREFIX/[C]."
}

function help_SHELL_PREFIX_cd() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX cd <repo>${NC}

This is a shell function, which changes the current working
directory to $PREFIX/<repo>
and if no <repo> is provided this is equivalent to ${BLUE}SHELL_PREFIX home${NC}.

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
