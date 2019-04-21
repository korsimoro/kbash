#!/bin/bash
function oneline_help_ENTRYPOINT_activate() {
  echo "Configure shell to match build for [C]"
}

function help_ENTRYPOINT_activate() {
  print_component_help activate
}

function run_ENTRYPOINT_activate() {
  local ENV=$(slugify $1)

  if ENTRYPOINT_run_component_func activate $@; then

    echo "Activated $ENV"
    echo "   - ran activate_environment_$ENV"
    echo "   - setting VAR_PREFIX_ACTIVE_DEVENV"
    VAR_PREFIX_ACTIVE_DEVENV=$ENV
    echo "   - adjusting prompt"
    ENTRYPOINT_reprompt
    echo "   - cd into environment home"
    ENTRYPOINT cd $ENV
    describe_environment_ENTRYPOINT_$ENV
  fi

}
export -f run_ENTRYPOINT_activate help_ENTRYPOINT_activate oneline_help_ENTRYPOINT_activate
