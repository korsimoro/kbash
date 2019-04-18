#!/bin/bash
# Execute a script of kd commands

print_help() {
printf "`cat << EOF
${BLUE}kd script <file>${NC}

Run a set of KD commands

-e|--echo

EOF
`\n\n"

}

ECHO=false
LOGFILE=/dev/null
LOGALL=false
LOGONLY=false
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -e|--echo)
    ECHO=true
    shift
    ;;
    -lf|--log-file)
    shift
    LOGFILE=$1
    shift
    ;;
    -la|--log-all)
    LOGALL=true
    shift
    ;;
    -lo|--log-only)
    LOGONLY=true
    shift
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

runscript() (
  grep -v '^#' $SCRIPT | while read -r line ; do
    if $ECHO; then
      echo kd $line
    fi
    kd $line
  done
)

run() {
  if [ -z "$1" ]; then
    print_help
    error Require path to file
  fi
  if [ "$1" = "-" ]; then
    SCRIPT=
  else
    if [ ! -f "$1" ]; then
      print_help
      error Require path to file, $1 is not a file
    fi
    SCRIPT=$1
  fi

  if $LOGALL; then
    if $LOGONLY; then
      runscript 2>&1 >${LOGFILE}
    else
      runscript 2>&1 | tee ${LOGFILE}
    fi
  else
    if $LOGONLY; then
      runscript >${LOGFILE}
    else
      runscript | tee ${LOGFILE}
    fi
  fi

}
