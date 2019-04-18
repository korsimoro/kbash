#!/bin/bash
# Generate help manual

print_help() {
printf "`cat << EOF
${BLUE}kd manual ${NC}

Recursively assemble documentation as a markdown
file.
EOF
`\n\n"

}

dump_manual() (
  X="$@"
  if [[ $DEPTH -gt 0 ]]; then
    for i in $(seq 1 $DEPTH); do
      printf "#"
    done
    printf " $X\n"
  fi

  printf "\`\`\`\n"
  $@ help
  printf "\`\`\`\n"

  X=${X// /-}
  DEPTH=$((DEPTH+1))
  CMDS="$(findkids $X)"
  KIDS="$TOP_LEVEL_FUNCTIONS $CMDS"
  KIDS=$(echo $KIDS | tr ' ' '\n' | sort)
  TOP_LEVEL_FUNCTIONS=""
  for KID in $KIDS; do
    dump_manual $@ "$KID"
  done
)

run() {
  export YELLOW=''
  export RED=''
  export BLUE=''
  export GREEN=''
  export NC=''
  export BOLD=''
  export NORMAL=''
  # if we don't do this, then print_help above is called for the
  # first invocation of 'kd help'
  . $KITWB_BASH_DIR/kd-help.sh
  DEPTH=0
  TOP_LEVEL_FUNCTIONS=$FUNCS
  printf "# Table of contents\n"
  dump_manual kd | $KITWB_SCRIPTS_DIR/gh-md-toc -
  printf "# KD Help\n"
  DEPTH=0
  dump_manual kd
}
