#!/bin/bash
rm -rf testdir
./setup.sh kx KXX $PWD/testdir
cp -r $PWD/testsrc/* $PWD/testdir
exec ./testdir/bashenv/shell.sh

