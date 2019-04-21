#!/bin/bash
# this is the entrypoint for activating the KBASH environment

# see docs for detailed explanation of the four startup variables
ENTRYPOINT=$1
VAR_PREFIX=$2
USER_UTIL_LOAD_LIST=$3
LANG_LOAD_LIST=$4

# establish the base directory of the core...
export KBASH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export KBASH_CORE=$KBASH/core
export KBASH_LANG=$KBASH/lang

# API relevant functions - these arer filtered against both ENTRYPOINT
# and VAR_PREFIX, so the
export KBASH_API=$KBASH/api
export KBASH_API_COMMAND_DIR=$KBASH_API/commands
export KBASH_API_FUNCTION_DIR=$KBASH_API/functions
export KBASH_API_UTIL_DIR=$KBASH_API/util

if [ -z "${!VAR_PREFIX}" ]; then
  echo "The $VAR_PREFIX variable is not set - this must be set in activate"
else
  # load functions used during bootstrap
  if [ ! -f "$KBASH/os.sh" ]; then
    echo "Can not find OS utilities, looking in $KBASH/os.sh"
  else
    # import basic OS coupling as well as kbash_trace function, for use in
    # debugging the KBASH startup
    . $KBASH/os.sh

    # load core modules, in order - each can use the features defined in the
    # earlier entries
    kbash_trace loading-core-modules "$KBASH_CORE"
    for CORE_MODULE in \
        "output"\
        "fs"\
        "lists"\
        "help"\
        "load_functions_from_dir"\
        "path"\
        "shell_integrate"\
        "slugs"\
        ; do
            kbash_trace load-core-module "$CORE_MODULE"
            . ${KBASH_CORE}/${CORE_MODULE}.sh
    done

    # integrate API modules, these will be filtered against ENTRYPOINT
    # and VAR_PREFIX variables
    kbash_trace integrate-api-modules "$KBASH_API"
    for API_MODULE in \
      "$KBASH_API_UTIL_DIR/cli/state"\
      "$KBASH_API_UTIL_DIR/cli/completion"\
      "$KBASH_API_UTIL_DIR/cli/count"\
      "$KBASH_API_UTIL_DIR/cli/reprompt"\
      "$KBASH_API_UTIL_DIR/cli/classify"\
      "$KBASH_API_UTIL_DIR/cli/process_command_scope"\
      "$KBASH_API_UTIL_DIR/cli/process_command_scope_visitor"\
      "$KBASH_API_UTIL_DIR/cli/entrypoint"\
      "$KBASH_API_UTIL_DIR/help/print_main_help"\
      "$KBASH_API_UTIL_DIR/help/print_scope_help_summary"\
      "$KBASH_API_UTIL_DIR/help/print_component_help_summary"\
      "$KBASH_API_UTIL_DIR/help/print_function_help"\
      "$KBASH_API_UTIL_DIR/help/print_function_help_summary"\
      "$KBASH_API_UTIL_DIR/components/driver/load_component"\
      "$KBASH_API_UTIL_DIR/components/driver/load_components"\
      "$KBASH_API_UTIL_DIR/components/driver/run_component_func"\
      "$KBASH_API_UTIL_DIR/components/help/help_on_empty_or_help"\
      "$KBASH_API_UTIL_DIR/components/help/print_component_list"\
      "$KBASH_API_UTIL_DIR/components/help/print_component_help"\
      "$KBASH_API_UTIL_DIR/components/parallel"\

      # enable secondary drivbers
      #"$KBASH_API_UTIL_DIR/external/";
    do
      kbash_trace loading-api-module "${API_MODULE}.sh"
      kbash_shell_integrate "$ENTRYPOINT" "$VAR_PREFIX" "${API_MODULE}.sh"
    done

    # load any standard system modules specified.  This is typically
    # used to load language or tool specific support which may or may
    # not be felevant to the $PROJECT in scope
    kbash_trace loading-kbash-functions "$KBASH_API_FUNCTION_DIR"
    kbash_load_functions_from_dir "$ENTRYPOINT" "$VAR_PREFIX" "$KBASH_API_FUNCTION_DIR"

    for LANGUAGE_FILE in $LANG_LOAD_LIST; do
      kbash_trace loading-language-module "$KBASH_LANG/$LANGUAGE_FILE"
      kbash_shell_integrate "$ENTRYPOINT" "$VAR_PREFIX" "$KBASH_LANG/$LANGUAGE_FILE"
    done

    # load the user environment from $PROJECT/bashenv.  This is typically
    # used to load support for concepts unique to $PROJECT.
    for FUNCTION_FILE in $USER_LOAD_LIST; do
      kbash_trace load-project-util "${!BASHENV_VAR}/$FUNCTION_FILE"
      kbash_shell_integrate "$ENTRYPOINT" "$VAR_PREFIX" "${!VAR_PREFIX}/util/$FUNCTION_FILE"
    done

    kbash_trace loading-project-functions
    kbash_load_functions_from_dir "$ENTRYPOINT" "$VAR_PREFIX" "${!VAR_PREFIX}/kbash/functions"

    # thes
    ${ENTRYPOINT}_load_components

    # cd into the directory named by the variable named by VAR_PREFIX.
    cd ${!VAR_PREFIX}
  fi
fi
