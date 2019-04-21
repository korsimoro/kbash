#!/bin/bash

kbash_shell_integrate() {
  local ENTRYPOINT=$1
  local VAR_PREFIX=$2
  local INPUT=$3
  if [ -f "$INPUT" ]; then
    #echo "Load $INPUT"
    eval "$(cat $INPUT | sed s/VAR_PREFIX/$VAR_PREFIX/g | sed s/ENTRYPOINT/$ENTRYPOINT/g )"
  else
    echo "Failed to load $INPUT while activating $VAR_PREFIX environment"
  fi
}
