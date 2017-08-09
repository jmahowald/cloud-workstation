#!/bin/bash

# Override the image name used for local development 
IMAGE_NAME=${IMAGE_NAME:-artifactory.corp.code42.com:5000/c42/cloud-workstation}

if [[ $1 == '--update' ]]; then 
    echo "updating underlying image"
    docker pull $IMAGE_NAME
    exit 0
fi  


docker run -it --rm \
    -v $(pwd):/workspace \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
    -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e CUR_DIR_NAME=$(basename $PWD) \
    $IMAGE_NAME $@
