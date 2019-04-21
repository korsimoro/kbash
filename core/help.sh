#!/bin/bash

# identify a string as a help option
is_help_option() {
  local COMMAND=$1
   [ "$COMMAND" == "help" ] ||\
   [ "$COMMAND" == "--help" ] ||\
   [ "$COMMAND" == "-help" ] ||\
   [ "$COMMAND" == "?" ] ||\
   [ "$COMMAND" == "-h" ]
}
is_help_option_or_empty() {
  local COMMAND=$1
  [ -z "$COMMAND" ] || is_help_option "$COMMAND"
}
