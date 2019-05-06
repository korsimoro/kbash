#!/bin/bash


function oneline_help_ENTRYPOINT_add_command() {
  echo "Add a command to the ENTRYPOINT environment."
}
export -f oneline_help_ENTRYPOINT_add_command

function cmdline_help_ENTRYPOINT_add_command() {
  echo "COMMAND_NAME"
}
export -f cmdline_help_ENTRYPOINT_add_command


function help_ENTRYPOINT_add_command() {
printf "`cat << EOF
This will create the file
  ${GREEN}$VAR_PREFIX_KBASH_COMMAND/[COMMAND_NAME].sh${NC}
if it does not exist.  You should then edit this file to implement.
The template file used in creation is located at
  ${GREEN}$KBASH/setup/command.sh${NC}
You will want to edit 3 things
 1. The oneline help summary that is used in other contexts
 2. The print_help() function, which is the detailed help
 3. The run() function, which is executed as a subprocess
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

  if [ -f "$TARGET" ]; then
    report_error "$TARGET already exists and is a file"
    return
  fi

  if [ -d "$TARGET" ]; then
    report_warning "$COMPONENT_NAME already exists and is a directory"
    return
  fi


  local KSETUP=$KBASH/setup/command.sh

  # filter the template so that VAR_PREFIX and ENTRYPOINT are replaced by the
  # VAR_PREFIX and ENTRYPOINT, which are themselves already filtered out when
  # the project was created (hence the VP, SP double-indirection)
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
