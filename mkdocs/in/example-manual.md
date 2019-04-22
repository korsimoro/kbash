
# kx

```shell 
kx [COMMAND] [help|--help|-help|-h|?] ... 

kx is a bash environment supporting development.

Functions (modify the current shell)
 add-command                Add a function.
 add-component              cd home, or into /home/ewelton/Desktop/korsimoro/utilities/kbash/test/testdir/kx/[C].
 add-function               Add a function.
 cd                         cd /home/ewelton/Desktop/korsimoro/utilities/kbash/test/testdir/kx/[PATH] (or base w/o arg)
 kbash-env                  Display current environment settings.
 kbash-troff                disable KBASH_TRACE
 kbash-tron                 set KBASH_TRACE to trace KBASH internals
 parallel                   Control how many jobs run in parallel.
 reset                      Reload the environment.
 troff                      Stop bash execution trace.
 tron                       Start bash execution trace.


Commands (run as subprocesses)
 about                      Detailed Information about KBASH
 component-list             Just fetch updates
 klang                      Manage KBASH top level languages
 manual                     Generate help manual

No components configured, use kx add-component to add components.

Use kx [FUNCTION|COMMAND|COMPONENT] help for more information.
```

# Functions

Functions manipulate the local shell variables, unlike commands, which are
executed by the shell as a subprocess.

## ```add-command```

```shell 

kx add_command [help|--help|-help|-h|?] COMMAND_NAME

Add a function.

<<DETAILED INFORMATION ABOUT add_command>>
```


## ```add-component```

```shell 

kx add_component [help|--help|-help|-h|?] [COMPONENT]

cd home, or into /home/ewelton/Desktop/korsimoro/utilities/kbash/test/testdir/kx/[C].

kx component-new [component-name] [component-var-prefix]
```


## ```add-function```

```shell 

kx add_function [help|--help|-help|-h|?] FUNCTION_NAME

Add a function.

<<DETAILED INFORMATION ABOUT add_function>>
```


## ```cd```

```shell 

kx cd [help|--help|-help|-h|?] [PATH]

cd /home/ewelton/Desktop/korsimoro/utilities/kbash/test/testdir/kx/[PATH] (or base w/o arg)

This is a shell function, which execute cd as follows:
  cd /home/ewelton/Desktop/korsimoro/utilities/kbash/test/testdir/kx/[PATH].

If no PATH is provided, this just cds into
  cd /home/ewelton/Desktop/korsimoro/utilities/kbash/test/testdir/kx
```


## ```kbash-env```

```shell 

kx kbash_env [help|--help|-help|-h|?] 

Display current environment settings.

kx env
```


## ```kbash-troff```

```shell 

kx kbash_troff [help|--help|-help|-h|?] 

disable KBASH_TRACE

This is equivalent to
  export KBASH_TRACE=false
```


## ```kbash-tron```

```shell 

kx kbash_tron [help|--help|-help|-h|?] 

set KBASH_TRACE to trace KBASH internals

This is equivalent to
  export KBASH_TRACE=true
```


## ```parallel```

```shell 

kx parallel [help|--help|-help|-h|?] MAXJOBS

Control how many jobs run in parallel.


Control how many jobs run in parallel
```


## ```reset```

```shell 

kx reset [help|--help|-help|-h|?] 

Reload the environment.

In this shell, execute:
  /home/ewelton/Desktop/korsimoro/utilities/kbash/test/testdir/kx/activate.sh

This will cause the entire kx runtime to be reloaded,
so any changes to functions or commands will be processed.

This will update the activation count from 0 to 1
```


## ```troff```

```shell 

kx troff [help|--help|-help|-h|?] 

Stop bash execution trace.

Equivalent to
  set +x
```


## ```tron```

```shell 

kx tron [help|--help|-help|-h|?] 

Start bash execution trace.

Equivalent to
  set -x
```



# Commands

### ```about```

```shell 
kx <command> [help]

kx is a bash environment supporting development.

kx is pure anti-pattern, in includes
 - 'within-environment' mutations- bash functions allow forward mutation of the
   active environment, with no guarantees of any stable state, save the single
   application of this function after a clean reset
 - pure 'side-effect' focus.  This is an attempt to identify mutators to the
   filesystem, and to codify them.  All functions and commands in the
   environment are expected to operate upon the filesystem directly.  git
   provides us exceptional visiblity into changes over the active checkout.

kx supports the development of ad-hoc tasks required
to effectively build a complex, multi-project system.

As knowledge is captured w/in the kx script system, it is added
into the compiled node or python build support tools.  But when you have to
adapt to an existing culture, as in a fork, you need a little grease.  The
node and python knowledge is the organized grease to glue a complete system
onto a consistent base.

kx uses a "Convention over Configuration" and heavily seeds a
bash operating environment with functions and variables, supporting
multi-tech integration projects.  The ability to "regenerate" the environment
from the kx reset command means that scripts can be rapidly
edited and applied - recorded in a pull-request, and the collective wisdom
knitting forward.

kx can be rapidly and ad-hoc adjusted, and it is specific to
this repository.  The bashenv orchestrates the connection of the environment
with a conversational mutator - a live bash shell.  As this is bound to a
repository top, the space underneath is managed - so this is effectively a
bash shell over a commit-trail of reference.

kx is scoped by directory (or checkout) - based on the KXX
variable.
  KXX = /home/ewelton/Desktop/korsimoro/utilities/kbash/test/testdir/kx

For more information, check out this file:
/home/ewelton/Desktop/korsimoro/utilities/kbash/test/testdir/kx/docs/bashenv.md

In general use kx [cmd] help for more information.
```

### ```component-list```

```shell 
Show component list
```

### ```klang```

```shell 
kx [LANG] ....

Manage languages

Commands (run as subprocesses)
 node                       System Node
 python                     System Node
 ruby                       System Node
```

#### ```node```

```shell 
kx node [LANG] ....

Manage Local Node
```

#### ```python```

```shell 
kx python [LANG] ....

Manage Local Python
```

#### ```ruby```

```shell 
kx ruby [LANG] ....

Manage Local Ruby
```

### ```manual```

```shell 
Recursively assembleup documentation as a markdown
file.
```


# About

```shell 
kx <command> [help]

kx is a bash environment supporting development.

kx is pure anti-pattern, in includes
 - 'within-environment' mutations- bash functions allow forward mutation of the
   active environment, with no guarantees of any stable state, save the single
   application of this function after a clean reset
 - pure 'side-effect' focus.  This is an attempt to identify mutators to the
   filesystem, and to codify them.  All functions and commands in the
   environment are expected to operate upon the filesystem directly.  git
   provides us exceptional visiblity into changes over the active checkout.

kx supports the development of ad-hoc tasks required
to effectively build a complex, multi-project system.

As knowledge is captured w/in the kx script system, it is added
into the compiled node or python build support tools.  But when you have to
adapt to an existing culture, as in a fork, you need a little grease.  The
node and python knowledge is the organized grease to glue a complete system
onto a consistent base.

kx uses a "Convention over Configuration" and heavily seeds a
bash operating environment with functions and variables, supporting
multi-tech integration projects.  The ability to "regenerate" the environment
from the kx reset command means that scripts can be rapidly
edited and applied - recorded in a pull-request, and the collective wisdom
knitting forward.

kx can be rapidly and ad-hoc adjusted, and it is specific to
this repository.  The bashenv orchestrates the connection of the environment
with a conversational mutator - a live bash shell.  As this is bound to a
repository top, the space underneath is managed - so this is effectively a
bash shell over a commit-trail of reference.

kx is scoped by directory (or checkout) - based on the KXX
variable.
  KXX = /home/ewelton/Desktop/korsimoro/utilities/kbash/test/testdir/kx

For more information, check out this file:
/home/ewelton/Desktop/korsimoro/utilities/kbash/test/testdir/kx/docs/bashenv.md

In general use kx [cmd] help for more information.
```

