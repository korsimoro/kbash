#!/bin/bash

sort_list() {
  echo "$@" | tr ' ' '\n' | sort | tr '\n' ' '
}
sorted_key_list() {
  echo "$@" | tr ' ' '\n' | sort | uniq | tr '\n' ' '
}
contains() {
  local LIST=$1
  local TERM=$2
  [[ $LIST =~ (^|[[:space:]])"$TERM"($|[[:space:]]) ]]
}

export -f sort_list sorted_key_list contains
