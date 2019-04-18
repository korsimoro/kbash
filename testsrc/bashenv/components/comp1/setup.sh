#!/bin/bash


setup_environment_docs() {
  prepare_nvm_and_version $DOCS_NODE_VERSION

  # TODO only if we can't find yarn
  echo "Installing Yarn"
  npm install -g yarn

  # TODO only if we can't find lerna
  echo "Installing Lerna"
  yarn global add lerna
}
setup_environment_docs_help() {
printf "`cat << EOF
${BLUE}kd setup docs${NC}

EOF
`\n"
}
