#!/bin/bash
#
_SHELL_PREFIX_completion()
{
    # TODO: _split_longopt
    #COMPREPLY=( $( compgen -W '$KITWB_BASH_FUNCTIONS $(kd_findkids kd)' -- "$cur" ) )
    COMPREPLY=""
}
complete -F _$SHELL_PREFIX_completion "$SHELL_PREFIX"
