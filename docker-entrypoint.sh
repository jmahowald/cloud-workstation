#!/bin/bash
if [[ ! -z $DIRENV_ALLOW && -f .envrc ]]; then
    echo "Sourcing direnv"
    direnv allow
fi

if [[ ! -z $AWS_ROLE_NAME ]]; then
    echo "Found aws role. Assuming $AWS_ROLE_NAME"
	source /usr/local/bin/assume-role-function.sh
    assume_role $AWS_ROLE_NAME
fi
exec "$@"

