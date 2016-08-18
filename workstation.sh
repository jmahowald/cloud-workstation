#!/bin/sh

docker run -it --rm -v \
   -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
   -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
   -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
   $(pwd):/workspace  \ cloud-workstation $@