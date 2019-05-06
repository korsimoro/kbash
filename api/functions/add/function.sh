#!/bin/bash


function oneline_help_ENTRYPOINT_add_function() {
  echo "Add a function."
}
export -f oneline_help_ENTRYPOINT_add_function

function cmdline_help_ENTRYPOINT_add_function() {
  echo "FUNCTION_NAME"
}
export -f cmdline_help_ENTRYPOINT_add_function


function help_ENTRYPOINT_add_function() {
printf "`cat << EOF
This will create the file
  ${GREEN}$VAR_PREFIX_KBASH_FUNCTION/[FUNCTION_NAME].sh${NC}
if it does not exist.  You should then edit this file to implement.
The template file used in creation is located at
  ${GREEN}$KBASH/setup/function.sh${NC}
You will want to edit the 4 function stubs
 1. oneline_help_ENTRYPOINT_[FUNCTION_NAME]
 2. cmdline_help_ENTRYPOINT_[FUNCTION_NAME]
 3. help_ENTRYPOINT_[FUNCTION_NAME]
 4. run_ENTRYPOINT_[FUNCTION_NAME]
EOF
`\n"
}
export -f help_ENTRYPOINT_add_function

function run_ENTRYPOINT_add_function() {
  local FUNCTION_NAME=$1
  if [ -z "$FUNCTION_NAME" ]; then
    report_warning "missing function name"
    help_ENTRYPOINT_add_function
    return
  fi

  local TARGET=$VAR_PREFIX_KBASH_FUNCTION/$FUNCTION_NAME.sh
  local KSETUP=$KBASH/setup/function.sh

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
      | sed s/FUNCTION/$FUNCTION_NAME/g \
      > $TARGET

  kbash_load_functions_from_dir "ENTRYPOINT" "VAR_PREFIX" $VAR_PREFIX_KBASH_FUNCTION
}
export -f run_ENTRYPOINT_add_function
