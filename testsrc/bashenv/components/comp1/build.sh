#!/bin/bash

build_environment_docs() {
  prepare_nvm_and_version $DOCS_NODE_VERSION
  cd $DOC_VIEWER_BASE
  yarn clean
  yarn install
  yarn dist
}
build_environment_docs_help() {
printf "`cat << EOF
${BLUE}kd build docs${NC}

EOF
`\n"
}
