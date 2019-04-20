#!/bin/bash
# Just fetch updates

print_help() {
printf "`cat << EOF
${BLUE}kd update ${NC}

EOF
`\n\n"

}

run() {
  git pull origin
  kd reset
}
