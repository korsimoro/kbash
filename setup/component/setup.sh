#!/bin/bash


setup_environment_COMPONENT_NAME() {
  prepare_nvm_and_version $COMPONENT_NAME_NODE_VERSION

  # TODO only if we can't find yarn
  echo "Installing Yarn"
  npm install -g yarn

  # TODO only if we can't find lerna
  echo "Installing Lerna"
  yarn global add lerna
}
setup_environment_COMPONENT_NAME_help() {
printf "`cat << EOF
${BLUE}kd setup COMPONENT_NAME${NC}

EOF
`\n"
}
