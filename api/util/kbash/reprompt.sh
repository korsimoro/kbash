#!/bin/bash
# Sets up prompt

#called by 'activate' to keep the prompt active
SHELL_PREFIX_reprompt() {
  if [ -z "$VAR_PREFIX_ACTIVE_DEVENV" ]; then
    export PS1="SHELL_PREFIX[$VAR_PREFIX_ACTIVATION_COUNT]:\W> "
  else
    export PS1="SHELL_PREFIX[$VAR_PREFIX_ACTIVE_DEVENV/$VAR_PREFIX_ACTIVATION_COUNT]:\W> "
  fi
}
SHELL_PREFIX_reprompt
export -f SHELL_PREFIX_reprompt
