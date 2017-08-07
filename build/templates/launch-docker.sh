#!/bin/bash

# Override the image name used for local development 
IMAGE_NAME=${IMAGE_NAME:-{{.Env.IMAGE_NAME}}}

if [[ $1 == '--update' ]]; then 
    echo "updating underlying image"
    docker pull $IMAGE_NAME
    exit 0
fi  


docker run -it --rm \
    {{ if not .Env.WORKDIR -}}
    {{- else -}}
    -v $(pwd):{{.Env.WORKDIR}} \
    {{ end -}}
    {{ if not .Env.VOLUMES -}}
    {{- else -}}
    {{ range $index, $value := split (default .Env.VOLUMES "") "," -}}
    -v {{$value}} \
    {{end -}}
    {{- end -}}
    {{ range $index, $value := split (default .Env.ENV_VARS "") "," -}}
    -e {{$value}}=${{$value}} \
    {{end -}}
    $IMAGE_NAME $@
