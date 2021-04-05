#!/bin/bash
#
#
#
ENTRYPOINT_process_command_scope_visitor() {
  kbash_trace function-enter "ENTRYPOINT_process_command_scope_visitor:$@"
  local BASE=$1
  local EVENT=$2
  shift 2
  case $EVENT in
    print-scope-help)
      local STACK=$(echo "$1" | cut -d'/' -f1  --complement)
      printf "${BOLD}${BLUE}ENTRYPOINT ${STACK} $(ENTRYPOINT_scope_usage )${NC}\n\n"
      printf "$(ENTRYPOINT_scope_help $@)\n"
      ENTRYPOINT_print_scope_help_summary $BASE $@
      ;;
    execute-file)
      # careful... this expects to be entered into via ENTRYPOINT()
      # which invokes the command executor
      local FILE=$1
      local FIRST_ARG=$2
      shift 1
      kbash_trace "kbash_shell_integrate ENTRYPOINT VAR_PREFIX $FILE"
      kbash_shell_integrate "ENTRYPOINT" "VAR_PREFIX" $FILE
      if is_help_option "$FIRST_ARG"; then
        shift 1
        kbash_trace visitor-file-help-requested "$FIRST_ARG $@"
        print_help "$@"
      else
        kbash_trace visitor-file-execution-requested "$FILE $FIRST_ARG $@"
        set -e
        run $@
      fi
      ;;
    enter-scope)
      local STARTING_IN_DIR="$1"
      local COMMAND_TO_FIND="$2"
      local REPORT_MESSAGE="$3"
      shift 3
      local CMDLINE="$@"
      kbash_trace visitor-enter-scope "$(report_vars calling-process-command-scope STARTING_IN_DIR COMMAND_TO_FIND REPORT_MESSAGE CMDLINE)"
      ENTRYPOINT_process_command_scope ENTRYPOINT_process_command_scope_visitor "$STARTING_IN_DIR" "$COMMAND_TO_FIND" "$REPORT_MESSAGE" "$CMDLINE"
      ;;
    command-not-found)
      local COMMAND=$1
      local STACK=$2
      printf "${RED}Command not found${NC} - no \'$COMMAND\' in \'$STACK\'\n"
      ;;
    *)
      echo "Invalid Event:$EVENT $@"
      ;;
  esac
}
export -f ENTRYPOINT_process_command_scope_visitor
