#!/bin/bash
function oneline_help_SHELL_PREFIX_build() {
  echo "Build [C] using component build system"
}
function help_SHELL_PREFIX_build() {
  print_component_help build
}
function run_SHELL_PREFIX_build() {
  local ENV=$(slugify $1)

  if help_on_empty_or_help build "$ENV"; then
    clear

    if run_component_func build $@; then
      echo "Built"
    fi
  fi

}
