#!/bin/bash

export SYSTEM_PYTHON3=$(command -v python3)
export SYSTEM_VIRTUALENV=$(command -v virtualenv)

create_python3_env() {
  local TARGET=$1
  if [ -d "$TARGET" ]; then
    echo "Virtual environment has already been set up"
    echo "Location: $TARGET"
    true
  fi

  echo "#--------------------- Creating Python Venv (start)"
  echo "#"
  echo "python interpreter = ${SYSTEM_PYTHON3}"
  echo "venv installation @ $TARGET"
  ${SYSTEM_VIRTUALENV} -p ${SYSTEM_PYTHON3} $1 > /dev/null
  echo "#--------------------- Creating Python Venv (end)"
}

check_basic_python_ability() (
  if [ "${SYSTEM_PYTHON3}" = "" ]; then
          echo "Missing python3"
          exit -1;
  fi
  if [ "${SYSTEM_VIRTUALENV}" = "" ]; then
          echo "Missing virtualenv"
          exit -1;
  fi
  exit 0;
)

export -f check_basic_python_ability create_python3_env
