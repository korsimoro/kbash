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

kbash_warn() {
	printf "${GREEN}%s${NC}\n" "$@"
}
kbash_info() {
	printf "${BLUE}%s${NC}\n" "$@"
}

kbash_trace() {
  if [ "true" = "$KBASH_TRACE" ]; then
		local WIDTH1=25
		local WIDTH2=10
		local WIDTH3=25
		if [ "$#" = 1 ]; then
			local TAG="unknown"
			local SHORT="none"
			local MSG="$@"
		else
			local TAG=$(echo "$1" | colrm $WIDTH1 )
			local SHORT=$(basename "$2")
			shift 2
			local MSG="$@"
		fi
		local CALLER=$(caller 1)
		local LINE=$(echo "$CALLER" | cut -d " " -f 1)
		local SUB=$(echo "$CALLER" | cut -d " " -f 2 | colrm $WIDTH2)
		local FILE=$(echo "$CALLER" | cut -d " " -f 3 )
		if [ "$FILE" = "" ]; then
			FILE=$(echo "unspecified" | colrm $WIDTH3)
		else
			FILE=$(basename $FILE | colrm $WIDTH3)
		fi
		#printf "${BLUE}%15s${NC}\n${BLUE}+${NC}  ${YELLOW}%25s${NC}\n${BLUE}+${NC}  %s\n" "$TAG" "$CALLER" "$@" >&2
		printf "${BLUE}%${WIDTH1}s${NC} ${YELLOW}%3s:%${WIDTH2}s:%${WIDTH3}s${NC} -> %s %s\n" "$TAG" "$LINE" "$SUB" "$FILE" "$SHORT" "$MSG" >&2
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
