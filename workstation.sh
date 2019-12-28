#!/bin/env bash
IMAGE=${IMAGE:-"joshmahowald/cloud-worsktation"}

docker run -it $(pwd):/work -w /work \
  -e AWS_PROFILE=$AWS_PROFILE -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
  -v $HOME/.aws:/root/.aws --rm $IMAGE