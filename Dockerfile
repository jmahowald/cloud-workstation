#Build directory: None
#tag: cloud-workstation
FROM python:3-alpine as base
RUN apk add --update --no-cache \
    ca-certificates curl wget openssh-client bash git jq \
    make git 
    

FROM python:3-alpine as python-base
RUN pip install virtualenv 
RUN virtualenv /opt/workstation/py

FROM python-base as pytools
COPY requirements.txt .
RUN apk add --update --no-cache bash
# Need build tools 
RUN apk --no-cache add --update -t deps git gcc make musl-dev libxml2-dev \
    libxslt-dev openssl-dev libffi-dev linux-headers
# virtualenv must be sourced which is a bash function
RUN /bin/bash -c 'source /opt/workstation/py/bin/activate && pip install -r requirements.txt'

FROM base as direnv
ARG DIRENV_VERSION=v2.13.1
RUN  wget -P /tmp  https://github.com/direnv/direnv/releases/download/${DIRENV_VERSION}/direnv.linux-amd64  
RUN  mv /tmp/direnv.linux-amd64 /usr/local/bin/direnv && chmod 755 /usr/local/bin/direnv

# TODO this is the one part that is organization specific, consider moving to separate Dockerfile


FROM base 

RUN apk add --no-cache nodejs
COPY --from=pytools /opt/workstation/py /opt/workstation/py
COPY --from=direnv /usr/local/bin/direnv /usr/local/bin

COPY bash_profile_helpers/* /etc/profile.d/
RUN chmod 755 /usr/local/bin/*

ENV TERRAFORM_CACHE_DIR /root/.terraform.d/linux_amd64
WORKDIR /workspace
ENTRYPOINT ["/bin/bash", "-login"]

