#!/bin/bash
export TEST_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DEST=$TEST_BASE/testdir/kx

kx component-add c0 COMP0

