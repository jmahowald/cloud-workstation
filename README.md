This is for a very simple toolchain, currently including terraform,git, and the awscli
and some arguably useful scripts.    To build, run

`make image`

It uses the [Docker Make] project to allow for some level of modularity, so that
one could easily mix and match.


## Publishing

This project is integrated with Docker hub.

`make dockerfile` will produce a generated Dockerfile only

This can then be used in an automated build
