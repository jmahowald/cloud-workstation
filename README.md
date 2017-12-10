This is for a very simple toolchain, currently including terraform,git, and the awscli
and some arguably useful scripts.      

## Publishing

This project is integrated with Docker hub.

`make dockerfile` will produce a generated Dockerfile only

This can then be used in an automated build


## Included Tools

* awscli
* terraform (0.10.3)
* packer 
* ansible - optional, you can rebuild though easily. Just uncomment in DockerMake.yml and make
* terragrunt
* git

This also has a baked in stash read only user pem file for git pulls


## Using

This is meant to be used in conjunction with the [okta credential image](https://stash.corp.code42.com/projects/DT/repos/okta-aws-launcher)
to get your original credentials

docker run -it --rm -v $(pwd):/workspace \
  -v ~/.aws-okta/credentials:/root/.aws/credentials:ro \
  docker.artifactory.corp.code42.com/c42/cloud-workstation:latest

This will drop you into your current working directory.  Please note that if there is a .envrc the image will first source that.

This is encapsulated in the script workstation.sh which you can copy to your machine and make available as a script

=