#!/bin/bash


print_SHELL_PREFIX_script() {
  INIT_SCRIPT=("$@")
  for CMDLINE in "${INIT_SCRIPT[@]}"; do
    echo "$CMDLINE"
  done
}
exec_SHELL_PREFIX_script() {
  INIT_SCRIPT=("$@")
  print_SHELL_PREFIX_script "${INIT_SCRIPT[@]}"
  local LABEL
  local RESULT
  for CMDLINE in "${INIT_SCRIPT[@]}"; do
    LABEL="${BLUE}COMMAND $CMDLINE${NC}\n"
    if COMMAND $CMDLINE; then
      RESULT="${GREEN}Passed${NC}"
      printf "$RESULT $LABEL"
    else
      RESULT="${RED}Failed${NC}"
      printf "$RESULT $LABEL"
      return -1
    fi
  done
}

exec_silent_SHELL_PREFIX_script() {
  INIT_SCRIPT=("$@")
  for CMDLINE in "${INIT_SCRIPT[@]}"; do
    if ! COMMAND $CMDLINE; then
      return -1
    fi
  done
}

exec_silent_ballistic_SHELL_PREFIX_script() {
  INIT_SCRIPT=("$@")
  # set +e
  for CMDLINE in "${INIT_SCRIPT[@]}"; do
    COMMAND $CMDLINE;
  done
}
