#!/bin/bash
# this is the entry point function - it takes special consideration over
# the first argument as follows:
# - if missing or a help option, then print the main help
# - else if function, then run the function
# - else if kbash command or scope, then search for a command in the kbash commands dir
# - else if component, then search for a command in the component
# - else if local command or scope, then search for a command in the local commands dir
# - else command not found
SHELL_PREFIX() {
  # if the command line is just "SHELL_PREFIX"
  if [ -z "$(echo $@ )" ]; then
     SHELL_PREFIX_print_main_help
  else
    # we have at least one argument, so peal it off "$@" can then be passed
    # along as needed
    local FIRST_ARG=$1
    shift 1
    if is_help_option "$FIRST_ARG"; then
      SHELL_PREFIX_print_main_help $@
    else
      # check to see if itis a function
      local FUNC=run_SHELL_PREFIX_$(slugify $FIRST_ARG)
      local TYPE="$(type -t $FUNC)"
      if [ "$TYPE" = "function" ]; then
        if is_help_option "$1"; then
          help_SHELL_PREFIX_$(slugify $FIRST_ARG)
        else
          $FUNC $@
        fi
      else
        # check to see if it is a component, execute if it is
        if contains "$VAR_PREFIX_COMPONENT_LIST" "$FIRST_ARG"; then
          local NEXT_ARG=$1
          shift 1
           SHELL_PREFIX_process_command_scope\
                    SHELL_PREFIX_process_command_scope_visitor\
                    "$VAR_PREFIX_COMPONENT_DIR/$FIRST_ARG/commands"\
                    "$NEXT_ARG"\
                    "component/$FIRST_ARG"\
                    $@
        else
          # check to see if it is a registered external endpoint
          if contains "$VAR_PREFIX_REGISTERED_ENDPOINT" "$FIRST_ARG"; then
            echo "add command registration"
          else
            # now check if it is a project command
            TYPE=$(SHELL_PREFIX_classify "$VAR_PREFIX_COMMAND_DIR" "$FIRST_ARG")
            case TYPE in
              file | scope)
                SHELL_PREFIX_process_command_scope\
                          SHELL_PREFIX_process_command_scope_visitor\
                          "$VAR_PREFIX_COMMAND_DIR"\
                          "$FIRST_ARG"\
                          "project"\
                          $@
                ;;
              *)
                SHELL_PREFIX_process_command_scope_visitor \
                  "n/a"
                  command-not-found \
                  "$FIRST_ARG"\
                  "as a top level command."
                ;;
            esac
          fi
        fi
      fi
    fi
  fi
}
export -f SHELL_PREFIX
