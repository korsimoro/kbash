#!/bin/bash

eval export ${PREFIX}_PYTHON3=$(command -v python3)
eval export ${PREFIX}_VIRTUALENV=$(command -v virtualenv)

create_python3_env() {
  local TARGET=$1
  local PYTHON3_VAR=${PREFIX}_PYTHON3
  local VENV_VAR=${PREFIX}_VIRTUALENV
  if [ -d "$TARGET" ]; then
    echo "Virtual environment has already been set up"
    echo "Location: $TARGET"
    true
  fi

  echo "#--------------------- Creating Python Venv (start)"
  echo "#"
  echo "python interpreter = ${!PYTHON3_VAR}"
  echo "venv installation @ $TARGET"
  ${!VENV_VAR} -p ${!PYTHON_VAR} $1 > /dev/null
  echo "#--------------------- Creating Python Venv (end)"
}

check_basic_python_ability() (
local PYTHON3_VAR=${PREFIX}_PYTHON3
local VENV_VAR=${PREFIX}_VIRTUALENV
if [ "${!PYTHON3_VAR}" = "" ]; then
        echo "Missing python3"
        exit -1;
fi
if [ "${!VENV_VAR}" = "" ]; then
        echo "Missing virtualenv"
        exit -1;
fi
exit 0;
)
