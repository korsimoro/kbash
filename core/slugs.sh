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
