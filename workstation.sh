#!/bin/sh


IMAGE_NAME=${CLOUD_WORKSTATION_IMAGE:-artifactory.corp.code42.com:5000/c42/cloud-workstation}

docker run -it --rm \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v $(pwd):/workspace \
   -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
   -v ~/.ssh/known_hosts:/root/.ssh/known_hosts:ro \
   -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
   -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
   -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
     $IMAGE_NAME $@
