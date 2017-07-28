#!/bin/sh

docker run -it --rm \
   -v $(pwd):/workspace \
   -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
   -v ~/.ssh/known_hosts:/root/.ssh/known_hosts:ro \
   -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
   -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
   -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
     artifactory.corp.code42.com:5000/c42/cloud-workstation $@
