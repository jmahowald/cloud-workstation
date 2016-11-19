This is for a very simple toolchain, currently including terraform,git, and the awscli
and some arguably useful scripts.    To build, run

`make image`

It uses the [Docker Make] project to allow for some level of modularity, so that
one could easily mix and match.


## Publishing

This project is integrated with Docker hub.

`make dockerfile` will produce a generated Dockerfile only

This can then be used in an automated build


## Included Tools

* awscli
* terraform (0.7)
* ansible - optional, you can rebuild though easily. Just uncomment in DockerMake.yml and make
* bats
* git/mercurial
 
## Utility scripts

* awskey - tool to idempotently create key aws keys and the corresponding files


## Using
Copy workstation.sh to your path directory and make it executable. 