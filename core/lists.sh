#!/bin/bash

sort_list() {
  echo "$@" | tr ' ' '\n' | sort | tr '\n' ' '
}
export -f sort_list

sorted_key_set() {
  echo "$@" | tr ' ' '\n' | sort | uniq | tr '\n' ' '
}
export -f sorted_key_set

contains() {
  local LIST=$1
  local TERM=$2
  [[ $LIST =~ (^|[[:space:]])"$TERM"($|[[:space:]]) ]]
}

export -f contains
