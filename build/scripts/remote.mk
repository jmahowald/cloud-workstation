
default: .terraform/terraform.tfstate

.terraform:
	terraform get

CUR_DIR_NAME ?= $(notdir $(CURDIR))
LAYER_NAME ?= $CUR_DIR_NAME
.terraform/terraform.tfstate: .terraform
	echo "initialise remote statefile with key $(LAYER_NAME) for project" 
	echo "terraform { backend \"s3\" {} }" > backend.tf && \
	terraform init -backend-config="bucket=$(REMOTE_STATE_BUCKET)" \
	-backend-config="key=$(LAYER_NAME)/terraform.tfstate" \
	-backend-config="region=$(REMOTE_STATE_BUCKET_REGION)" && \
	terraform env select $(ENV_NAME) || terraform env new $(ENV_NAME)
	echo "remote state initialized with $(REMOTE_STATE_BUCKET) and $*" > $@len