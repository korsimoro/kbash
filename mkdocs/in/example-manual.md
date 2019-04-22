
# kd

```shell 
kd [COMMAND] [help|--help|-help|-h|?] ... 

kd is a bash environment supporting development.

Functions (modify the current shell)
 activate         Configure shell to match build environment for [COMPONENT]
 add-command      Add a function.
 add-component    cd home, or into /home/ewelton/Desktop/korsimoro/projects/kit-workbench/[C].
 add-function     Add a function.
 build            Build [C] using component build system
 cd               cd /home/ewelton/Desktop/korsimoro/projects/kit-workbench/[PATH] (or base w/o arg)
 clean            Remove as many artifacts for [C] as we know about
 describe         Describe information about this build env
 kbash-env        Display current environment settings.
 kbash-troff      disable KBASH_TRACE
 kbash-tron       set KBASH_TRACE to trace KBASH internals
 parallel         Control how many jobs run in parallel.
 reset            Reload the environment.
 setup            Initialize a development environment
 troff            Stop bash execution trace.
 tron             Start bash execution trace.


Commands (run as subprocesses)
 about            Detailed Information about KBASH
 component-list   Just fetch updates
 docs             The KIT Workbench Documentation Environment
 kernel           The KIT Workbench Documentation Environment
 klang            Manage KBASH top level languages
 manual           Generate help manual

Components
 bench            Identity Tech Workbench - powered by JupyterLab
 credcom_kernel   Credenitial-Commons @identity.com
 dsr_kernel       Description of dsr_kernel
 itypescript      Description of itypescript
 nteract          Description of nteract
 tool             Python CLI
 tool_kernel      Description of tool_kernel

Use kd [FUNCTION|COMMAND|COMPONENT] help for more information.
```

# Functions

Functions manipulate the local shell variables, unlike commands, which are
executed by the shell as a subprocess.

## ```activate```

```shell 

kd activate [help|--help|-help|-h|?] [COMPONENT]

Configure shell to match build environment for [COMPONENT]
```


## ```add-command```

```shell 

kd add_command [help|--help|-help|-h|?] COMMAND_NAME

Add a function.

<<DETAILED INFORMATION ABOUT add_command>>
```


## ```add-component```

```shell 

kd add_component [help|--help|-help|-h|?] [COMPONENT]

cd home, or into /home/ewelton/Desktop/korsimoro/projects/kit-workbench/[C].

kd component-new [component-name] [component-var-prefix]
```


## ```add-function```

```shell 

kd add_function [help|--help|-help|-h|?] FUNCTION_NAME

Add a function.

<<DETAILED INFORMATION ABOUT add_function>>
```


## ```build```

```shell 

kd build [help|--help|-help|-h|?] [COMPONENT]

Build [C] using component build system
```


## ```cd```

```shell 

kd cd [help|--help|-help|-h|?] [PATH]

cd /home/ewelton/Desktop/korsimoro/projects/kit-workbench/[PATH] (or base w/o arg)

This is a shell function, which execute cd as follows:
  cd /home/ewelton/Desktop/korsimoro/projects/kit-workbench/[PATH].

If no PATH is provided, this just cds into
  cd /home/ewelton/Desktop/korsimoro/projects/kit-workbench
```


## ```clean```

```shell 

kd clean [help|--help|-help|-h|?] [COMPONENT]

Remove as many artifacts for [C] as we know about

kd clean [COMPONENT] ...

  Goal : Remove as many artifacts for [C] as we know about

Components
 bench            Identity Tech Workbench - powered by JupyterLab
 credcom_kernel   Credenitial-Commons @identity.com
 dsr_kernel       Description of dsr_kernel
 itypescript      Description of itypescript
 nteract          Description of nteract
 tool             Python CLI
 tool_kernel      Description of tool_kernel
```


## ```describe```

```shell 

kd describe [help|--help|-help|-h|?] [COMPONENT]

Describe information about this build env

kd describe [COMPONENT] ...

  Goal : Describe information about this build env

Components
 bench            Identity Tech Workbench - powered by JupyterLab
 credcom_kernel   Credenitial-Commons @identity.com
 dsr_kernel       Description of dsr_kernel
 itypescript      Description of itypescript
 nteract          Description of nteract
 tool             Python CLI
 tool_kernel      Description of tool_kernel
```


## ```kbash-env```

```shell 

kd kbash_env [help|--help|-help|-h|?] 

Display current environment settings.

kd env
```


## ```kbash-troff```

```shell 

kd kbash_troff [help|--help|-help|-h|?] 

disable KBASH_TRACE

This is equivalent to
  export KBASH_TRACE=false
```


## ```kbash-tron```

```shell 

kd kbash_tron [help|--help|-help|-h|?] 

set KBASH_TRACE to trace KBASH internals

This is equivalent to
  export KBASH_TRACE=true
```


## ```parallel```

```shell 

kd parallel [help|--help|-help|-h|?] MAXJOBS

Control how many jobs run in parallel.


Control how many jobs run in parallel
```


## ```reset```

```shell 

kd reset [help|--help|-help|-h|?] 

Reload the environment.

In this shell, execute:
  /home/ewelton/Desktop/korsimoro/projects/kit-workbench/activate.sh

This will cause the entire kd runtime to be reloaded,
so any changes to functions or commands will be processed.

This will update the activation count from 12 to 13
```


## ```setup```

```shell 

kd setup [help|--help|-help|-h|?] [COMPONENT]

Initialize a development environment
```


## ```troff```

```shell 

kd troff [help|--help|-help|-h|?] 

Stop bash execution trace.

Equivalent to
  set +x
```


## ```tron```

```shell 

kd tron [help|--help|-help|-h|?] 

Start bash execution trace.

Equivalent to
  set -x
```



# Commands

### ```about```

```shell 
kd <command> [help]

kd is a bash environment supporting development.

kd is pure anti-pattern, in includes
 - 'within-environment' mutations- bash functions allow forward mutation of the
   active environment, with no guarantees of any stable state, save the single
   application of this function after a clean reset
 - pure 'side-effect' focus.  This is an attempt to identify mutators to the
   filesystem, and to codify them.  All functions and commands in the
   environment are expected to operate upon the filesystem directly.  git
   provides us exceptional visiblity into changes over the active checkout.

kd supports the development of ad-hoc tasks required
to effectively build a complex, multi-project system.

As knowledge is captured w/in the kd script system, it is added
into the compiled node or python build support tools.  But when you have to
adapt to an existing culture, as in a fork, you need a little grease.  The
node and python knowledge is the organized grease to glue a complete system
onto a consistent base.

kd uses a "Convention over Configuration" and heavily seeds a
bash operating environment with functions and variables, supporting
multi-tech integration projects.  The ability to "regenerate" the environment
from the kd reset command means that scripts can be rapidly
edited and applied - recorded in a pull-request, and the collective wisdom
knitting forward.

kd can be rapidly and ad-hoc adjusted, and it is specific to
this repository.  The bashenv orchestrates the connection of the environment
with a conversational mutator - a live bash shell.  As this is bound to a
repository top, the space underneath is managed - so this is effectively a
bash shell over a commit-trail of reference.

kd is scoped by directory (or checkout) - based on the KITWB
variable.
  KITWB = /home/ewelton/Desktop/korsimoro/projects/kit-workbench

For more information, check out this file:
/home/ewelton/Desktop/korsimoro/projects/kit-workbench/docs/bashenv.md

In general use kd [cmd] help for more information.
```

### ```component-list```

```shell 
Show component list
```

### ```docs```

```shell 
Missing scope file in help
```

#### ```renew```

```shell 
Missing scope file in renew
```

### ```kernel```

```shell 
Missing scope file in help
```

#### ```fulltest```

```shell 
Missing scope file in fulltest
```

#### ```setup```

```shell 
Missing scope file in setup
```

#### ```spec```

```shell 
Missing scope file in spec
```

#### ```test```

```shell 
Missing scope file in test
```

### ```klang```

```shell 
Missing scope file in help
```

#### ```node```

```shell 
Missing scope file in node
```

#### ```python```

```shell 
Missing scope file in python
```

#### ```ruby```

```shell 
Missing scope file in ruby
```

### ```manual```

```shell 
Recursively assembleup documentation as a markdown
file.
```


# Components

|Component|Description|
|-|-|
|bench|Identity Tech Workbench - powered by JupyterLab|
|credcom_kernel|Credenitial-Commons @identity.com|
|dsr_kernel|Description of dsr_kernel|
|itypescript|Description of itypescript|
|nteract|Description of nteract|
|tool|Python CLI|
|tool_kernel|Description of tool_kernel|


## ```bench```

```shell 

kd bench [SUBCOMMAND] [OPTIONS]


kd bench commands

Commands (run as subprocesses)
 bootstrap        Just fetch updates
 info             view docs
 setup_nvm        Setup
```


### ```bootstrap```

```shell 
kd bootstrap 
```

### ```info```

```shell 
kd bench info

Info about kd bench
```

### ```setup_nvm```

```shell 
kd setup-nvm

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash


-e|--echo
```

## ```credcom_kernel```

```shell 

kd bench [SUBCOMMAND] [OPTIONS]


kd bench commands

Commands (run as subprocesses)
 install          install kernel
 launch           install kernel
 package          install kernel
 patch            install kernel
```


### ```install```

```shell 
kd credcom_kernel kernel install

Create install
```

### ```launch```

```shell 
kd credcom_kernel kernel install

Create install
```

### ```package```

```shell 
kd credcom_kernel kernel package

Create Package
```

### ```patch```

```shell 
kd credcom_kernel kernel package

Create Package
```

## ```dsr_kernel```

```shell 

kd bench [SUBCOMMAND] [OPTIONS]


kd bench commands

Commands (run as subprocesses)
 install          install kernel
 launch           install kernel
 package          install kernel
 patch            install kernel
```


### ```install```

```shell 
kd credcom_kernel kernel install

Create install
```

### ```launch```

```shell 
kd credcom_kernel kernel install

Create install
```

### ```package```

```shell 
kd credcom_kernel kernel package

Create Package
```

### ```patch```

```shell 
kd credcom_kernel kernel package

Create Package
```

## ```itypescript```

```shell 

kd bench [SUBCOMMAND] [OPTIONS]


kd bench commands

Commands (run as subprocesses)
 info             view docs
```


### ```info```

```shell 
kd itypescript info

Info about kd itypescript
```

## ```nteract```

```shell 

kd bench [SUBCOMMAND] [OPTIONS]


kd bench commands

Commands (run as subprocesses)
 start            start
```


### ```start```

```shell 
kd nteract start

Info about kd nteract start
```

## ```tool```

```shell 

kd bench [SUBCOMMAND] [OPTIONS]


kd bench commands

Commands (run as subprocesses)
 docs             init
 init             init
 initsheets       initsheets
 manual           init
```


### ```docs```

```shell 
kd tool init

write out commands to add and tag initial sheets
```

### ```init```

```shell 
kd tool init

write out commands to add and tag initial sheets
```

### ```initsheets```

```shell 
kd tool initsheets

write out commands to add and tag initial sheets
```

### ```manual```

```shell 
kd tool init

write out commands to add and tag initial sheets
```

## ```tool_kernel```

```shell 

kd bench [SUBCOMMAND] [OPTIONS]


kd bench commands

Commands (run as subprocesses)
 info             view docs
 install          install kernel
 package          install kernel
```


### ```info```

```shell 
kd tool_kernel info

Info about kd tool_kernel
```

### ```install```

```shell 
kd tool_kernel kernel install

Create install
```

### ```package```

```shell 
kd tool_kernel kernel package

Create Package
```


# About

```shell 
kd <command> [help]

kd is a bash environment supporting development.

kd is pure anti-pattern, in includes
 - 'within-environment' mutations- bash functions allow forward mutation of the
   active environment, with no guarantees of any stable state, save the single
   application of this function after a clean reset
 - pure 'side-effect' focus.  This is an attempt to identify mutators to the
   filesystem, and to codify them.  All functions and commands in the
   environment are expected to operate upon the filesystem directly.  git
   provides us exceptional visiblity into changes over the active checkout.

kd supports the development of ad-hoc tasks required
to effectively build a complex, multi-project system.

As knowledge is captured w/in the kd script system, it is added
into the compiled node or python build support tools.  But when you have to
adapt to an existing culture, as in a fork, you need a little grease.  The
node and python knowledge is the organized grease to glue a complete system
onto a consistent base.

kd uses a "Convention over Configuration" and heavily seeds a
bash operating environment with functions and variables, supporting
multi-tech integration projects.  The ability to "regenerate" the environment
from the kd reset command means that scripts can be rapidly
edited and applied - recorded in a pull-request, and the collective wisdom
knitting forward.

kd can be rapidly and ad-hoc adjusted, and it is specific to
this repository.  The bashenv orchestrates the connection of the environment
with a conversational mutator - a live bash shell.  As this is bound to a
repository top, the space underneath is managed - so this is effectively a
bash shell over a commit-trail of reference.

kd is scoped by directory (or checkout) - based on the KITWB
variable.
  KITWB = /home/ewelton/Desktop/korsimoro/projects/kit-workbench

For more information, check out this file:
/home/ewelton/Desktop/korsimoro/projects/kit-workbench/docs/bashenv.md

In general use kd [cmd] help for more information.
```

