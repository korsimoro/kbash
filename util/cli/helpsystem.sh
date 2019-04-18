#!/bin/bash


# --------------------------------------------------------- Help Support
# example: findkids COMMAND-build
# looks for any scripts of the form <base>-<subcommand>, but
# excludes <base>-<subcommand>-<other>, so it returns only the
# immediate subcommands
SHELL_PREFIX_findkids() {
  pushdir "$VAR_PREFIX_BASH_COMMAND"
  echo $(ls -1 *.sh )
  local BASE=$1
  local VAR_PREFIX="$BASE-"
  local GLOB="*.sh"
  echo "GLOB:$GLOB"
  for FOO in $GLOB; do
   if [ ! "$FOO" = "$GLOB" ]; then
     echo ${FOO#$VAR_PREFIX}
   fi
  done
  popdir
}


# example usage print_kidlist_help COMMAND
#
function SHELL_PREFIX_print_subSHELL_PREFIX_help_summary() {
  local WIDTH=18
  local BASE="$VAR_PREFIX_BASH_COMMAND"/$1
  local KIDS=$(ls -1 $BASE/*.sh  2>/dev/null | xargs -n 1 basename | sed s/.sh$//g | sort)
  local SCOPES=$(ls -1 $BASE/*/.scope 2>/dev/null)
  if [ ! -z "$SCOPES" ]; then
    SCOPES=$(ls -1 $BASE/*/.scope | xargs -n 1 dirname | xargs -n 1 basename | sort)
  fi

  if [ ! -z "$KIDS" ]; then
    printf "Commands\n"
    for KID in $KIDS; do
       local SCRIPT_FILE="$BASE/$KID.sh"
       if [ -f "$SCRIPT_FILE" ]; then
         local ONELINER=$(head -n 2 "$SCRIPT_FILE" | tail -n 1 | colrm 1 2)
         printf "${GREEN}%-${WIDTH}s${NC} %s\n" " $KID" "$ONELINER"
       else
         echo "-no help available-"$SCRIPT_FILE
       fi
     done
     printf "\n"
   fi

   if [ ! -z "$SCOPES" ]; then
     printf "Command Sets\n"
     for SCOPE in $SCOPES; do
        local SCRIPT_FILE="$BASE/$SCOPE/.scope"
        if [ -f "$SCRIPT_FILE" ]; then
          local ONELINER=$(head -n 2 "$SCRIPT_FILE" | tail -n 1 | colrm 1 2)
          printf "${GREEN}%-${WIDTH}s${NC} %s\n" " $SCOPE" "$ONELINER"
        else
          echo "-no scope help available-"$SCRIPT_FILE
        fi
      done
    fi
}

SHELL_PREFIX_print_function_help_summary() {
  printf "Functions (modify the current shell)\n"
  local WIDTH=18
  #local FUNCS=$(find_dot_sh $K_BASHENV_FU | sed s/[/]/_/g | sed s/.sh//g | sort )
  for FUNC in $VAR_PREFIX_FUNCTION_LIST; do
    ONELINER="$(oneline_help_SHELL_PREFIX_$FUNC)"
    printf "${GREEN}%-${WIDTH}s${NC} %s\n" " $FUNC" "$ONELINER"
  done
}

# print the top level help, subsequent subcommands will override this
# function with the appropriate help
SHELL_PREFIX_print_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX <command> [help]${NC}

${BLUE}SHELL_PREFIX${NC} is a bash environment supporting development.

${BLUE}SHELL_PREFIX${NC} is pure anti-pattern, in includes
 - 'within-environment' mutations- bash functions allow forward mutation of the
   active environment, with no guarantees of any stable state, save the single
   application of this function after a clean reset
 - pure 'side-effect' focus.  This is an attempt to identify mutators to the
   filesystem, and to codify them.  All functions and commands in the
   environment are expected to operate upon the filesystem directly.  git
   provides us exceptional visiblity into changes over the active checkout.

${BLUE}SHELL_PREFIX${NC} supports the development of ad-hoc tasks required
to effectively build a complex, multi-project system.

As knowledge is captured w/in the ${BLUE}SHELL_PREFIX${NC} script system, it is added
into the compiled node or python build support tools.  But when you have to
adapt to an existing culture, as in a fork, you need a little grease.  The
node and python knowledge is the organized grease to glue a complete system
onto a consistent base.

${BLUE}SHELL_PREFIX${NC} uses a "Convention over Configuration" and heavily seeds a
bash operating environment with functions and variables, supporting
multi-tech integration projects.  The ability to "regenerate" the environment
from the ${BLUE}SHELL_PREFIX reset${NC} command means that scripts can be rapidly
edited and applied - recorded in a pull-request, and the collective wisdom
knitting forward.

${BLUE}SHELL_PREFIX${NC} can be rapidly and ad-hoc adjusted, and it is specific to
this repository.  The bashenv orchestrates the connection of the environment
with a conversational mutator - a live bash shell.  As this is bound to a
repository top, the space underneath is managed - so this is effectively a
bash shell over a commit-trail of reference.

${BLUE}SHELL_PREFIX${NC} is scoped by directory (or checkout) - based on the VAR_PREFIX
variable.
  ${GREEN}VAR_PREFIX${NC} = $VAR_PREFIX

For more information, check out this file:
$VAR_PREFIX/docs/bashenv.md

In general use ${BLUE}SHELL_PREFIX [cmd] help${NC} for more information.

EOF
`\n\n"
SHELL_PREFIX_print_function_help_summary
printf "\n"

SHELL_PREFIX_print_subSHELL_PREFIX_help_summary .
printf "\n"

printf "Use ${BLUE}COMMAND [cmd] help${NC} for more information.\n"

}
# by default, just print the help
run_SHELL_PREFIX_help() (
  SHELL_PREFIX_print_help
)
export -f run_SHELL_PREFIX_help SHELL_PREFIX_print_help SHELL_PREFIX_print_subSHELL_PREFIX_help_summary
