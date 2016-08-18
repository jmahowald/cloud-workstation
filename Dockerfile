#Build directory: build/aws
#tag: cloud-workstation
FROM gliderlabs/alpine:3.3


#Commands for devbase
RUN apk add --update \
    ca-certificates curl wget make bash


#Commands for python
RUN apk add --update python \
   python-dev \
   py-pip \
 && pip install virtualenv \
 && rm -rf /var/cache/apk/*


#Commands for awscli
RUN pip install awscli
COPY aws_bash_helpers.sh /etc/profile.d/


#Commands for terraform
ARG TERRAFORM_VERSION=0.7.0
RUN  wget -P /tmp https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*


#Commands for cloud-workstation
RUN apk update && apk upgrade && apk add --no-cache bash git
WORKDIR /workspace
CMD /bin/bash

