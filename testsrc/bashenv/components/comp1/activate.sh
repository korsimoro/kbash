#!/bin/bash


activate_environment_docs() {
  echo "Docs Environment Enabled"
  prepare_nvm_and_version $DOCS_NODE_VERSION
  #export NODE_PATH=$DOCS_NODE_MODULES
}
activate_environment_docs_help() {
printf "`cat << EOF
${BLUE}kd activate docs${NC}

EOF
`\n"
}
