# Quickstart

## Proof of Concept

This will verify that the system is operational.

```
git clone git@github.com:korsimoro/kbash ~/.kbash
~/.kbash/test/live.sh
```

## Bootstrap

This is how you bootstrap a new environment

```
git clone git@github.com:korsimoro/kbash ~/.kbash
~/.kbash/setup.sh <ENTRYPOINT> <VARSCOPE> <DIRECTORY>
```

| Argument   | Description                           |
|------------|---------------------------------------|
| ENTRYPOINT | This is the name of the command introduced into the environment, and the prefix on all defined shell assets (functions, internal variables) |
| VARSCOPE   | This is the prefix attached to all public variables used to describe and control the environment |
| DIRECTORY  | This is the directory in which the new ```kbash``` environment is to be set up |

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
continuously migrated out of the ```kbash``` environment.  ```kbash```
should be a value-added utility, not a solution in itself.

The ```kbash``` environment supports ```bash```ing code into behaviour,
adapting to local conditions, and exploring what needs to be done to move
projects to the next level - without hampering the developer with the need
to *get the dev-env working* first.

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
  - *SHELL_PREFIX* - this is the entrypoint, and is used to prefix all
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


# [Repository Layout](layout.md)

## Subdirectories
|Dir       | Purpose       |
|----------|---------------|
|api       | Subsystem exposed in consumer shells              |
|core      | Core ```bash``` abilities               |
|docs      | Documentation shipped on public site             |
|lang      | Specific Language Support (node, python, ruby, etc....)             |
|mkdocs    | Source for site docs             |
|setup     | Templates used in new environments             |
|test      | Utilities supporting test             |

## Executable Files
|File       | Purpose       |
|----------|---------------|
|boot.sh   | Invoke to activate custom environment              |
|setup.sh  | Use to set up a new environment |

## Utility Files
|Fjle       | Purpose       |
|----------|---------------|
|os.sh     | Specific OS/Bash level adaptations             |


## Control Files
|Fjle       | Purpose       |
|----------|---------------|
|README.md  | Use to set up a new environment |
|LICENSE  | not yet present |
