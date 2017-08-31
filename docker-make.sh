#!/bin/bash -x

docker run -it --rm \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v ~/.docker:/root.docker \
   -v $(pwd):/usr/src/app \
   -w /usr/src/app \
   dmake docker-make $@ 

