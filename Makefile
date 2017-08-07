
REMOTE_NAME ?= joshmahowald/cloud-workstation

IMAGE_NAME ?= cloud-workstation
SCAFFOLD_CMD ?= docker run -v $(shell pwd):/workspace $(DOCKER_REMOTE_BASE)cloud-workstation scaffolding

.PHONY: image push

all: image

image: Dockerfile
	docker build -t $(IMAGE_NAME)  .

tag:
	docker tag  $(IMAGE_NAME) $(REMOTE_NAME)

push: image
	$(MAKE) tag
	docker push $(REMOTE_NAME)


Dockerfile: DockerMake.yml
	./docker-make.sh -n cloud-workstation
	mv docker_makefiles/Dockerfile.cloud-workstation Dockerfile

cloud-workstation.sh: image
	$(SCAFFOLD_CMD) dockerscript -v $(VOLUMES) -e $(ENV_VARS) -w /workspace $(DOCKER_REMOTE_BASE)$(IMAGE_NAME)
	chmod 755 cloud-workstation.sh