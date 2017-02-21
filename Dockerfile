#Build directory: None
#tag: cloud-workstation
FROM gliderlabs/alpine:3.3


#Commands for devbase
RUN apk add --update --no-cache \
    ca-certificates curl wget make bash openssh-client \
    bash git sshpass rsync


#Commands for python
RUN apk add --update --no-cache python \
   python-dev \
   py-pip \
 && pip install virtualenv \
 && rm -rf /var/cache/apk/* \
 && pip install --upgrade pip


#Commands for awscli
RUN pip install awscli
COPY build/aws/aws_bash_helpers.sh /root/.bashrc


#Commands for terraform
ARG TERRAFORM_VERSION=0.8.6
RUN  wget -P /tmp https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
RUN wget -P /tmp https://github.com/CiscoCloud/terraform.py/blob/master/terraform.py && \
   mv /tmp/terraform.py /usr/local/bin && chmod 755 /usr/local/bin/terraform.py


#Commands for clitools
COPY ./build/scripts/*  /usr/local/bin/ 
RUN pip install docopts && chmod 755 /usr/local/bin/*


#Commands for testing
RUN git clone https://github.com/calj/bats.git && bats/install.sh /usr/local  \
  && rm -rf bats


#Commands for dockerize
ENV DOCKERIZE_VERSION v0.3.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz


#Commands for cloud-workstation
WORKDIR /workspace
CMD /bin/bash

