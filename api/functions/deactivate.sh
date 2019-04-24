#!/bin/bash


function oneline_help_ENTRYPOINT_deactivate() {
  echo "Restores key variables to boot state"
}
export -f oneline_help_ENTRYPOINT_deactivate

function cmdline_help_ENTRYPOINT_deactivate() {
  echo ""
}
export -f cmdline_help_ENTRYPOINT_deactivate


function help_ENTRYPOINT_deactivate() {
printf "`cat << EOF

EOF
`\n"
}
export -f help_ENTRYPOINT_deactivate

function run_ENTRYPOINT_deactivate() {
  PATH=$KBASH_ORIGINAL_PATH
  PYTHONPATH=$KBASH_PYTHONPATH
  NODE_PATH=$KBASH_NODE_PATH
  rvm_path=$KBASH_rvm_path
  PS1=$KBASH_PS1
  unset VAR_PREFIX_ACTIVE_DEVENV
  ENTRYPOINT_reprompt
}
export -f run_ENTRYPOINT_deactivate
