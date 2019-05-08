#!/bin/bash
# List all available components

print_help() {
printf "`cat << EOF
Show component list
EOF
`\n\n"

}

run() {
  ENTRYPOINT_print_component_list
}
