#!/bin/bash
function oneline_help_ENTRYPOINT_build() {
  echo "Build [C] using component build system"
}
function cmdline_help_ENTRYPOINT_build() {
  echo "[COMPONENT]"
}
export -f cmdline_help_ENTRYPOINT_build

function help_ENTRYPOINT_build() {
  print_component_help build
}
function run_ENTRYPOINT_build() {
  local ENV=$(slugify $1)

  if ENTRYPOINT_help_on_empty_or_help build "$ENV"; then
    clear

    if ENTRYPOINT_run_component_func build $@; then
      echo "Built"
    fi
  fi

}
export -f run_ENTRYPOINT_build help_ENTRYPOINT_build oneline_help_ENTRYPOINT_build
