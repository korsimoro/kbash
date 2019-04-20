#!/bin/bash

function oneline_help_SHELL_PREFIX_component_new() {
  echo "cd home, or into $VAR_PREFIX/[C]."
}

function help_SHELL_PREFIX_component_new() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX component-new [component-name] [component-var-prefix]${NC}


EOF
`\n\n"
}

function run_SHELL_PREFIX_component_new() {
  local COMPONENT_NAME=$1
  if [ -z "$COMPONENT_NAME" ]; then
    report_warning "missing component-name"
    help_SHELL_PREFIX_component_new
    return
  fi

  local COMPONENT_VAR_PREFIX=$2
  if [ -z "$COMPONENT_VAR_PREFIX" ]; then
    echo "missing component-var-prefix"
    help_SHELL_PREFIX_component_new
    return
  fi

  local TARGET=$VAR_PREFIX_COMPONENT_DIR/$COMPONENT_NAME
  local KBASE="$K_BASHENV_BASE"
  local KSETUP=$KBASE/setup/component

  if [ -f "$TARGET" ]; then
    report_error "$TARGET already exists and is a file"
    return
  fi

  if [ -d "$TARGET" ]; then
    report_warning "$COMPONENT_NAME already set up"
    return
  fi

  if [ -z "$VAR_PREFIX_COMPONENT_LIST" ]; then
    report_progress "Loading API functions"
    k_bashenv_load_functions_from_dir "SHELL_PREFIX" "VAR_PREFIX" "$K_BASHENV_BASE/util/components/api"
  fi

  if [ ! -d "$TARGET" ]; then
    mkdir -p $TARGET
    eval VAR_PREFIX_COMPONENT_LIST=\"$(sort_list "${VAR_PREFIX_COMPONENT_LIST} $COMPONENT_NAME")\"
    report_progress "Created $COMPONENT_NAME at $TARGET"
  fi

  cp -r $KSETUP/* $TARGET
  local PFX=PREFIX
  local VP="VAR_${PFX}"
  local SP="SHELL_${PFX}"
  for FILE in $(find_dot_sh $KSETUP); do
    echo "Setting up $TARGET/$FILE"
    cat $KSETUP/$FILE \
        | sed s/$VP/VAR_PREFIX/g \
        | sed s/$SP/SHELL_PREFIX/g \
        | sed s/COMPONENT_NAME/$COMPONENT_NAME/g \
        | sed s/COMPONENT_VAR_PREFIX/$COMPONENT_VAR_PREFIX/g \
        > $TARGET/$FILE
  done

  SHELL_PREFIX_load_component $COMPONENT_NAME
}
export -f run_SHELL_PREFIX_component_new help_SHELL_PREFIX_component_new oneline_help_SHELL_PREFIX_component_new
