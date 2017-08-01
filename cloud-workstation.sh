#!/bin/bash

# Override the image name used for local development 
IMAGE_NAME=${PIPELINE_IMAGE:-artifactory.corp.code42.com:5000/c42/cloud-workstation}

docker run -it --rm \
    -v $(pwd):/workspace \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
    -e AWS_DEFAULT_REGION:AWS_DEFAULT_REGION \
    -e AWS_SECRET_ACCESS_KEY:AWS_SECRET_ACCESS_KEY \
    -e AWS_ACCESS_KEY_ID:AWS_ACCESS_KEY_ID \
    $IMAGE_NAME $@
