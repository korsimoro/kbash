#!/bin/bash


function oneline_help_ENTRYPOINT_FUNCTION() {
  echo "<<WHAT DOES FUNCTION DO?>>."
}
export -f oneline_help_ENTRYPOINT_FUNCTION

function cmdline_help_ENTRYPOINT_FUNCTION() {
  echo "<<OPTIONS FOR FUNCTION>>"
}
export -f cmdline_help_ENTRYPOINT_FUNCTION


function help_ENTRYPOINT_FUNCTION() {
printf "`cat << EOF
<<DETAILED INFORMATION ABOUT FUNCTION>>
EOF
`\n"
}
export -f help_ENTRYPOINT_FUNCTION

function run_ENTRYPOINT_FUNCTION() {
  report_warning "Not Yet Implemented: ENTRYPOINT_FUNCTION"
}
export -f run_ENTRYPOINT_FUNCTION
