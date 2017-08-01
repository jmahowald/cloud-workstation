#!/bin/bash

# Override the image name used for local development 
IMAGE_NAME=${PIPELINE_IMAGE:-{{.Env.IMAGE_NAME}}}

docker run -it --rm \
    -v $(pwd):{{.Env.WORKDIR}} \
    {{ range $index, $value := split .Env.ENV_VARS "," -}}
    -e {{$value}}:{{$value}} \
    {{end -}}
    $IMAGE_NAME $@
