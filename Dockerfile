#Build directory: None
#tag: cloud-workstation
FROM python:3.8-buster as base
RUN apt-get update && apt-get install  \
    ca-certificates curl wget openssh-client bash git jq -y \
    make git 
    
FROM alpine/terragrunt:0.12.17 as terraform
ARG TERRAFORM_VERSION=0.12.17
RUN  wget -P /tmp https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*


FROM base 

RUN pip install awscli awslogs
COPY --from=terraform  /usr/local/bin/terragrunt /usr/local/bin/
COPY --from=terraform  /usr/local/bin/terraform /usr/local/bin/

RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
RUN dpkg -i  session-manager-plugin.deb


COPY workstation.sh /usr/local/bin

WORKDIR /workspace
