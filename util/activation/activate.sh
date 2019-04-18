#!/bin/bash
# Activates kit workbench development environment
#
# Overall Plan
#
# - establlish base directory and update an activation count

#
#
#

# where are we?

export K_BASHENV_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )

k_bashenv_shell_integrate() {
  local SHELL_PREFIX=$1
  local VAR_PREFIX=$2
  local INPUT=$3
  if [ -f "$INPUT" ]; then
    #echo "Load $INPUT"
    eval "$(cat $INPUT | sed s/VAR_PREFIX/$VAR_PREFIX/g | sed s/SHELL_PREFIX/$SHELL_PREFIX/g )"
  else
    echo "Failed to load $INPUT while activating $VAR_PREFIX environment"
  fi
}

k_bashenv_load_functions_from_dir() {
  local SHELL_PREFIX=$1
  local VAR_PREFIX=$2
  local DIR_TO_SCAN=$3
  local FUNC_FILES=$(find_dot_sh $DIR_TO_SCAN)
  local BASHENV_VAR="${VAR_PREFIX}_FUNCTION_LIST"

  for FUNCTION_FILE in $FUNC_FILES; do
    local FUNC_NAME=$(function_slug "$FUNCTION_FILE" )
    k_bashenv_shell_integrate "$SHELL_PREFIX" "$VAR_PREFIX" "$DIR_TO_SCAN/$FUNCTION_FILE"
    eval $BASHENV_VAR=\"$(echo "${!BASHENV_VAR} $FUNC_NAME")\"
  done
  eval $BASHENV_VAR=\"$(sort_list "${!BASHENV_VAR}")\"
}

k_bashenv_load_system_environment() {
  local SHELL_PREFIX=$1
  local VAR_PREFIX=$2
  local SYSTEM_LOAD_LIST=$3

  k_bashenv_load_functions_from_dir "$SHELL_PREFIX" "$VAR_PREFIX" "$K_BASHENV_BASE/functions"

  for FUNCTION_FILE in $SYSTEM_LOAD_LIST; do
    k_bashenv_shell_integrate "$SHELL_PREFIX" "$VAR_PREFIX" "$K_BASHENV_BASE/$FUNCTION_FILE"
  done
}

k_bashenv_load_user_environment() {

  local SHELL_PREFIX=$1
  local VAR_PREFIX=$2
  local USER_LOAD_LIST=$3

  local BASHENV_VAR="${VAR_PREFIX}_BASH"

  for FUNCTION_FILE in $USER_LOAD_LIST; do
    k_bashenv_shell_integrate "$SHELL_PREFIX" "$VAR_PREFIX" "${!BASHENV_VAR}/$FUNCTION_FILE"
  done

  k_bashenv_load_functions_from_dir "$SHELL_PREFIX" "$VAR_PREFIX" "${!BASHENV_VAR}/functions"
}


# these require the SHELL_PREFIX and VAR_PREFIX be passed in as variables.  In
# all other files, SHELL_PREFIX and VAR_PREFIX will be removed, and should be
# used in place - as in VAR_PREFIX_X instead of ${VAR_PREFIX}_X - this is because
# VAR_PREFIX is also the name of the base dir - so $VAR_PREFIX is the base directory
# of the SHELL_PREFIX scope
k_bashenv_shell_integrate "$1" "$2" "$K_BASHENV_BASE/util/os.sh"
k_bashenv_shell_integrate "$1" "$2" "$K_BASHENV_BASE/util/activation/state.sh"
k_bashenv_shell_integrate "$1" "$2" "$K_BASHENV_BASE/util/activation/count.sh"
k_bashenv_shell_integrate "$1" "$2" "$K_BASHENV_BASE/util/activation/prompt.sh"
k_bashenv_shell_integrate "$1" "$2" "$K_BASHENV_BASE/util/cli/helpsystem.sh"
k_bashenv_shell_integrate "$1" "$2" "$K_BASHENV_BASE/util/cli/entrypoint.sh"
k_bashenv_shell_integrate "$1" "$2" "$K_BASHENV_BASE/util/cli/script.sh"
k_bashenv_shell_integrate "$1" "$2" "$K_BASHENV_BASE/util/components/driver.sh"
k_bashenv_shell_integrate "$1" "$2" "$K_BASHENV_BASE/util/components/helpsystem.sh"
k_bashenv_shell_integrate "$1" "$2" "$K_BASHENV_BASE/util/components/parallel.sh"
k_bashenv_load_system_environment "$1" "$2" "$4"
k_bashenv_load_user_environment "$1" "$2" "$3"

# these are defined above
$1_load_components

cd ${!2}
