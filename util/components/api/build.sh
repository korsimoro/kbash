#!/bin/bash
function oneline_help_SHELL_PREFIX_build() {
  echo "Build [C] using component build system"
}
function help_SHELL_PREFIX_build() {
  print_component_help build
}
function run_SHELL_PREFIX_build() {
  local ENV=$(slugify $1)

  if SHELL_PREFIX_help_on_empty_or_help build "$ENV"; then
    clear

    if SHELL_PREFIX_run_component_func build $@; then
      echo "Built"
    fi
  fi

}
export -f run_SHELL_PREFIX_build help_SHELL_PREFIX_build oneline_help_SHELL_PREFIX_build
