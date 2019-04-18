#!/bin/bash
#
# Given a base directory and a command
#
SHELL_PREFIX_execute() {
  local FILE=$1
  local HELP=$2
  shift 1
  . $FILE
  if [ "$HELP" == "help" ] ||\
     [ "$HELP" == "--help" ] ||\
     [ "$HELP" == "-help" ] ||\
     [ "$HELP" == "?" ] ||\
     [ "$HELP" == "-h" ]; then
    print_help
  else
    run $@
  fi
}

SHELL_PREFIX_locate_component_command() (
  local COMPONENT=$1
  shift 1
  local DIR=$VAR_PREFIX_COMPONENT_DIR/$COMPONENT/commands
  SHELL_PREFIX_locate_subcommand $DIR $@
)

SHELL_PREFIX_locate_subcommand() (
  local BASE_DIR=$1
  local COMMAND=$2
  shift 2
  local FILE=$BASE_DIR/$COMMAND.sh
  local SCOPE=$BASE_DIR/.scope.sh
  if [ -f "$SCOPE" ]; then
    . $SCOPE
    if [ -z "$COMMAND" ] ||\
       [ "$COMMAND" == "help" ] ||\
       [ "$COMMAND" == "--help" ] ||\
       [ "$COMMAND" == "-help" ] ||\
       [ "$COMMAND" == "?" ] ||\
       [ "$COMMAND" == "-h" ]; then
      SHELL_PREFIX_print_scope_help
      exit 0
    fi
  fi

  # if this a file, just run it
  if [ -f "$FILE" ]; then
    SHELL_PREFIX_execute $FILE $@
    exit 0
  fi

  # fall through to look for commands
  if [ -z "$COMMAND" ] ||\
     [ "$COMMAND" == "help" ] ||\
     [ "$COMMAND" == "--help" ] ||\
     [ "$COMMAND" == "-help" ] ||\
     [ "$COMMAND" == "?" ] ||\
     [ "$COMMAND" == "-h" ]; then
    SHELL_PREFIX_print_scope_help
    exit 0
  else
    local COMMAND_DIR=$BASE_DIR/$COMMAND
    if [ -d "$COMMAND_DIR" ]; then
      SHELL_PREFIX_locate_subcommand $COMMAND_DIR $@
    else
      if SHELL_PREFIX_locate_component_command $COMMAND $@; then
        exit $?
      else
        echo "Command not found : $@"
        echo "   COMMAND = "$COMMAND
        echo "   FUNC = run_SHELL_PREFIX_"$(slugify $COMMAND)
        echo "   BASE_DIR = "$BASE_DIR
        echo "   FILE = "$FILE
        echo "   SCOPE = "$SCOPE
        echo "   CLI = "$@
      fi
    fi
  fi
)


# this is the entry point
SHELL_PREFIX() {
  if [ -z "$1" ]; then
     SHELL_PREFIX_print_help
  else
     local TAG=$(slugify $1)
     local FUNC=run_SHELL_PREFIX_$TAG
     shift 1
     TYPE="$(type -t $FUNC)"
     if [ "$TYPE" = "function" ]; then
       if [ "$1" == "help" ] ||\
          [ "$1" == "--help" ] ||\
          [ "$1" == "-help" ] ||\
          [ "$1" == "?" ] ||\
          [ "$1" == "-h" ]; then
         help_SHELL_PREFIX_$TAG
       else
         $FUNC "$@"
       fi
     else
       SHELL_PREFIX_locate_subcommand $VAR_PREFIX_BASH_COMMAND $TAG $@
     fi
  fi
}
#export -f COMMAND SHELL_PREFIX_locate_subcommand SHELL_PREFIX_execute
export -f SHELL_PREFIX SHELL_PREFIX_locate_subcommand SHELL_PREFIX_execute SHELL_PREFIX_locate_component_command
