#!/bin/bash

COMMAND=$1
PREFIX=$2
TBASE=$3
TARGET=$TBASE/bashenv
KBASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
KSETUP=$KBASE/setup/base

if [ -f "$TARGET" ]; then
  echo "$TARGET already exists and is a file"
  exit -1
fi

if [ ! -d "$TARGET" ]; then
  mkdir -p $TARGET
fi

cp -r $KSETUP/* $TARGET
cat $KSETUP/activate.sh \
  | sed s/VAR_PREFIX/$PREFIX/g \
  | sed s/SHELL_PREFIX/$COMMAND/g \
  | sed "s|KBASE|$KBASE|g" \
  > $TARGET/activate.sh
chmod +x $TARGET/shell.sh
