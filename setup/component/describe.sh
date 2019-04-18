#!/bin/bash


export COMPONENT_VAR_PREFIX_BASE=$VAR_PREFIX/COMPONENT_NAME
export COMPONENT_VAR_PREFIX_NODE_VERSION=
export COMPONENT_VAR_PREFIX_PYTHON_VERSION=

oneline_description_of_SHELL_PREFIX_COMPONENT_NAME() {
  echo "Description of COMPONENT_NAME"
}

vet_environment_SHELL_PREFIX_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:vet"
}

describe_environment_SHELL_PREFIX_COMPONENT_NAME_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX describe COMPONENT_NAME${NC}

EOF
`\n"
}

describe_environment_SHELL_PREFIX_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:describe"

  report_vars "COMPONENT_NAME Build Environment" \
      COMPONENT_VAR_PREFIX_BASE\
      COMPONENT_VAR_PREFIX_NODE_VERSION\
      COMPONENT_VAR_PREFIX_PYTHON_VERSION
}
