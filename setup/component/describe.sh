#!/bin/bash


export COMPONENT_VAR_PREFIX_BASE=$KXX/COMPONENT_NAME
export COMPONENT_VAR_PREFIX_NODE_VERSION=
export COMPONENT_VAR_PREFIX_PYTHON_VERSION=



vet_environment_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:vet"
}


describe_environment_COMPONENT_NAME() {
  echo "COMPONENT_NAME"

  report_vars "COMPONENT_NAME Build Environment" \
      COMPONENT_VAR_PREFIX_BASE\
      COMPONENT_VAR_PREFIX_NODE_VERSION\
      COMPONENT_VAR_PREFIX_PYTHON_VERSION
}

describe_environment_COMPONENT_NAME_help() {
printf "`cat << EOF
${BLUE}kd activate COMPONENT_NAME${NC}

EOF
`\n"
}
