#!/bin/bash
#
#
#
ENTRYPOINT_process_command_scope_visitor() {
  kbash_trace "Visit command scope:$@"
  local BASE=$1
  local ARG=$2
  shift 2
  case $ARG in
    print-scope-help)
      printf "${BOLD}${BLUE}$(ENTRYPOINT_scope_usage )${NC}\n\n"
      printf "$(ENTRYPOINT_scope_help $@)\n"
      ENTRYPOINT_print_scope_help_summary $BASE $@
      ;;
    execute-file)
      # careful... this expects to be entered into via ENTRYPOINT()
      # which invokes the command executor
      local FILE=$1
      local NEXT_ARG=$2
      shift 1
      kbash_shell_integrate "ENTRYPOINT" "VAR_PREFIX" $FILE
      if is_help_option "$NEXT_ARG"; then
        shift 1
        print_help "$@"
      else
        run $@
      fi
      ;;
    enter-scope)
      kbash_trace "Processing Scope '$1' '$2' '$3' '$4'"
      ENTRYPOINT_process_command_scope ENTRYPOINT_process_command_scope_visitor "$1" "$2" "$3"
      ;;
    command-not-found)
      local COMMAND=$1
      local STACK=$2
      printf "${RED}Command not found${NC} - no \'$COMMAND\' in \'$STACK\'\n"
      ;;
    *)
      echo "Invalid Event:$ARG $@"
      ;;
  esac
}
export -f ENTRYPOINT_process_command_scope_visitor
