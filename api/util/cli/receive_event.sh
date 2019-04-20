#!/bin/bash

# example usage print_kidlist_help COMMAND
#
function SHELL_PREFIX_receive_event() {
  local WIDTH=18
  local ARG=$1
  shift 1
  case $ARG in
    start-command-section)
      printf "Commands\n"
      ;;
    visit-command)
      local KID=$1
      local SCRIPT_FILE=$2
      if [ -f "$SCRIPT_FILE" ]; then
        local ONELINER=$(head -n 2 "$SCRIPT_FILE" | tail -n 1 | colrm 1 2)
        printf "${GREEN}%-${WIDTH}s${NC} %s\n" " $KID" "$ONELINER"
        $VISITOR "$KID" "$ONELINER"
      else
        echo "-no help available-"$SCRIPT_FILE
      fi
      ;;
    end-command-section)
      printf "\n"
      ;;

    start-command-set-section)
      printf "Command Groups\n"
      ;;
    visit-command-set)
      local KID=$1
      local SCRIPT_FILE=$2
      if [ -f "$SCRIPT_FILE" ]; then
        local ONELINER=$(head -n 2 "$SCRIPT_FILE" | tail -n 1 | colrm 1 2)
        printf "${GREEN}%-${WIDTH}s${NC} %s\n" " $KID" "$ONELINER"
        $VISITOR "$KID" "$ONELINER"
      else
        echo "-no help available-"$SCRIPT_FILE
      fi
      ;;
    end-command-set-section)
      printf "\n"
      ;;
    *)
      echo "Invalid Event:"$ARG
      ;;
  esac;

}
