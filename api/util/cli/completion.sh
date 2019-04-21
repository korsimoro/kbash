#!/bin/bash
#
_ENTRYPOINT_completion()
{
    # TODO: _split_longopt
    #COMPREPLY=( $( compgen -W '$KITWB_BASH_FUNCTIONS $(kd_findkids kd)' -- "$cur" ) )
    COMPREPLY=""
}
complete -F _$ENTRYPOINT_completion "$ENTRYPOINT"
