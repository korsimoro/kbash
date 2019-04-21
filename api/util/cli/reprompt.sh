#!/bin/bash
# Sets up prompt

#called by 'activate' to keep the prompt active
ENTRYPOINT_reprompt() {
  if [ -z "$VAR_PREFIX_ACTIVE_DEVENV" ]; then
    export PS1="ENTRYPOINT[$VAR_PREFIX_ACTIVATION_COUNT]:\W> "
  else
    export PS1="ENTRYPOINT[$VAR_PREFIX_ACTIVE_DEVENV/$VAR_PREFIX_ACTIVATION_COUNT]:\W> "
  fi
}
ENTRYPOINT_reprompt
export -f ENTRYPOINT_reprompt
