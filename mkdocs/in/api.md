# api

The API is defined by
  - ```SHELL_PREFIX```
  - ```VAR_PREFIX```

State:

|Variable                   | Value                         |
|---------------------------|-------------------------------|
| VAR_PREFIX                |                               |
| VAR_PREFIX_BASH           | $VAR_PREFIX/bashenv           |
| VAR_PREFIX_KBASH_LOGS     | $VAR_PREFIX/kbash-logs        |
| VAR_PREFIX_BASH_COMMAND   | $VAR_PREFIX_BASH/commands     |
| VAR_PREFIX_FUNCTION_LIST  |                               |
| VAR_PREFIX_BASH_FUNCTION  | $VAR_PREFIX_BASH/functions    |
| VAR_PREFIX_COMPONENT_LIST |                               |
| VAR_PREFIX_COMPONENT_DIR  | $VAR_PREFIX_BASH/components   |

## api/boot.sh

boot.sh is invoked with 4 positional arguments

```
. <path-to-project-local-activate.sh> \
  "SHELL_PREFIX"                      \
  "VAR_PREFIX"                        \
  "USER_UTIL_LOAD_LIST"               \
  "SYSTEM_UTIL_LOAD_LIST"
```

About

- *SHELL_PREFIX*
  The shell prefix is the command line entry point used to
  access this environment.  It is also used to scope all
  functions loaded into the shell.

## api/commands
