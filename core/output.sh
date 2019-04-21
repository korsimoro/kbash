#!/bin/bash

# use color codes inside script
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export BLUE='\033[0;34m'
export YELLOW='\033[0;33m'
export NC='\033[0m' # No Color
export BOLD=$(tput bold)
export NORMAL='\033[22m'


# error abort of process
error() {
  report_error "$@"
  exit -1
}
export -f error

# stylized output
report_error() {
  printf "${RED}%s${NC}\n" "$@"
  false
}
export -f report_error

report_heading() {
  printf "${BOLD}%s${NC}\n" "$@"
  false
}
export -f report_heading

report_warning() {
  printf "${YELLOW}%s${NC}\n" "$@"
  false
}
export -f report_warning

report_progress() {
  printf "${BLUE}%s${NC}\n" "$@"
  false
}
export -f report_progress

report_ok() {
  printf "${GREEN}%s${NC}\n" "$@"
  false
}
export -f report_ok

report_subheading() {
  printf "${BLUE}%s${NC}\n" "$@"
  false
}
export -f report_subheading

# utilities for printing information
report_pair() {
  local WIDTH=15
  local VAR=$1
  local VALUE=$2
  local MIDDLE=$3
  printf " ${GREEN}%-${WIDTH}s${NC} %s %s\n" "${VAR}" "${MIDDLE}" "${VALUE}"
}
export -f report_pair

report_var_value() {
  local VAR=$1
  report_pair "$VAR" "${!VAR}" "="
}
export -f report_var_value

report_vars() {
  local WIDTH=15
  MESSAGE=$1
  shift 1

  report_subheading $MESSAGE
  for x in "$@"; do
    report_var_value "$x" "$(eval "echo \"\$$x\"")" "="
  done;
}
export -f report_vars
