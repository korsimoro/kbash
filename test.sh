#!/bin/bash
SRCDIR=$PWD/testsrc

rm -rf testdir

DEST=$PWD/testdir/kx
mkdir -p $DEST
cp -r $SRCDIR/* $DEST
find $DEST -type f -exec sed -i -e 's/VAR_PREFIX/KXX/g' {} \;
find $DEST -type f -exec sed -i -e 's/SHELL_PREFIX/kx/g' {} \;
./setup.sh kx KXX $DEST
ACTIVATE_KX=$PWD/testdir/kx/bashenv/activate.sh

DEST=$PWD/testdir/ky
mkdir -p $DEST
cp -r $SRCDIR/* $DEST
find $DEST -type f -exec sed -i -e 's/VAR_PREFIX/KYY/g' {} \;
find $DEST -type f -exec sed -i -e 's/SHELL_PREFIX/ky/g' {} \;
./setup.sh ky KYY $DEST
ACTIVATE_KY=$PWD/testdir/ky/bashenv/activate.sh

. $ACTIVATE_KX
. $ACTIVATE_KY
exec bash
