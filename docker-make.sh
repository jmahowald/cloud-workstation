#!/bin/sh
# Generates Dockerfile from the DockerMake.yml file

docker run -v $(pwd):/data -v /var/run/docker.sock:/var/run/docker.sock genesysarch/docker-make $@
