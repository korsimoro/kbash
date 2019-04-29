#!/bin/bash

export KBASH_PYTHON3=$(command -v python3)

create_python3_env() {

  if [ -z "$1" ]; then
    report_error "create_python3_env called w/o VENV-DIR"
    echo "usage: create_python3_env [VENV-DIR]"
  else
    if check_basic_python_ability; then
      local TARGET=$1
      if [ -d "$TARGET" ]; then
        report_ok "Using virtual environment in $TARGET"
        true
      else
        echo "#--------------------- Creating Python Venv (start)"
        echo "#"
        echo "python interpreter = ${KBASH_PYTHON3}"
        echo "venv installation @ $TARGET"
        echo "#"
        if ! ${KBASH_PYTHON3} -m venv $TARGET > /dev/null; then
          report_error "Failed to create python3 environment in $TARGET"
          false
        else
          echo "#--------------------- Creating Python Venv (end)"
          true
        fi
      fi
    fi
  fi
}

report_python_env() {
  if [ -z "$1" ]; then
    report_error "report_python_env called w/o TARGET"
    echo "usage: report_python_env [VENV-DIR]"
  else
    local VENV=$1
    report_subheading "Python Virtual Environment"
    if [ -d "$VENV" ]; then
      report_ok "  python venv present"
      echo "  python=$(command -v python)"
      report_vars "Python Environment Variables"
    else
      report_warning "  venv does not exist at $VENV"
    fi
  fi
}


ensure_active_python3_env() {
  if [ -z "$1" ]; then
    report_error "ensure_active_python3_env called w/o TARGET"
    echo "usage: ensure_active_python3_env [VENV-DIR]"
    false
  else
    if check_basic_python_ability; then
      if create_python3_env $1; then
        activate_python_env $1
      else
        false
      fi
    else
      false
    fi
  fi
}
export -f ensure_active_python3_env

check_basic_python_ability() (
  if [ "${KBASH_PYTHON3}" = "" ]; then
      echo "Missing python3"
      exit -1;
  fi
  exit 0;
)
export -f check_basic_python_ability

default_python_setup() (

  local BASE=$1
  if [ -z "$BASE" ]; then
    error "default_python_setup called w/o BASE directory."
  fi

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
export -f check_basic_python_ability

activate_python_env() {
  if [ -z "$1" ]; then
    report_error "activate_python_env called w/o directory"
  else
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
  fi
}
export -f activate_python_env
