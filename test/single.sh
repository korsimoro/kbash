#!/bin/bash
export TEST_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SRCDIR=$TEST_BASE/testsrc
ENTRYPOINT=kx
VAR_PREFIX=KXX
DEST=$TEST_BASE/testdir/$ENTRYPOINT

rm -rf $DEST
mkdir -p $DEST
$TEST_BASE/setup.sh $ENTRYPOINT $VAR_PREFIX $DEST

exec $DEST/kbash/shell.sh "$@"
