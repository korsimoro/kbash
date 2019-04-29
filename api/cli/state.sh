#!/bin/bash

# define bash environment
export VAR_PREFIX_KBASH=$VAR_PREFIX/kbash

# setup and build log traces
export VAR_PREFIX_KBASH_LOGS=$VAR_PREFIX_KBASH/logs

# global commands and scopes
export VAR_PREFIX_KBASH_COMMAND=$VAR_PREFIX_KBASH/commands

# functions - these can be used as a first arg to the entrypoint
# ENTRYPOINT <function> ....
export VAR_PREFIX_FUNCTION_LIST=""
export VAR_PREFIX_KBASH_FUNCTION=$VAR_PREFIX_KBASH/functions

# components - these can be used as the first arg to the entrpoint
# ENTRYPOINT <component> ....
export VAR_PREFIX_COMPONENT_LIST=""
export VAR_PREFIX_COMPONENT_DIR=$VAR_PREFIX_KBASH/components

# languages
declare -A VAR_PREFIX_LANGUAGE_MAP
export VAR_PREFIX_LANGUAGE_MAP
