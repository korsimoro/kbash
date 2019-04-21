#!/bin/bash
# this is the entrypoint for activating the KBASH environment

# see docs for detailed explanation of the four startup variables
SHELL_PREFIX=$1
VAR_PREFIX=$2
USER_UTIL_LOAD_LIST=$3
LANG_LOAD_LIST=$4

# establish the  base directory of the core...
export KBASH_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export KBASH_CORE=$KBASH_BASE/core
export KBASH_LANG=$KBASH_BASE/lang

# API relevant functions - these arer filtered against both SHELL_PREFIX
# and VAR_PREFIX, so the
export KBASH_API=$KBASH_BASE/api
export KBASH_API_COMMAND_DIR=$KBASH_API/commands
export KBASH_API_FUNCTION_DIR=$KBASH_API/functions
export KBASH_API_UTIL_DIR=$KBASH_API/util

# load functions used during bootstrap
if [ ! -f "$KBASH_BASH/os.sh" ]; then
  echo "Can not find OS utilities, looking in $KBASH_BASH/os.sh"
else
  # import basic OS coupling as well as kbash_trace function, for use in
  # debugging the KBASH startup
  set -e
  . $KBASH_BASH/os.sh
  set +e

  # load core modules, in order - each can use the features defined in the
  # earlier entries
  kbash_trace loading-core-modules "$KBASH_CORE"
  for CORE_MODULE in \
      "output"\
      "fs"\
      "help"\
      "load_functions_from_dir"\
      "load_system_environment"\
      "load_user_environment"\
      "path"\
      "shell_integrate"\
      "slugs"\
      ; do
          kbash_trace load-core-module-start "$CORE_MODULE"
          set -e
          . ${KBASH_CORE}/${CORE_MODULE}.sh
          set +e
          kbash_trace load-core-module-end "$CORE_MODULE"
  done

  # integrate API modules, these will be filtered against SHELL_PREFIX
  # and VAR_PREFIX variables
  kbash_trace integrate-api-modules "$KBASH_API"
  for API_MODULE in \
    "$KBASH_API_UTIL_DIR/kbash/state"\
    "$KBASH_API_UTIL_DIR/kbash/completion"\
    "$KBASH_API_UTIL_DIR/kbash/count"\
    "$KBASH_API_UTIL_DIR/kbash/reprompt"\
    "$KBASH_API_UTIL_DIR/help/print_main_help"\
    "$KBASH_API_UTIL_DIR/cli/classify"\
    "$KBASH_API_UTIL_DIR/cli/commands"\
    "$KBASH_API_UTIL_DIR/cli/receive_event"\
    "$KBASH_API_UTIL_DIR/cli/entrypoint"\
    "$KBASH_API_UTIL_DIR/components/driver"\
    "$KBASH_API_UTIL_DIR/components/helpsystem"\
    "$KBASH_API_UTIL_DIR/components/driver"\

    # enable secondary drivbers
    #"$KBASH_API_UTIL_DIR/external/";
  do
    kbash_trace loading-core-module-start
    kbash_shell_integrate "$SHELL_PREFIX" "$VAR_PREFIX" "${API_MODULE}.sh"
    kbash_trace loading-core-module-end
  done

  # load any standard system modules specified.  This is typically
  # used to load language or tool specific support which may or may
  # not be felevant to the $PROJECT in scope
  kbash_trace loading-system-environment-start
  kbash_load_system_environment "$SHELL_PREFIX" "$VAR_PREFIX" "$SYSTEM_UTIL_LOAD_LIST"
  kbash_trace loading-system-environment-end

  # load the user environment from $PROJECT/bashenv.  This is typically
  # used to load support for concepts unique to $PROJECT.
  kbash_load_user_environment "$SHELL_PREFIX" "$VAR_PREFIX" "$USER_UTIL_LOAD_LIST"

  # thes
  ${SHELL_PREFIX}_load_components

  # cd into the directory named by the variable named by VAR_PREFIX.
  cd ${!VAR_PREFIX}
fi
