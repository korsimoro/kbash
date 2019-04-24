#!/bin/bash


function oneline_help_ENTRYPOINT_bundle() {
  echo "Runs the project specific bundle"
}
export -f oneline_help_ENTRYPOINT_bundle

function cmdline_help_ENTRYPOINT_bundle() {
  echo "[Bundle Commend Line]"
}
export -f cmdline_help_ENTRYPOINT_bundle


function help_ENTRYPOINT_bundle() {
printf "`cat << EOF

This runs the correctly scoped bundle - ruby requires
a complete path to the bundle wrapper in order to
set the environment correctly.
EOF
`\n"
}
export -f help_ENTRYPOINT_bundle

function run_ENTRYPOINT_bundle() {
  if [ -z "$RUBY_BIN_PATH" ]; then
    report_error "RUBY_BIN_PATH is not set, did you activate an environment?"
    false
  else
    $RUBY_BIN_PATH/bundle "$@"
  fi
}
export -f run_ENTRYPOINT_bundle
