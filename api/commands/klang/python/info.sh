#!/bin/bash
# System python information
print_help() {
	printf "`cat << EOF
	${BLUE}ENTRYPOINT klang python info [help]${NC}

What is currently installed on the system and where is it.

The language support is actually in $KBASH/lang/python.sh - see that for
full details.  lang/python.sh
check_basic_python_ability

report_python_env [DIR]

create_python3_env [DIR]
ensure_active_python3_env [DIR]
activate_python_env [DIR]
default_python_setup [DIR]
EOF
`\n\n"

}
run() {

	report_vars "Current Python env variables"\
		KBASH_PYTHON3 \
		KBASH_PYTHONPATH \
		PYTHONPATH

	if check_basic_python_ability; then
		report_ok "Python is available"
		report_message "Current system python version:$(KBASH_PYTHON3 --version)"
		report_message "current python, $(command -v python)"
		report_message "current python version, $(python --version)"
	else
		report_warning "Python is *not* available"
	fi
}
