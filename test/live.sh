#!/bin/bash
export TEST_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SRCDIR=$TEST_BASE/testsrc

rm -rf testdir

DEST=$TEST_BASE/testdir/kx
mkdir -p $DEST
cp -r $SRCDIR/* $DEST
find $DEST -type f -exec sed -i -e 's/VAR_PREFIX/KXX/g' {} \;
find $DEST -type f -exec sed -i -e 's/ENTRYPOINT/kx/g' {} \;
./setup.sh kx KXX $DEST
ACTIVATE_KX=$TEST_BASE/testdir/kx/bashenv/activate.sh

DEST=$TEST_BASE/testdir/ky
mkdir -p $DEST
cp -r $SRCDIR/* $DEST
find $DEST -type f -exec sed -i -e 's/VAR_PREFIX/KYY/g' {} \;
find $DEST -type f -exec sed -i -e 's/ENTRYPOINT/ky/g' {} \;
./setup.sh ky KYY $DEST
ACTIVATE_KY=$TEST_BASE/testdir/ky/bashenv/activate.sh

. $ACTIVATE_KX
. $ACTIVATE_KY
ky component-new comp0 C0

exec bash
