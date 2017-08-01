#!/bin/bash

# Override the image name used for local development 
IMAGE_NAME=${IMAGE_NAME:-{{.Env.IMAGE_NAME}}}

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
