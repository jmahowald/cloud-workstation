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
* terraform (0.9.6)
* ansible - optional, you can rebuild though easily. Just uncomment in DockerMake.yml and make
* bats
* git/mercurial
 
## Utility scripts

* awskey - tool to idempotently create key aws keys and the corresponding files
* scaffolding - tool to help generate new projects

```
scaffolding   A homeless man's version of maven archetype.  
Uses dockerize to process template directories and generate files for project types. 
 For instance, will generate .travis.yml and 
Jenkinsfile for docker projects

dockerscript will generate a shell script that you can use to launch your images
with the appropriate mappings


Usage:
  scaffolding dockerproj [--registry=<registry>]  [--outdir=<dir>] <image> 
  scaffolding dockerscript  [-v VOLUMES] [-e ENV_VARS] [-w WORKING_DIR]  <image> 

Options:
   -o --outdir=<dir>      where to put the generated files> [default: .]
   -e --envvars ENVVARS comma separated list of environment variables to map
   -v --volumes VOLUMES  comma separated list if volume mounts over and above any working dire
   -w --working_dir WORKING_DIR  what is the working dir of the container [default: /workspace]
   -r --registry registry to upload to
Arguments:
  image  the name of the image
```


## Using
Copy cloud-workstation.sh to your path directory and make it executable. 