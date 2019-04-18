#!/bin/bash

function oneline_help_SHELL_PREFIX_component_upsert() {
  echo "cd home, or into $VAR_PREFIX/[C]."
}

function help_SHELL_PREFIX_component_upsert() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX cd <repo>${NC}

This is a shell function, which changes the current working
directory to $PREFIX/<repo>
and if no <repo> is provided this is equivalent to ${BLUE}SHELL_PREFIX home${NC}.

EOF
`\n\n"
}

function run_SHELL_PREFIX_component_upsert() {
  local COMPONENT_NAME=$1
  if [ -z "$COMPONENT_NAME" ]; then
    echo "missing component-name"
    return
  fi

  local COMPONENT_VAR_PREFIX=$2
  if [ -z "$COMPONENT_VAR_PREFIX" ]; then
    echo "missing component-var-prefix"
    return
  fi

  local TARGET=$VAR_PREFIX_COMPONENT_DIR/$COMPONENT_NAME
  local KBASE="$K_BASHENV_BASE"
  local KSETUP=$KBASE/setup/component

  if [ -f "$TARGET" ]; then
    echo "$TARGET already exists and is a file"
    return
  fi

  if [ ! -d "$TARGET" ]; then
    mkdir -p $TARGET
    eval VAR_PREFIX_COMPONENT_LIST=\"$(sort_list "${VAR_PREFIX_COMPONENT_LIST} $COMPONENT_NAME")\"
  fi

  cp -r $KSETUP/* $TARGET
  local PFX=PREFIX
  local VP="VAR_${PFX}"
  local SP="SHELL_${PFX}"
  for FILE in $(find_dot_sh $KSETUP); do
    cat $KSETUP/$FILE \
      | sed s/$VP/VAR_PREFIX/g \
      | sed s/$SP/SHELL_PREFIX/g \
      | sed s/COMPONENT_NAME/$COMPONENT_NAME/g \
      | sed s/COMPONENT_VAR_PREFIX/$COMPONENT_VAR_PREFIX/g \
      > $TARGET/$FILE
  done

  load_component $COMPONENT_NAME
}
export -f run_SHELL_PREFIX_component_upsert help_SHELL_PREFIX_component_upsert oneline_help_SHELL_PREFIX_component_upsert
