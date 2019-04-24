#!/bin/bash


function oneline_help_ENTRYPOINT_add_command() {
  echo "Add a function."
}
export -f oneline_help_ENTRYPOINT_add_command

function cmdline_help_ENTRYPOINT_add_command() {
  echo "COMMAND_NAME"
}
export -f cmdline_help_ENTRYPOINT_add_command


function help_ENTRYPOINT_add_command() {
printf "`cat << EOF
<<DETAILED INFORMATION ABOUT add_command>>
EOF
`\n"
}
export -f help_ENTRYPOINT_add_command

function run_ENTRYPOINT_add_command() {
  local COMMAND_NAME=$1
  if [ -z "$COMMAND_NAME" ]; then
    report_warning "missing function name"
    help_ENTRYPOINT_add_command
    return
  fi

  local TARGET=$VAR_PREFIX_KBASH_COMMAND/$COMMAND_NAME.sh
  local KSETUP=$KBASH/setup/command.sh

  if [ -f "$TARGET" ]; then
    report_error "$TARGET already exists and is a file"
    return
  fi

  if [ -d "$TARGET" ]; then
    report_warning "$COMPONENT_NAME already exists and is a directory"
    return
  fi


  local PFX=PREFIX
  local VP="VAR_${PFX}"
  local PT=POINT
  local SP="ENTRY${PT}"
  cat $KSETUP \
      | sed s/$VP/VAR_PREFIX/g \
      | sed s/$SP/ENTRYPOINT/g \
      | sed s/COMMAND/$COMMAND_NAME/g \
      > $TARGET

}
export -f run_ENTRYPOINT_add_command
