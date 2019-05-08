#!/bin/bash
#
# Used in two cases
#
#  ENTRYPOINT_print_scope_help_summary
#  ENTRYPOINT_print_scope_help_summary <DIR>
#
# In the first case it combines all component,
#
ENTRYPOINT_print_scope_help_summary() {

  declare -A VAR_PREFIX_COMMAND_LIST
  declare -a VAR_PREFIX_TOPLEVEL_SEARCH_LIST=()

  local ACTIVE_SCOPE="$1"
  if [ ! -z "$ACTIVE_SCOPE" ]; then
    VAR_PREFIX_TOPLEVEL_SEARCH_LIST+=("$ACTIVE_SCOPE")
  else
    VAR_PREFIX_TOPLEVEL_SEARCH_LIST+=("$KBASH_API_COMMAND_DIR" "$VAR_PREFIX_KBASH_COMMAND")
  fi

  for BASE in "${VAR_PREFIX_TOPLEVEL_SEARCH_LIST[@]}"; do

    local KIDS=$(ls -1 $BASE/*.sh  2>/dev/null)
    if [ ! -z "$KIDS" ]; then
      KIDS=$(echo $KIDS | xargs -n 1 basename | sed s/.sh$//g | sort)
    fi

    local SCOPES=$(ls -1 $BASE/*/.scope.sh 2>/dev/null)
    if [ ! -z "$SCOPES" ]; then
      SCOPES=$(ls -1 $BASE/*/.scope.sh | xargs -n 1 dirname | xargs -n 1 basename || true | sort)
    fi


    # map the KIDS and the SCOPES into a single variable, called
    # VAR_PREFIX_COMMAND_LIST, which is an array of strings - this can be
    # sorted, and this is how the commands and scopes are intermingled
    if [ ! -z "$KIDS" ]; then
      for KID in $KIDS; do
        local SCRIPT_FILE="$BASE/$KID.sh"
        local ONELINER=$(head -n 2 "$SCRIPT_FILE" | tail -n 1 | colrm 1 2)
        VAR_PREFIX_COMMAND_LIST["$KID"]="$ONELINER"
      done
    fi

   if [ ! -z "$SCOPES" ]; then
     for SCOPE in $SCOPES; do
        local SCRIPT_FILE="$BASE/$SCOPE/.scope.sh"
        local ONELINER=$(head -n 2 "$SCRIPT_FILE" | tail -n 1 | colrm 1 2)
        VAR_PREFIX_COMMAND_LIST["$SCOPE"]="$ONELINER"
      done
    fi
  done

  # print the sorted list
  if [ ! -z "$(echo ${!VAR_PREFIX_COMMAND_LIST[@]})" ]; then
    printf "\nCommands (run as subprocesses)\n"
    for KEY in $(sorted_key_set $(for key in "${!VAR_PREFIX_COMMAND_LIST[@]}"; do echo "$key"; done)); do
      report_pair "$KEY" "${VAR_PREFIX_COMMAND_LIST[$KEY]}"
    done
    printf "\n"
  fi

}
