#!/bin/bash

kbash_register_language() {
  local LANGUAGE=$1

  KBASH_LANGUAGE_LIST=$(sorted_key_set $KBASH_LANGUAGE_LIST $LANGUAGE )
}
export -f kbash_register_language
