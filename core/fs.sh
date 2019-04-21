#!/bin/bash

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
export -f pathof

pushdir() {
  pushd $1 >/dev/null
}
export -f pushdir

popdir() {
  popd >/dev/null
}
export -f popdir

ensure_empty_dir() {
  DIR=$1
  if [ -f "$DIR" ] || [ -d "$DIR" ]; then
    rm -rf $DIR
  fi
  mkdir -p $DIR
  echo $DIR
}
export -f ensure_empty_dir

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
