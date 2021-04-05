The ```kbash``` project add-on is a set of ```bash``` utilities supporting
knowledge capture and organizing ad-hoc plumbing.  It is often useful in
multi-component, multi-language software projects - especially if they use
multiple build tools.  And it can be useful in cobbling together disparate
builds and systems to prototype components.  Once a project suite is stabilzied
the kbash functionality should be absorbed into specific, formal, project
appropriate infrastructure.

# Quickstart

The following commands verify that the system is operational.
This sets up a new environment, runs a shell inside it,
runs the default documentation command, and then exits the shell.

```
git clone git@github.com:korsimoro/kbash ~/.kbash
~/.kbash/test/sanity.sh
```
This will install a test environment and execute the entrypoint command
to generate the default help output.
[Click here for example output](docs/example-outputs#sanity)

You can find Documentation in the current docs directory, by opening the
[docs/index.html](docs/index.html) file with your local browser.

# Bootstrap

Applying ```kbash``` to an existing project is easy.  The following
will add ```kbash``` support to your project, relying upon the global
checkout for utility functions and separating project-specific configuration
from generic utility core (typically in ```~/.kbash```)
```
git clone git@github.com:korsimoro/kbash ~/.kbash
~/.kbash/setup.sh <ENTRYPOINT> <VAR_PREFIX> <DIRECTORY>
<DIRECTORY>/shell.sh
```

The three variable listed above are described here:

| Argument   | Example |Description                            |
|------------|---------|---------------------------------------|
| ENTRYPOINT | ```kb```| This is the name of the command introduced into the environment, and the prefix on all defined shell assets (functions, internal variables) |
| VAR_PREFIX   |```KB```|This is the prefix attached to all public variables used to describe and control the environment. |
| DIRECTORY  | ```$PROJECT/kbash```| This is the directory in which the new, project specific, ```kbash``` environment is to be set up.  Canonically it is in the kbash directory of your project.  This directory exists *in addition to* the clone above. |

# Development & Documentation

If you are interested in developing or building kbash, please check
out our [Developers](developers) file.  This talks about how to view
and build the existing documentation.

We use docker with [MkDoc-Material](https://squidfunk.github.io/mkdocs-material/getting-started/)

# A Cool Trick

You can run a single command within a kbash environment, without influencing
the external execution environment.
```
echo "kx manual" | $BUILD_DOCS_BASE/../test/single.sh -i > $BUILD_DOCS_BASE/in/example-manual.md
```

# What is ```kbash``` and how would I use it?

Many software projects, such as an ```npm``` package, or a ```python```
module, or a ```rust``` crate, or a ```ruby``` gem have sufficient support
within the language environment for building and packaging code, for
running tests, for linking documentation with the code base, etc.  However,
in complex, multi-language, multi-component projects, coordinating the
different build environments often requires bits and pieces of glue which
do not fit well in the language specific build systems.

The ```kbash``` environment provides a way to organize those bits of logic
as a set of shell functions and files.  When rapidly investigating
and hacking around multiple projects spanning diverse technology sets,
it is often useful to write a one-off shell script that you expect to use
once-or twice, but often wind up using for a while.

The ```kbash``` environment is a Convention-based toolkit which organizes
these one-off bits of knowledge, until such time as they can be integrated
into the mainstream build environments -  at which time the ```kbash```
environment should be pruned. ```kbash``` should be a value-added utility
for temporary hacky-information capture, not a solution in itself.

A final role of ```kbash``` is in capturing environmental integrity, sanity,
and state checks.  This is exactly the sort of utility you hope you never
need, but which can greatly improve the ability to troubleshoot broken
environments.

# Concepts

## A Project

A ```kbash``` project consists of
- a ```kbash``` directory within the project
- a checkout of the ```korsimoro/kbash``` common library, typically ```~/.kbash```

The common library provides utility functions and scripts which are not
related to any specific project.  All project specific data is located
in the ```kbash``` project directory, typically at ```$PROJECT/kbash```

## ```ENTRYPOINT``` command line tool

Every project has a command line tool with subcommands, much like ```git```.
Interestingly, ```kbash``` takes the form of a ```bash```
function, which allows it to manipulate the ```current``` environment
variables in cases when it is useful to do so, such as activating a
python virtual environment, a node virtual environment, or some combination
of environments (for example, a project using *both* a python venv *and*
an nvm environment).

## Commands vs. Functions

A key distinction must be made between ```bash``` functions and commands.
Commands are executed as subprocesses, like any other command - meaning that
the environment of the executing child process is isolated from the running
shell.  A subcommand can not, for example, change the current prompt.

Functions, on the other hand, run within the current shell and as such they
can modify the current environment.  This is exploited by many of the
language specific virtual environment managers and modern ```bash``` provides
a tremendous amount of support for such scripting.  On the other hand, with
great power comes great responsibility - so every attempt is made to minimize
the use of functions and limit their use to cases in which a modification of
the environment is necessary.

A common example of this distinction are ```cd``` and ```ls``` - ```cd``` is
a bash-builtin which operates on the current environment, while ```ls``` is
just a program that needs to be _in the PATH_.

## Components

A ```kbash``` project is usually made up of multiple parts which need to
be coordinated, and often which have a common lifecycle.  For example, one
project where ```kbash``` proved useful, used forks of two lerna-based
monorepo typescript projects, two forks of python projects, one mixed
python/typescript project, one project that built all of the above into
an electron deliverable.  In this case, each project was modeled as a
component.

Declaring a component is done simply, using this form
```
ENTRYPOINT add-component [name] [var-prefix]
```

Which sets up the following structure - creating what needs to be created
and using existing elements (like directories) if present:

| What                                     | Description |
|------------------------------------------|------------------------------------------------|
| ```$PROJECT/kbash/components/[name]```   | The place for your component functions & commands |
| ```ENTRYPOINT [name] ....```             | The cli hook |
| ```$PROJECT/[name]```                    | The directory containing the component |
| ```${var-prefix}_BASE```                 | Variable pointing to the ```$PROJECT/[name]``` directory |
| other default variables                  | look in ```$PROJECT/kbash/components/[name]/describe.sh``` |
| ```ENTRYPOINT [cfunc] [name]```          | see the table below |

### Standard Component Lifecycle

| Stage | Description |
|-|-|
| setup  |  This performs functions like ```npm install```, set up a python venv, install ruby gems, etc. |
| clean  |  This erases anything installed in setup |
| activate | This makes the environment constructed in setup the active environment |
| describe | This provides information about the environment |
| build | This triggers whatever is the standard build script for the component |

These are not strongly required - and, in fact, they are simply bash functions
that get called and which obey a standard naming convention.  The hope is that
using ```add-component``` will pattern out a set of files, which can then be
quickly edited, to capture the sort of information that is typically in the
component's readme - for example, running ```npm install```.

In the table below, imagine that we have a project called ```ex``` with
a single component called ```comp1``` set up using:
```
~/.kbash/setup.sh ex EX /tmp/ex
ex add-component comp1 COMP1
```
In this case, the following is set up

| CLI | Function | Where Defined |
|-|-|-|
| ```ex build comp1```  |  ```build_environment_ex_comp1``` | $EX/kbash/components/comp1/build.sh |
| ```ex activate comp1```  |  ```activate_environment_ex_comp1``` | $EX/kbash/components/comp1/activate.sh |
| ```ex describe comp1```  |  ```describe_environment_ex_comp1``` | $EX/kbash/components/comp1/describe.sh |
| ```ex clean comp1```  |  ```clean_environment_ex_comp1``` | $EX/kbash/components/comp1/clean.sh |
| ```ex setup comp1```  |  ```setup_environment_ex_comp1``` | $EX/kbash/components/comp1/setup.sh |




# Old Notes
## When to use

- *project-discovery*

  For mature projects, the roll of ```kbash``` should be reduced substantially.
  The ```kbash``` environment exists to support exploration, and the documented
  accretion of devops knowledge in the form of ```bash``` snippets, operating
  against a rich field of structure, utilities, and variables.

- *multi-project*

  If a project consists of a blending of multiple sub-projects, and the
  investigation of an complex build.  Once the complex build is well
  understood, the knowledge accumulated in ```kbash``` scripts should be
  migrated into the more mature build systems of the sub-projects.

## Drivers

- *environment-coupling*

  Rather than being confined to operations on the filesystem, ```kbash```
  allows systematic use of the shell environment.

  This is similar to
  - *python venv* - virtual environments for python
  - *nvm* - virtual environments for node
  - *rvm* - virtual environments for ruby

  Environmental coupling is accomplished through the use of bash function
  sets which are integrated into the control, help, and convention systems.

- *multiple-concurrency*

  Multiple ```kbash``` environments can co-exist, as all shell variables,
  including the entry point, are scoped by prefixes
  - *ENTRYPOINT* - this is the entrypoint, and is used to prefix all
    project specfic information.

- *environment-isolation*

  Often, when developing ```node``` or ```python``` systems, each has an
  active set of CLI entrypoints which are required by the repository.  Many
  build systems rely on system deployments.  While solutions like ```docker```
  are excellent at capturing these dependencies, there is often a lengthy
  task of figuring out how to combine those solutions into a docker image,
  as well as making decisions about which solution flavor to include.

  The ```kbash``` environment is useful in capturing this information, through
  the use of appropriate environment variables which are unique to a given
  sub-project.

- *consistent scripting environment*

  Many useful patterns in ```bash``` scripting are rather arcane.  ```kbash```
  wraps these in more intent-expressive labels.

- *dynamic-reload*

  Talk about ```kd reset``` and ACTIVATION_COUNT and prompt

- *dynamic-assignment*

  Talk about loading via Eval via boot.sh

## When not use

- *make-replacement*

  The ```kbash``` environment is not a ```make``` replacement

- *yarn-replacement*

  The ```kbash``` environment is not a ```yarn``` replacement

- *npm-replacement*

  The ```kbash``` environment is not a ```npm``` replacement

- *lerna-replacement*

  The ```kbash``` environment is not a ```lerna``` replacement


## How to use ```kbash``` for a ```PROJECT```

A project is a ```kbash``` environment coupled to a specific base
directory, known internally as ```$VAR_PREFIX```, where the ```VAR_PREFIX```
variable is the base of the ```$PROJECT```.



Keep in mind that ```VAR_PREFIX``` is not the name of the variable, rather
it is the name of the name of the variable.  So, for example, in the example
above, the ```kb``` test project, the value of ```$KB``` will be the root
of the project, and ```$KB/kbash``` will organize the specific bits of bash
technology for the project.  In additional, all internal state variables
will be prefixed by ```KB```

test project, ```KXX``` is the ```VAR_PREFIX``` and ```$KXX``` evaluates to
the base of the ```kx``` project.

## Commands and Functions

## Utility files and Language Support

## Components

# Concept and Purpose
