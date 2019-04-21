#!/bin/bash
export TEST_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo "kx" | $TEST_BASE/single.sh -i
