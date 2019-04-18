#!/bin/bash

function run_component_func() {
  FUNC=$1
  local COMPONENT=""
  local CMD=""
  shift 1
  if [ -z "$1$2" ]; then
    COMPONENT="all"
  else
    COMPONENT=$(slugify $1)
    shift 1
  fi

  if [ "$COMPONENT" = "all" ]; then
    for COMPONENT in $SHELL_PREFIX_COMPONENT_LIST; do
      run_component_func $FUNC "$COMPONENT"
    done
  else
    CMD=$FUNC"_environment_"$COMPONENT
    if [ "help" = "$COMPONENT" ]; then
      print_environment_help $FUNC
    else
      if [ "help" = "$1" ]; then
        CMD=$CMD"_help"
        $CMD "$@"
      else
        if [ "--help" = "$1" ]; then
          CMD=$CMD"_help"
          $CMD "$@"
        else
          if vet_environment_$COMPONENT; then
          	if ! $CMD "$@"; then
              echo "Failed to $CMD for $COMPONENT"
              false
            fi
          fi
        fi
      fi
    fi
  fi
}

load_component() {
  local COMPONENT=$1
  local COMP_DIR="${VAR_PREFIX_COMPONENT_DIR}/$COMPONENT"

  for FUNCTION_FILE in $(find_dot_sh "$COMP_DIR"); do
    k_bashenv_shell_integrate "SHELL_PREFIX" "VAR_PREFIX" "$COMP_DIR/$FUNCTION_FILE"
  done

  local COMPONENT_NAME=$(echo "$COMPONENT" | sed s/[/]/_/g | sed s/.sh//g )
  eval VAR_PREFIX_COMPONENT_LIST=\"$(sorted_key_list "${VAR_PREFIX_COMPONENT_LIST} $COMPONENT_NAME")\"
}

load_components() {

  k_bashenv_load_functions_from_dir "SHELL_PREFIX" "VAR_PREFIX" "$K_BASHENV_BASE/util/components/api"

  local BASHENV_COMPLIST_VAR="${VAR_PREFIX}_COMPONENT_LIST"
  local BASHENV_COMPDIR_VAR="${VAR_PREFIX}_COMPONENT_DIR"

  for COMPONENT in $(ls ${VAR_PREFIX_COMPONENT_DIR} ); do
    local COMP_DIR="${VAR_PREFIX_COMPONENT_DIR}/$COMPONENT"
    if [ -d "$COMP_DIR" ]; then
      load_component $COMPONENT
    fi
  done

#  for FUNCTION_FILE in $FUNC_FILES; do
#    local FUNC_NAME=$(echo "$FUNCTION_FILE" | sed s/[/]/_/g | sed s/.sh//g )
#    k_bashenv_shell_integrate "$SHELL_PREFIX" "$VAR_PREFIX" "$DIR_TO_SCAN/$FUNCTION_FILE"
#    eval $BASHENV_VAR=\"$(echo "${!BASHENV_VAR} $FUNC_NAME")\"
#  done
#  eval $BASHENV_VAR=\"$(sort_list "${!BASHENV_VAR}")\"

  #ls -al $K_BASHENV_BASE/util/components/api
#  local API_COMMANDS=$(find_dot_sh $K_BASHENV_BASE/util/components/api)
#  for API_COMMAND in $API_COMMANDS; do
#    echo "LOAD $API_COMMAND"
#    #k_bashenv_shell_integrate "$SHELL_PREFIX" "$VAR_PREFIX" "${!BASHENV_VAR}/$FUNCTION_FILE"
#
#  done
}
