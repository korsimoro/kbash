#!/bin/bash
# view docs

print_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT COMPONENT_NAME info${NC}

Info about ENTRYPOINT COMPONENT_NAME

EOF
`\n"
}

run() (
  echo "Info about ENTRYPOINT COMPONENT_NAME"
)
