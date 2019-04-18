#!/bin/bash

export VAR_PREFIX=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
. KBASE/util/activation/activate.sh\
  "SHELL_PREFIX"  \
  "VAR_PREFIX" \
  ""    \
  ""
