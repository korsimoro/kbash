#!/bin/bash

# uncommenting this line will cause trace output
#export KBASH_TRACE=true

export VAR_PREFIX="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# change this if you did not clone into ~/.kbash
. ~/.kbash/boot.sh\
    "ENTRYPOINT"  \
    "VAR_PREFIX"  \
    ""            \
    ""
#:
#: # activate.sh
#:
#:
#:
#:
#:
#:
#:
