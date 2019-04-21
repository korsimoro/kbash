#!/bin/bash
# this is the entry point function - it takes special consideration over
# the first argument as follows:
# - if missing or a help option, then print the main help
# - else if function, then run the function
# - else if kbash command or scope, then search for a command in the kbash commands dir
# - else if component, then search for a command in the component
# - else if local command or scope, then search for a command in the local commands dir
# - else command not found
ENTRYPOINT() {
  # if the command line is just "ENTRYPOINT"
  if [ -z "$(echo $@ )" ]; then
     ENTRYPOINT_print_main_help
  else
    # we have at least one argument, so peal it off "$@" can then be passed
    # along as needed
    local FIRST_ARG=$1
    shift 1
    if is_help_option "$FIRST_ARG"; then
      ENTRYPOINT_print_main_help $@
    else
      # check to see if itis a function
      local FUNC=run_ENTRYPOINT_$(slugify $FIRST_ARG)
      local TYPE="$(type -t $FUNC)"
      if [ "$TYPE" = "function" ]; then
        if is_help_option "$1"; then
          ENTRYPOINT_print_function_help $(slugify $FIRST_ARG)
        else
          $FUNC $@
        fi
      else
        # check to see if it is a component, execute if it is
        if contains "$VAR_PREFIX_COMPONENT_LIST" "$FIRST_ARG"; then
          local NEXT_ARG=$1
          shift 1
           ENTRYPOINT_process_command_scope\
                    ENTRYPOINT_process_command_scope_visitor\
                    "$VAR_PREFIX_COMPONENT_DIR/$FIRST_ARG/commands"\
                    "$NEXT_ARG"\
                    "component/$FIRST_ARG"\
                    $@
        else
          # check to see if it is a registered external endpoint
          if contains "$VAR_PREFIX_REGISTERED_ENDPOINT" "$FIRST_ARG"; then
            echo "add command registration"
          else
            local RAN=false
            for BASE in "$VAR_PREFIX_KBASH_COMMAND" "$KBASH_API_COMMAND_DIR"; do
              # now check if it is a project command
              TYPE=$(ENTRYPOINT_classify "$BASE" "$FIRST_ARG")
              kbash_trace "Checked $BASE/$FIRST_ARG and determined it was $TYPE"
              if [ "$TYPE" = "file" ] || [ "$TYPE" = "scope" ]; then
                ENTRYPOINT_process_command_scope\
                          ENTRYPOINT_process_command_scope_visitor\
                          "$BASE"\
                          "$FIRST_ARG"\
                          "project"\
                          $@
                return
              fi
            done
            ENTRYPOINT_process_command_scope_visitor \
              "n/a" \
              command-not-found \
              "$FIRST_ARG"\
              "top level"
          fi
        fi
      fi
    fi
  fi
}
export -f ENTRYPOINT
