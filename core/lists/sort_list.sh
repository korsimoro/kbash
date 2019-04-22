#!/bin/bash

sort_list() {
  echo "$@" | tr ' ' '\n' | sort | tr '\n' ' '
}
export -f sort_list
