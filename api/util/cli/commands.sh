#!/bin/bash
#
#
#
SHELL_PREFIX_process_command_scope_visitor() {
  local BASE=$1
  local ARG=$2
  shift 2
  case $ARG in
    print-scope-help)
      printf "${BOLD}${BLUE}$(SHELL_PREFIX_scope_usage )${NC}\n\n"
      printf "$(SHELL_PREFIX_scope_help $@)\n"
      SHELL_PREFIX_print_command_help_summary $BASE $@
      ;;
    execute-file)
      # careful... this expects to be entered into via SHELL_PREFIX()
      # which invokes the command executor
      local FILE=$1
      local NEXT_ARG=$2
      shift 1
      . $FILE
      if is_help_option "$NEXT_ARG"; then
        shift 1
        print_help "$@"
      else
        run $@
      fi
      ;;
    end-command-section)
      SHELL_PREFIX_process_command_scope $COMMAND_DIR $@
      ;;
    command-not-found)
      local COMMAND=$1
      local STACK=$2
      printf "${RED}Command not found${NC} - no \'$COMMAND\' in \'$STACK\'"
      ;;
    *)
      echo "Invalid Event:$ARG $@"
      ;;
  esac
}
export -f SHELL_PREFIX_process_command_scope_visitor

# creates a subprocess, loads the scope variable, then continues
# evaluation.  this is the only point of recursion in the search
# for a command.  this does not involve making function or component
# distinctions, which is only done at the top level
SHELL_PREFIX_process_command_scope() (
  # peal off the first two arguments, so $@ contains the rest of the
  # command line, if any
  local VISITOR=$1
  local STARTING_IN_DIR=$2
  local COMMAND_TO_FIND=$3
  local REPORT_MESSAGE=$4
  shift 4
echo "PROCESS COMMAND SCOPE"
  # load the current scope into this subprocess
  local SCOPE=$STARTING_IN_DIR/.scope.sh
  if [ ! -f "$SCOPE" ]; then
    report_error "Missing scope file in $STARTING_IN_DIR"
    return
  fi
  . $SCOPE

  # and if only help was asked or if there was no command,
  # then print the locally loaded scope help and exit
  if is_help_option_or_empty "$COMMAND_TO_FIND"; then
    $VISITOR "$STARTING_IN_DIR" print-scope-help $0
    exit 0
  else
    # we know that COMMAND_TO_FIND
    local COMMAND_FILE=$STARTING_IN_DIR/$COMMAND_TO_FIND.sh
    local COMMAND_DIR=$STARTING_IN_DIR/$COMMAND_TO_FIND

    if [ -f "$COMMAND_FILE" ]; then
      $VISITOR "$STARTING_IN_DIR" execute-file "$COMMAND_FILE" $@
    else
      if [ -d "$COMMAND_DIR" ]; then
        local NEXT_COMMAND=$1
        shift 1
        $VISITOR "$STARTING_IN_DIR" enter-scope "$VISITOR" "$COMMAND_DIR" "$NEXT_COMMAND" "$REPORT_MESSAGE/$COMMAND_TO_FIND" $@
      else
        $VISITOR "$STARTING_IN_DIR" command-not-found "$COMMAND_TO_FIND" "$REPORT_MESSAGE"
      fi
    fi
  fi
)
export -f SHELL_PREFIX_process_command_scope
