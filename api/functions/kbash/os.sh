#!/bin/bash

function oneline_help_ENTRYPOINT_kbash_os() {
  echo "Display os"
}
export -f oneline_help_ENTRYPOINT_kbash_os

function cmdline_help_ENTRYPOINT_kbash_os() {
  echo ""
}
export -f cmdline_help_ENTRYPOINT_kbash_os

function help_ENTRYPOINT_kbash_os() {
printf "`cat << EOF
This command will report what the kbash utilities think the current operating
system is.

You can use the following functions in the shell environment (or your own)
scripts, if you want a quick check to determine your operating system
- is_osx
- is_linux
- is_windows

This is based off of ```uname``` - so.  You can use kbash-os to show you
the uname output and check the value so is_osx, is_linux, is_windows

For example:
```
> ENTRYPOINT kbash-os
Checking os: uname ='Linux kisia 4.15.0-48-generic #51-Ubuntu SMP Wed Apr 3 08:28:49 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux'
Linux Detected
>
```

EOF
`\n"
}
export -f help_ENTRYPOINT_kbash_os

function run_ENTRYPOINT_kbash_os() {
  echo "Checking os"
  echo "  uname -a ='$(uname -a )'"
  for check in is_osx is_linux is_windows; do
    printf "%10s = " $check
    if $check; then
      echo "true"
    else
      echo "false"
    fi

  done
  if is_osx; then
    report_ok "OSX"
  else
    if is_windows; then
      report_ok "Windows Detected"
    else
      if is_linux; then
        report_ok "Linux Detected"
      else
        report_error "No OS Detected"
      fi
    fi
  fi

}
export -f run_ENTRYPOINT_kbash_os
