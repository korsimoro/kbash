#!/bin/bash

#
# This file, when it is included, will increment the activation count.  This
# is the number of times that the shell has been activated.
#
# Note, the PATH variable is captured on only the first run
#

if [ -z "$VAR_PREFIX_ACTIVATION_COUNT" ]; then
  VAR_PREFIX_ACTIVATION_COUNT=0
else
  VAR_PREFIX_ACTIVATION_COUNT=$(expr $VAR_PREFIX_ACTIVATION_COUNT + 1 )
fi
export VAR_PREFIX_ACTIVATION_COUNT
