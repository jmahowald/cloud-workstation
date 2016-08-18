#!/bin/sh

docker run -v $(pwd):/data -v /var/run/docker.sock:/var/run/docker.sock genesysarch/docker-make $@
