#!/bin/bash
function oneline_help_SHELL_PREFIX_activate() {
  echo "Configure shell to match build for [C]"
}

function help_SHELL_PREFIX_activate() {
  print_component_help activate
}

function run_SHELL_PREFIX_activate() {
  local ENV=$(slugify $1)

  if SHELL_PREFIX_run_component_func activate $@; then

    echo "Activated $ENV"
    echo "   - ran activate_environment_$ENV"
    echo "   - setting VAR_PREFIX_ACTIVE_DEVENV"
    VAR_PREFIX_ACTIVE_DEVENV=$ENV
    echo "   - adjusting prompt"
    SHELL_PREFIX_reprompt
    echo "   - cd into environment home"
    SHELL_PREFIX cd $ENV
    describe_environment_SHELL_PREFIX_$ENV
  fi

}
export -f run_SHELL_PREFIX_activate help_SHELL_PREFIX_activate oneline_help_SHELL_PREFIX_activate
