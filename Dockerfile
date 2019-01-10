#Build directory: None
#tag: cloud-workstation
FROM python:3-alpine as base
RUN apk add --update --no-cache \
    ca-certificates curl wget openssh-client bash git jq \
    make git 
    
FROM base as terraform
ARG TERRAFORM_VERSION=0.11.11
RUN  wget -P /tmp https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*


FROM base 

RUN pip install awscli
COPY --from=terraform  /usr/local/bin/terra* /usr/local/bin/

WORKDIR /workspace
