#!/bin/bash

function oneline_help_ENTRYPOINT_add_component() {
  echo "cd home, or into $VAR_PREFIX/[C]."
}
export -f oneline_help_ENTRYPOINT_add_component

function cmdline_help_ENTRYPOINT_add_component() {
  echo "[COMPONENT]"
}
export -f cmdline_help_ENTRYPOINT_add_component

function help_ENTRYPOINT_add_component() {
printf "`cat << EOF
${BLUE}ENTRYPOINT component-new [component-name] [component-var-prefix]${NC}


EOF
`\n\n"
}

function run_ENTRYPOINT_add_component() {
  local COMPONENT_NAME=$1
  if [ -z "$COMPONENT_NAME" ]; then
    report_warning "missing component-name"
    help_ENTRYPOINT_add_component
    return
  fi

  local COMPONENT_VAR_PREFIX=$2
  if [ -z "$COMPONENT_VAR_PREFIX" ]; then
    echo "missing component-var-prefix"
    help_ENTRYPOINT_add_component
    return
  fi

  local KSETUP=$KBASH/setup/component
  local FLAVOR="$3"
  if [ ! -z "$FLAVOR" ]; then
    if [ ! -d "$KBASH/setup/$FLAVOR" ]; then
      report_error "Unable to find '$FLAVOR' template in $KBASH/setup/$FLAVOR"
      return
    else
      KSETUP="$KBASH/setup/$FLAVOR"
    fi
  fi

  local TARGET=$VAR_PREFIX_COMPONENT_DIR/$COMPONENT_NAME
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
    kbash_load_functions_from_dir "ENTRYPOINT" "VAR_PREFIX" "$KBASH/util/components/api"
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
        | sed s/$SP/ENTRYPOINT/g \
        | sed s/COMPONENT_NAME/$COMPONENT_NAME/g \
        | sed s/COMPONENT_VAR_PREFIX/$COMPONENT_VAR_PREFIX/g \
        > $TARGET/$FILE
  done

  ENTRYPOINT_load_component $COMPONENT_NAME
}
export -f run_ENTRYPOINT_add_component
