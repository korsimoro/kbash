#!/bin/bash


sorted_key_set() {
  echo "$@" | tr ' ' '\n' | sort | uniq | tr '\n' ' '
}
export -f sorted_key_set
