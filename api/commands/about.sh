#!/bin/bash
# Detailed Information about KBASH
# example usage print_kidlist_help COMMAND
#
# print the top level help, subsequent subcommands will override this
# function with the appropriate help
print_help() {
  run
}
run() {
printf "`cat << EOF
${BLUE}ENTRYPOINT <command> [help]${NC}

${BLUE}ENTRYPOINT${NC} is a bash environment supporting development.

${BLUE}ENTRYPOINT${NC} is pure anti-pattern, in includes
 - 'within-environment' mutations- bash functions allow forward mutation of the
   active environment, with no guarantees of any stable state, save the single
   application of this function after a clean reset
 - pure 'side-effect' focus.  This is an attempt to identify mutators to the
   filesystem, and to codify them.  All functions and commands in the
   environment are expected to operate upon the filesystem directly.  git
   provides us exceptional visiblity into changes over the active checkout.

${BLUE}ENTRYPOINT${NC} supports the development of ad-hoc tasks required
to effectively build a complex, multi-project system.

As knowledge is captured w/in the ${BLUE}ENTRYPOINT${NC} script system, it is added
into the compiled node or python build support tools.  But when you have to
adapt to an existing culture, as in a fork, you need a little grease.  The
node and python knowledge is the organized grease to glue a complete system
onto a consistent base.

${BLUE}ENTRYPOINT${NC} uses a "Convention over Configuration" and heavily seeds a
bash operating environment with functions and variables, supporting
multi-tech integration projects.  The ability to "regenerate" the environment
from the ${BLUE}ENTRYPOINT reset${NC} command means that scripts can be rapidly
edited and applied - recorded in a pull-request, and the collective wisdom
knitting forward.

${BLUE}ENTRYPOINT${NC} can be rapidly and ad-hoc adjusted, and it is specific to
this repository.  The bashenv orchestrates the connection of the environment
with a conversational mutator - a live bash shell.  As this is bound to a
repository top, the space underneath is managed - so this is effectively a
bash shell over a commit-trail of reference.

${BLUE}ENTRYPOINT${NC} is scoped by directory (or checkout) - based on the VAR_PREFIX
variable.
  ${GREEN}VAR_PREFIX${NC} = $VAR_PREFIX

For more information, check out this file:
$VAR_PREFIX/docs/bashenv.md

In general use ${BLUE}ENTRYPOINT [cmd] help${NC} for more information.

EOF
`\n\n"

}
