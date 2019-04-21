#!/bin/bash

export SYSTEM_PYTHON3=$(command -v python3)
export SYSTEM_VIRTUALENV=$(command -v virtualenv)

create_python3_env() {
  local TARGET=$1
  if [ -d "$TARGET" ]; then
    echo "Using virtual environment in $TARGET"
    true
  else
    echo "#--------------------- Creating Python Venv (start)"
    echo "#"
    echo "python interpreter = ${SYSTEM_PYTHON3}"
    echo "venv installation @ $TARGET"
    if ! ${SYSTEM_VIRTUALENV} -p ${SYSTEM_PYTHON3} $1 > /dev/null; then
      report_error "Failed to create python3 environment in $TARGET"
      false
    else
      echo "#--------------------- Creating Python Venv (end)"
      true
    fi
  fi
}

report_python_env() {
  local VENV=$1
  report_subheading "Python Virtual Environment"
  if [ -d "$VENV" ]; then
    report_ok "  python venv present"
    echo "  PYTHON=$(command -v python)"
  else
    report_warning "  venv does not exist at $VENV"
  fi
}
ensure_active_python3_env() {
  if create_python3_env $1; then
    activate_python_env $1
  else
    false
  fi
}
export -f ensure_active_python3_env

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

default_python_setup() (
  local BASE=$1
  local VENV=$BASE/venv
  if ensure_active_python3_env $VENV; then
	  cd $BASE
    local LOGDIR=$BASE/setup-logs
    local SETUP_LOG=$(ensure_empty_dir $LOGDIR)

    date > $SETUP_LOG/start-timestamp.txt
    report_heading "Starting installation, trace is in $SETUP_LOG"

    report_progress "Installing from setup.py first"
    if ! pip install . > $SETUP_LOG/main.txt; then
      cat $SETUP_LOG/main.txt
      error "Failed to install tool with 'pip install .', see trace above"
    fi

    report_progress "Installing development requirements"
    if ! pip install -e .[dev] > $SETUP_LOG/dev.txt; then
      cat $SETUP_LOG/dev.txt
      error "Failed to install tool with 'pip install -e .[dev]', see trace above"
    fi

    if [ -f local-requirements.txt ]; then
      report_progress "Installing local packages (relative links) "
      if ! pip install -r local-requirements.txt > $SETUP_LOG/local.txt; then
        cat $SETUP_LOG/local.txt
        error "Failed to install tool with 'pip install -r local-requirements.txt', see trace above"
      fi
    else
      echo "No local-requirements.txt found" > $SETUP_LOG/local.txt
    fi

    date > $SETUP_LOG/end-timestamp.txt
    report_ok "Python env configuration complete"
    true
  fi
)


activate_python_env() {
  local VENV=$1
  if [ ! -d "$VENV" ]; then
    report_error "Missing $VENV"
  else
    if [ ! -f "$VENV/bin/activate" ]; then
      report_error "Missing activation function $VENV/bin/activate"
    else
      . $VENV/bin/activate
    fi
  fi
}
export -f check_basic_python_ability create_python3_env activate_python_env
