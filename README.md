# Quickstart

```
git clone git@github.com:korsimoro/k-bashenv ~/.k-bashenv
```

# Concept and Purpose

The ```kbash``` environment may be useful when rapidly investigating
and hacking around multiple projects across diverse technologies.  In
such a context, it is often useful to write a one-off shell script that
you expect to use once-or twice, but often wind up using for a while.

The ```kbash``` environment is a Convention-based toolkit which organizes
these one-off bits of knowledge, until such time as they can be integrated
into the mainstream build environment (at which time the ```kbash```
environment can be pruned.)

The ```kbash``` environment aims to be the grease-in-the-gears, where
accumulation of project-specific structure and knowledge should be
continuously migrated out of the ```kbash``` environment.


 while rapidly investigating,
building, and exploring new technologies.  Many times it is useful to write
a quick script, in ```bash``` to do a task.

If that task is useful enoug
 technologies, languages, and scopes I have
found it useful to write little utility scripts in ```bash```.

Usually these scratch some immediate itch as you work through
the various READMEs and adjust


## Drivers

- *multiple-concurrency*
  Multiple kbash environment

- *environment-isolation*

- *consistent scripting environment*
  When


# Layout

## api

The API is defined by
  - SHELL_PREFIX
  - VAR_PREFIX

### api/boot.sh

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

### api/commands
