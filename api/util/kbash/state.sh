#!/bin/bash
# These variables control the VAR_PREFIX scope.
export K_BASHENV_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )

# define bash environment
export           VAR_PREFIX_BASH=$VAR_PREFIX/bashenv
export     VAR_PREFIX_KBASH_LOGS=$VAR_PREFIX/kbash-logs

# global commands and scopes
export   VAR_PREFIX_BASH_COMMAND=$VAR_PREFIX_BASH/commands

# functions - these can be used as a first arg to the entrypoint
# SHELL_PREFIX <function> ....
export  VAR_PREFIX_FUNCTION_LIST=""
export  VAR_PREFIX_BASH_FUNCTION=$VAR_PREFIX_BASH/functions

# components - these can be used as the first arg to the entrpoint
# SHELL_PREFIX <component> ....
export VAR_PREFIX_COMPONENT_LIST=""
export  VAR_PREFIX_COMPONENT_DIR=$VAR_PREFIX_BASH/components

# components - these can be used as the first arg to the entrpoint
# SHELL_PREFIX <entrypoint> ....
#export VAR_PREFIX_COMPONENT_LIST=""
#export  VAR_PREFIX_COMPONENT_DIR=$VAR_PREFIX_BASH/components
