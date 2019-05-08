#!/bin/bash
function oneline_help_ENTRYPOINT_activate() {
  echo "Configure shell to match build environment for [COMPONENT]"
}
export -f oneline_help_ENTRYPOINT_activate

function cmdline_help_ENTRYPOINT_activate() {
  echo "[COMPONENT]"
}
export -f cmdline_help_ENTRYPOINT_activate

function help_ENTRYPOINT_activate() {
  print_component_help activate
}
export -f help_ENTRYPOINT_activate

function run_ENTRYPOINT_activate() {
  local COMPONENT=$(slugify $1)
  local CURPATH=$PATH

  export PATH=$KBASH_ORIGINAL_PATH

  if ENTRYPOINT_run_component_func activate $@; then

    kbash_trace "Activated $COMPONENT"
    kbash_trace "   - ran activate_environment_$COMPONENT"
    kbash_trace "   - setting VAR_PREFIX_ACTIVE_DEVCOMPONENT"
    VAR_PREFIX_ACTIVE_DEVENV=$COMPONENT
    kbash_trace "   - adjusting prompt"
    ENTRYPOINT_reprompt
    kbash_trace "   - cd into environment home"
    ENTRYPOINT cd $COMPONENT

    # describe_environment_ENTRYPOINT_$COMPONENT
  else
    export PATH=$CURPATH
  fi

}
export -f run_ENTRYPOINT_activate
