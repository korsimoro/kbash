#!/bin/bash

# Usage: ENTRYPOINT_classify "DIR" "PROBE"
#
# This function looks at a directory and a name and attempts to determine if
# if it is a "command function" or a "command scope" - a function is identified
# by the presence of a file $DIR/$PROBE.sh and a scope is identified by
# the presence of a $DIR/$PROBE/.scope.sh.  The result of this function is thus
#
#  "scope" -> if $DIR/$PROBE/.scope.sh
#  "file" -> if $DIR/$PROBE.sh exists
#  "other" -> for any other case
#
# Note that scopes are checked first, so a scope can 'mask' a file, but this
# configuration is unlikely to be a problem in the wild
#
function ENTRYPOINT_classify() {
  local DIR=$1
  local PROBE=$2

  if [ ! -d "$DIR" ]; then
    #report_error
    echo "other"
  fi

  if [ -f "$DIR/$PROBE/.scope.sh" ]; then
    echo "scope"
  else
    if [ -f "$DIR/$PROBE.sh" ]; then
      echo "file"
    else
      echo "other"
    fi
  fi
}
export -f ENTRYPOINT_classify
