#!/bin/bash
# Generate help manual

print_help() {
printf "`cat << EOF
Recursively assembleup documentation as a markdown
file.
EOF
`\n\n"

}

print_scope_help_summary() (

  local PREFIX="$1"
  local CMD_PATH="$2"
  declare -A COMMAND_MAP
  declare -A SCOPE_DIR_MAP
  declare -a DIR_SEARCH_LIST=()

  local ACTIVE_SCOPE="$3"
  if [ ! -z "$ACTIVE_SCOPE" ]; then
    DIR_SEARCH_LIST+=("$ACTIVE_SCOPE")
  else
    DIR_SEARCH_LIST+=("$KBASH_API_COMMAND_DIR" "$VAR_PREFIX_KBASH_COMMAND")
  fi

  for BASE in "${DIR_SEARCH_LIST[@]}"; do

    local KIDS=$(ls -1 $BASE/*.sh  2>/dev/null)
    if [ ! -z "$KIDS" ]; then
      KIDS=$(echo $KIDS | xargs -n 1 basename | sed s/.sh$//g | sort)
    fi

    local SCOPES=$(ls -1 $BASE/*/.scope.sh 2>/dev/null)
    if [ ! -z "$SCOPES" ]; then
      SCOPES=$(ls -1 $BASE/*/.scope.sh | xargs -n 1 dirname | xargs -n 1 basename || true | sort)
    fi


    if [ ! -z "$KIDS" ]; then
      for KID in $KIDS; do
        local SCRIPT_FILE="$BASE/$KID.sh"
        local ONELINER=$(head -n 2 "$SCRIPT_FILE" | tail -n 1 | colrm 1 2)
        COMMAND_MAP["$KID"]="$ONELINER"
      done
    fi

   if [ ! -z "$SCOPES" ]; then
     for SCOPE in $SCOPES; do
        local SCRIPT_FILE="$BASE/$SCOPE/.scope.sh"
        local ONELINER=$(head -n 2 "$SCRIPT_FILE" | tail -n 1 | colrm 1 2)
        COMMAND_MAP["$SCOPE"]="$ONELINER"
        SCOPE_DIR_MAP["$SCOPE"]="$BASE/$SCOPE"
      done
    fi
  done


  local STARTCODE="\`\`\`"
  local STARTBLOCK="\`\`\`shell \n"
  local ENDCODE="\`\`\`"
  if [ ! -z "$(echo ${!COMMAND_MAP[@]})" ]; then
    for KEY in $(sorted_key_set $(for key in "${!COMMAND_MAP[@]}"; do echo "$key"; done)); do
      local SCOPE_DIR="${SCOPE_DIR_MAP[$KEY]}"
      printf "${PREFIX} ${STARTCODE}${KEY}${ENDCODE}\n\n${STARTBLOCK}$($CMD_PATH $KEY help)\n${ENDCODE}\n\n"
      if [ ! -z "$SCOPE_DIR" ]; then
        print_scope_help_summary "${PREFIX}#" "$CMD_PATH $KEY" "$SCOPE_DIR"
      fi
    done
  fi

)


run() {
  export YELLOW=''
  export RED=''
  export BLUE=''
  export GREEN=''
  export NC=''
  export BOLD=''
  export NORMAL=''
  # if we don't do this, then print_help above is called for the
  # first invocation of 'kd help'

  local STARTCODE="\`\`\`"
  local STARTBLOCK="\`\`\`shell \n"
  local ENDCODE="\`\`\`"
  printf "`cat << EOF

# ENTRYPOINT

${STARTBLOCK}$(ENTRYPOINT )\n${ENDCODE}

# Functions

Functions manipulate the local shell variables, unlike commands, which are
executed by the shell as a subprocess.

EOF
`\n\n"

for FUNC in $VAR_PREFIX_FUNCTION_LIST; do
  printf "## ${STARTCODE}$(function_slug_to_dashes $FUNC)${ENDCODE}\n\n${STARTBLOCK}\n"
  printf "$(ENTRYPOINT $FUNC help)\n"
  printf "${ENDCODE}\n\n\n"
done

printf "`cat << EOF

# Commands
EOF
`\n\n"

print_scope_help_summary "###" "ENTRYPOINT"

if [ ! -z "$VAR_PREFIX_COMPONENT_LIST" ]; then
  printf "`cat << EOF

# Components
EOF
  `\n\n"

  printf "|Component|Description|\n|-|-|\n"
  for COMPONENT in $VAR_PREFIX_COMPONENT_LIST; do
    printf "|$COMPONENT|$(oneline_description_of_ENTRYPOINT_$COMPONENT )|\n"
  done
  printf "\n\n"

  for COMPONENT in $VAR_PREFIX_COMPONENT_LIST; do
    printf "## ${STARTCODE}$COMPONENT${ENDCODE}\n\n${STARTBLOCK}\n"
    printf "$(ENTRYPOINT $COMPONENT help)\n"
    printf "${ENDCODE}\n\n\n"

    kbash_trace print_scope_help_summary "###" "ENTRYPOINT $COMPONENT" "$VAR_PREFIX_COMPONENT_DIR/$COMPONENT/commands"
    print_scope_help_summary "###" "ENTRYPOINT $COMPONENT" "$VAR_PREFIX_COMPONENT_DIR/$COMPONENT/commands"

  done
fi

printf "`cat << EOF

# About

${STARTBLOCK}$(ENTRYPOINT about )\n${ENDCODE}

EOF
`\n\n"
}
