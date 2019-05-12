#!/bin/bash
function oneline_help_ENTRYPOINT_setup() {
  echo "Initialize a development environment"
}
function help_ENTRYPOINT_setup() {
  print_component_help setup
}
function cmdline_help_ENTRYPOINT_setup() {
  echo "[COMPONENT]"
}
export -f cmdline_help_ENTRYPOINT_setup

function run_ENTRYPOINT_setup() {
  local ENV=$(slugify $1)

  if [ "all" = "$ENV" ]; then
    for COMPONENT in $ENTRYPOINT_COMPONENT_LIST ; do
      ENTRYPOINT_run_component_func setup $COMPONENT
    done
  else
    if ENTRYPOINT_help_on_empty_or_help setup "$ENV"; then
      #clear

      if ENTRYPOINT_run_component_func setup $@; then
        report_ok "Setup Copmplete"
        true
      fi
    else
      report_warning "setup all using: ${GREEN}ENTRYPOINT setup all${NC}"
    fi
  fi
}
export -f run_ENTRYPOINT_setup help_ENTRYPOINT_setup oneline_help_ENTRYPOINT_setup
