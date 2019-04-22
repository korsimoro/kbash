#!/bin/bash

contains() {
  local LIST=$1
  local TERM=$2
  [[ $LIST =~ (^|[[:space:]])"$TERM"($|[[:space:]]) ]]
}

export -f contains
