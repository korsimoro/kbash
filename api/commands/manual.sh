#!/bin/bash
# Generate help manual

print_help() {
printf "`cat << EOF
Recursively assembleup documentation as a markdown
file.
EOF
`\n\n"

}


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

## Functions

Functions manipulate the local shell variables, unlike commands, which are
executed by the shell as a subprocess.

EOF
`\n\n"

for FUNC in $VAR_PREFIX_FUNCTION_LIST; do
  printf "### ${STARTCODE}$(function_slug_to_dashes $FUNC)${ENDCODE}\n\n${STARTBLOCK}\n"
  printf "$(ENTRYPOINT $FUNC help)\n"
  printf "${ENDCODE}\n\n\n"
done



printf "`cat << EOF

## Components
EOF
`\n\n"

for COMPONENT in $VAR_PREFIX_COMPONENT_LIST; do
  printf "### ${STARTCODE}$COMPONENT${ENDCODE}\n\n${STARTBLOCK}\n"
  printf "$(ENTRYPOINT $COMPONENT help)\n"
  printf "${ENDCODE}\n\n\n"


done

printf "`cat << EOF

## About

${STARTBLOCK}$(ENTRYPOINT about )\n${ENDCODE}

EOF
`\n\n"
}
