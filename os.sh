#!/bin/bash
shopt -s extglob


is_being_sourced() {
	echo "${BASH_SOURCE[0]}"
	echo "${0}"
	[[ "${BASH_SOURCE[0]}" != "${0}" ]] && true || false
}
export -f is_being_sourced

is_being_executed() {
  [ ! is_being_sourced ]
}
is_windows() {
  [ ! -z "$(uname -a | grep Microsoft)" ]
}
export -f is_windows

is_osx() {
  [ ! -z "$(uname -a | grep Darwin)" ]
}
export -f is_osx
is_linux() {
	[ ! -z "$(uname -a | grep Linux)" ]
}
export -f is_linux

kbash_trace() {
  if [ "true" = "$KBASH_TRACE" ]; then
		local TAG=$1
		shift 1
    printf "${BLUE}%15s${NC}\n  ${YELLOW}%25s${NC}\n  %s\n" "$TAG" "$(caller )" "$@" >&2
  fi
}
export -f kbash_trace

# https://stackoverflow.com/questions/360201/how-do-i-kill-background-processes-jobs-when-my-shell-script-exits
# careful - this will also kill your tree when you encounter a command with an
#           error exit, which may not be what you expect when querying external
#           resources.  so we wrap this in an "prepare_for_long_running_kids"
#           function
prepare_for_long_running_kids() {
  #trap 'exit $rc' INT
  #trap 'exit $rc' TERM
  trap 'exit $?' EXIT
}
export -f prepare_for_long_running_kids
