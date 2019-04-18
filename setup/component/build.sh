#!/bin/bash

build_environment_COMPONENT_NAME() {
  prepare_nvm_and_version $COMPONENT_NAME_NODE_VERSION
  cd $DOC_VIEWER_BASE
  yarn clean
  yarn install
  yarn dist
}
build_environment_COMPONENT_NAME_help() {
printf "`cat << EOF
${BLUE}kd build COMPONENT_NAME${NC}

EOF
`\n"
}
