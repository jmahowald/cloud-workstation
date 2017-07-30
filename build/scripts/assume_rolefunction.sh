#!/bin/bash

# Bash function to make it easier to assume roles
# H/T https://github.com/Integralist/Shell-Scripts/blob/master/aws-cli-assumerole.sh



assume_role() {
    role_name=$1
    acct_id=$(aws sts get-caller-identity --output text --query 'Account')
    eval unset AWS_SESSION_TOKEN

    temp_role=$(aws sts assume-role \
                    --role-arn "arn:aws:iam::$acct_id:role/$role_name" \
                    --role-session-name "$role_name")
    echo "Role is $temp_role"
    eval export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq .Credentials.AccessKeyId | xargs)
    eval export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq .Credentials.SecretAccessKey | xargs)
    eval export AWS_SESSION_TOKEN=$(echo $temp_role | jq .Credentials.SessionToken | xargs)
}
