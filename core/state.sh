# establish the base directory of the core...
export KBASH=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
export KBASH_CORE=$KBASH/core
export KBASH_LANG=$KBASH/lang

# API relevant functions - these arer filtered against both ENTRYPOINT
# and VAR_PREFIX, so the
export KBASH_API=$KBASH/api
export KBASH_API_COMMAND_DIR=$KBASH_API/commands
export KBASH_API_FUNCTION_DIR=$KBASH_API/functions
export KBASH_API_UTIL_DIR=$KBASH_API/util

# language configuration
export KBASH_LANGUAGE_LIST=""
