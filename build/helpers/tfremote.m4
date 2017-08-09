#!/bin/bash

#)Created by argbash-init v2.4.1a
# ARG_POSITIONAL_SINGLE([remote-bucket], [Where to store the state information])
# ARG_OPTIONAL_SINGLE([name], n, [the name of the terraform "layer", if you're running this in a docker container, you can supply an enviornmnet variable of CUR_DIR_NAME ], [])
# ARG_OPTIONAL_SINGLE([env], e, [dev/qa/etc], [default])
# ARG_OPTIONAL_SINGLE([remote-bucket-region],r, [what region is the bucket in, defaults to current], [] )
# ARG_OPTIONAL_BOOLEAN([force],f, [whether to force reinitialization of terraform. Useful when switching terraform environments] )

# ARG_HELP([setups terraform remote state bucket and environment in one go])
# ARGBASH_GO

# [ <-- needed because of Argbash



if [[ ! -z $_arg_force ]]; then
MAKE_FORCE=-B
fi


if [[ -z "${_arg_remote_bucket_region// }" ]]; then
echo "Setting bucket region to current default"
_arg_remote_bucket_region=$AWS_DEFAULT_REGION
fi


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set_ENV_NAME=$_arg_env REMOTE_STATE_BUCKET=$_arg_remote_bucket \
    REMOTE_STATE_BUCKET_REGION=$_arg_remote_bucket_region LAYER_NAME=$arg_name make -f $SCRIPT_DIR/remote.mk  $MAKE_FORCE


# ] <-- needed because of Argbash


