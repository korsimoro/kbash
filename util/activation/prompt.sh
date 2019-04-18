#!/bin/bash
# Sets up prompt

#called by 'activate' to keep the prompt active
SHELL_PREFIX_reprompt() {
  export PS1="SHELL_PREFIX[$VAR_PREFIX_ACTIVE_DEVENV/$VAR_PREFIX_ACTIVATION_COUNT]:\W> "
}
SHELL_PREFIX_reprompt
