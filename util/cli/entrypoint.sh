#!/bin/bash
#
# Given a base directory and a command
#
SHELL_PREFIX_execute() (
  local FILE=$1
  local HELP=$2
  shift 1
  . $FILE
  if [ "$HELP" = "help" ]; then
    print_help
  else
    run $@
  fi
)

#
# given a command of the form COMMAND <subcommand> .... look for a
# - command file, to be executed as a subshell
# - a function to be executed in the current shell
# - look for 'help' conditions
# - recurse if it looks like there is recursion
# - report details if we bottom out
#
SHELL_PREFIX_locate_subcommand() {
  local BASE_DIR=$1
  local COMMAND=$2
  shift 2
  local FILE=$BASE_DIR/$COMMAND.sh
  local SCOPE=$BASE_DIR/.scope
  if [ -f "$SCOPE" ]; then
    . $SCOPE
  fi
  if [ -f "$FILE" ]; then
    SHELL_PREFIX_execute $FILE $@
  else
    if [ -z "$COMMAND" ] || [ "help" = "$COMMAND" ]; then
      print_help
    else
      local DIR=$BASE_DIR/$COMMAND
      if [ -d "$DIR" ]; then
        SHELL_PREFIX_locate_subcommand $DIR $@
      else
        echo "Command not found : $@"
        echo "   COMMAND = "$COMMAND
        echo "   FUNC = run_SHELL_PREFIX_"$(slugify $COMMAND)
        echo "   BASE_DIR = "$BASE_DIR
        echo "   FILE = "$FILE
        echo "   CLI = "$@
      fi
    fi
  fi
}


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
       if [ "$1" == "help" ]; then
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
export -f SHELL_PREFIX
