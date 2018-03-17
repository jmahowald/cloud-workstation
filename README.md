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

docker run -it --rm -v $(pwd):/workspace \
  -v ~/.aws:/root/.aws/credentials:ro \
  joshmahowald/cloudworkstation
  
This will drop you into your current working directory.  Please note that if there is a .envrc the image will first source that.

This is encapsulated in the script workstation.sh which you can copy to your machine and make available as a script

=