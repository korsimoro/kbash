#!/bin/bash
shopt -s extglob

# identify a string as a help option
is_help_option() {
  local COMMAND=$1
   [ "$COMMAND" == "help" ] ||\
   [ "$COMMAND" == "--help" ] ||\
   [ "$COMMAND" == "-help" ] ||\
   [ "$COMMAND" == "?" ] ||\
   [ "$COMMAND" == "-h" ]
}
is_help_option_or_empty() {
  local COMMAND=$1
  [ -z "$COMMAND" ] || is_help_option "$COMMAND"
}

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


is_being_sourced() {
	echo "${BASH_SOURCE[0]}"
	echo "${0}"
	[[ "${BASH_SOURCE[0]}" != "${0}" ]] && true || false
}

# https://stackoverflow.com/questions/3915040/bash-fish-command-to-print-absolute-path-to-a-file
pathof() {
  # $1 : relative filename
  filename=$1
  parentdir=$(dirname "${filename}")

  if [ -d "${filename}" ]; then
      echo "$(cd "${filename}" && pwd)"
  elif [ -d "${parentdir}" ]; then
    echo "$(cd "${parentdir}" && pwd)/$(basename "${filename}")"
  fi
}

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

export -f sort_list sorted_key_list


is_windows() {
  [ ! -z "$(uname -a | grep Microsoft)" ]
}

is_osx() {
  [ ! -z "$(uname -a | grep Darwin)" ]
}

pushdir() {
  pushd $1 >/dev/null
}
popdir() {
  popd >/dev/null
}
ensure_empty_dir() {
  DIR=$1
  if [ -f "$DIR" ] || [ -d "$DIR" ]; then
    rm -rf $DIR
  fi
  mkdir -p $DIR
  echo $DIR
}

# https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path
pathadd() {
    newelement=${1%/}
    if [ -d "$1" ] && ! echo $PATH | grep -E -q "(^|:)$newelement($|:)" ; then
        if [ "$2" = "after" ] ; then
            PATH="$PATH:$newelement"
        else
            PATH="$newelement:$PATH"
        fi
    fi
}

pathrm() {
    PATH="$(echo $PATH | sed -e "s;\(^\|:\)${1%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
}


export -f pushdir popdir is_osx is_windows contains pathadd pathrm





slugify() {
  STRING="$@"
  if is_windows; then
    echo "not-supported"
  else
    if is_osx; then
      echo "$STRING" | iconv -t ascii//TRANSLIT | sed -E s/[^a-zA-Z0-9]+/_/g | sed -E s/^_+\|_+$//g | tr A-Z a-z
    else
      echo "$STRING" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/_/g | sed -r s/^_+\|_+$//g | tr A-Z a-z
    fi
  fi
}
export -f slugify
function_slug()
{
  echo "$1" | sed 's/[/]/_/g' | sed 's/.sh$//g'
}
export -f function_slug

find_dot_sh() (

  DIR="$1"
  if [ ! -d "$DIR" ]; then
    echo ""
    exit -1
  fi

  if is_windows; then
    echo "not-supported"
  else
    if is_osx; then
      cd $DIR
      find . -name \*.sh | colrm 1 2 2>/dev/null
    else
      find $DIR -name \*.sh -printf "%P\n" 2>/dev/null
    fi
  fi
)
export -f find_dot_sh



#
# This component supports bash completion
#
#
#
_SHELL_PREFIX_completion()
{
    # TODO: _split_longopt
    #COMPREPLY=( $( compgen -W '$KITWB_BASH_FUNCTIONS $(kd_findkids kd)' -- "$cur" ) )
    COMPREPLY=""
}
complete -F _$SHELL_PREFIX_completion "$SHELL_PREFIX"
