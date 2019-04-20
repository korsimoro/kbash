#!/bin/bash

function SHELL_PREFIX_print_command_help_summary() {

  local VISITOR=SHELL_PREFIX_receive_event

  local BASE=$1
  if [ ! -d "$BASE" ]; then
    BASE=$VAR_PREFIX_COMPONENT_DIR/$1/commands
  fi

  local KIDS=$(ls -1 $BASE/*.sh  2>/dev/null)
  if [ ! -z "$KIDS" ]; then
    KIDS=$(echo $KIDS | xargs -n 1 basename | sed s/.sh$//g | sort)
  fi

  local SCOPES=$(ls -1 $BASE/*/.scope.sh 2>/dev/null)
  if [ ! -z "$SCOPES" ]; then
    SCOPES=$(ls -1 $BASE/*/.scope.sh | xargs -n 1 dirname | xargs -n 1 basename || true | sort)
  fi



  if [ ! -z "$KIDS" ]; then
    $VISITOR start-command-section
    for KID in $KIDS; do
      local SCRIPT_FILE="$BASE/$KID.sh"
      $VISITOR visit-command "$KID" "$SCRIPT_FILE"
    done
    $VISITOR end-command-section
  fi

 if [ ! -z "$SCOPES" ]; then
   $VISITOR start-command-set-section
   for SCOPE in $SCOPES; do
      local SCRIPT_FILE="$BASE/$SCOPE/.scope.sh"
      $VISITOR visit-command-set "$KID" "$SCRIPT_FILE"
    done
    $VISITOR end-command-set-section
  fi
}
