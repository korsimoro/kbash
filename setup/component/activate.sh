#!/bin/bash


activate_environment_COMPONENT_NAME() {
  echo "COMPONENT_NAME Environment Enabled"
  prepare_nvm_and_version $COMPONENT_NAME_NODE_VERSION
  #export NODE_PATH=$COMPONENT_NAME_NODE_MODULES
}
activate_environment_COMPONENT_NAME_help() {
printf "`cat << EOF
${BLUE}kd activate COMPONENT_NAME${NC}

EOF
`\n"
}
