# Theory of Operation

## ```$PROJECT``` specific activation

### What is a ```$PROJECT```

A project is a ```kbash``` environment coupled to a specific base
directory, known internally as ```$VAR_PREFIX```, where the ```VAR_PREFIX```
variable is the base of the ```$PROJECT```

Keep in mind that ```VAR_PREFIX``` is not the name of the variable, rather
it is the name of the name of the variable.  So, for example, in the ```kx```
test project, ```KXX``` is the ```VAR_PREFIX``` and ```$KXX``` evaluates to
the base of the ```kx``` project.

### What happens

Activate a shell by executing ```. $PROJECT/activate.sh```, which applies
the environment to the current shell, or ```$PROJECT/shell.sh``` which
spawns a subshell with the ```$PROJECT``` environment activated.

The ```. $PROJECT/activate.sh``` command sets the project base directory
and invokes ```$KBASH/util/api/boot.sh```.  Sourcing ```boot.sh``` causes
the following to occur, where all shell input files are ```sed``` filtered
to replace two strings:

- ```SHELL_PREFIX```, which is used to prefix all ```kbash``` environment
 elements.  For example, if your entrypoint is ```kx``` then all of
 the functions involved in this environment should be prefixed
 with ```kx_```.  Access to the environment is then acquired by
 running commands prefixed with ```kx```, such as ```kx build project3```

- ```VAR_PREFIX```, which is used to scope all variables associated with the
 top level build environment.  Often, the ```SHELL_PREFIX``` does not
 scan well in variable assignments.  In the ```kx``` test case, the
 value of ```VAR_PREFIX``` is ```KXX```, meaning that all environment
 variables associated with the ```$PROJECT``` are prefixed with ```KXX_```


1. The following global variables are set during invocation

|Pos|Variable                   |Purpose       |
|---|---------------------------|--------------|
|$1 |SHELL_PREFIX               |scopes functions |
|$2 |VAR_PREFIX                 |scopes variables |
|$3 |USER_UTIL_LOAD_LIST        |loaded, in order, from ```$PROJECT``` |
|$4 |SYSTEM_UTIL_LOAD_LIST      |loaded, in order, from ```$K_BASHENV_BASE```|
