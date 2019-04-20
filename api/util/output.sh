#!/bin/bash
shopt -s extglob

# use color codes inside script
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export BLUE='\033[0;34m'
export YELLOW='\033[0;33m'
export NC='\033[0m' # No Color
export BOLD=$(tput bold)
export NORMAL='\033[22m'



error() {
  report_error "$@"
  exit -1
}
report_error() {
  printf "${RED}%s${NC}\n" "$@"
  false
}
report_heading() {
  printf "${BOLD}%s${NC}\n" "$@"
  false
}
report_warning() {
  printf "${YELLOW}%s${NC}\n" "$@"
  false
}
report_progress() {
  printf "${BLUE}%s${NC}\n" "$@"
  false
}
report_ok() {
  printf "${GREEN}%s${NC}\n" "$@"
  false
}
report_subheading() {
  printf "${BLUE}%s${NC}\n" "$@"
  false
}
function report_var_value() {
  local WIDTH=15
  local VAR=$1
  local VALUE=$2
  local MIDDLE=$3
  printf " ${GREEN}%-${WIDTH}s${NC} %s %s\n" "${VAR}" "${MIDDLE}" "${VALUE}"
}
export -f report_var_value
function report_vars() {
  local WIDTH=15
  MESSAGE=$1
  shift 1

  report_subheading $MESSAGE
  for x in "$@"; do
    report_var_value "$x" "$(eval "echo \"\$$x\"")" "="
  done;
}


export -f  error report_error report_heading report_subheading report_ok report_warning report_progress
