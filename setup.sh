#!/bin/bash

COMMAND=$1
PREFIX=$2
TBASE=$3

if [ -z "$COMMAND" ] ||\
    [ -z "$PREFIX" ] ||\
    [ -z "$TBASE" ]; then
  echo "usage: setup.sh SHELL_COMMAND VAR_PREFIX TARGET_DIR"
  exit -1
fi

TARGET=$TBASE/kbash
KBASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
KSETUP=$KBASE/setup/project

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
  | sed s/ENTRYPOINT/$COMMAND/g \
  | sed "s|KBASE|$KBASE|g" \
  > $TARGET/activate.sh
chmod +x $TARGET/shell.sh
