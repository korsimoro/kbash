#!/bin/bash

# this is the prefix used to
SHELL_PREFIX=$1
VAR_PREFIX=$2
USER_UTIL_LOAD_LIST=$3
SYSTEM_UTIL_LOAD_LIST=$4

# load
for SHELL_MODULE in \
  "$K_BASHENV_BASE/util/os.sh"\
  "$K_BASHENV_BASE/util/output.sh"\
  "$K_BASHENV_BASE/util/activation/state.sh"\
  "$K_BASHENV_BASE/util/activation/count.sh"\
  "$K_BASHENV_BASE/util/activation/prompt.sh"\
  "$K_BASHENV_BASE/util/cli/helpsystem.sh"\
  "$K_BASHENV_BASE/util/cli/commands.sh"\
  "$K_BASHENV_BASE/util/cli/entrypoint.sh"\
  "$K_BASHENV_BASE/util/cli/script.sh"\
  "$K_BASHENV_BASE/util/components/driver.sh"\
  "$K_BASHENV_BASE/util/components/helpsystem.sh"\
  "$K_BASHENV_BASE/util/components/parallel.sh"\
  "$K_BASHENV_BASE/util/python.sh"\
  "$K_BASHENV_BASE/util/node.sh";
do
  k_bashenv_shell_integrate "$1" "$2" "$SHELL_MODULE"
done

#
k_bashenv_load_system_environment "$1" "$2" "$4"

k_bashenv_load_user_environment "$1" "$2" "$3"

# these are defined above
$1_load_components

cd ${!2}
