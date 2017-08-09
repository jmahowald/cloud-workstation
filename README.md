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
* tfremote - tool to aid in consistently setting up terraform remote state

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

```
setups terraform remote state bucket and environment in one go
Usage: tfremote [-n|--name <arg>] [-e|--env <arg>] [-r|--remote-bucket-region <arg>] [-f|--(no-)force] [-h|--help] <remote-bucket>
        <remote-bucket>: Where to store the state information
        -n,--name: the name of the terraform layer, if you're running this in a docker container, you can supply an enviornmnet variableof CUR_DIR_NAME  (no default)
        -e,--env: dev/qa/etc (default: 'default')
        -r,--remote-bucket-region: what region is the bucket in, defaults to current (default: '
        ')
        -f,--force,--no-force: whether to force reinitialization of terraform. Useful when switching terraform environments  (off by default)
        -h,--help: Prints help
```

Example:

`workstation tfremote -n iam-roles terraform.dev.cd.code42.com` this would do a terraform init into the s3 bucket 
so that the given project would keep it's remote state in s3://terraform.dev.cd.code42.com/iam-roles/terraform.tfstate

## Using
Copy cloud-workstation.sh to your path directory and make it executable, name it workstation