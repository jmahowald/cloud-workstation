
REMOTE_NAME ?= genesysarch/cloud-workstation

.PHONY: image push

all: image

image: Dockerfile
	docker build -t cloud-workstation .

tag:
	docker tag cloud-workstation $(REMOTE_NAME)

push: image
	$(MAKE) tag
	docker push $(REMOTE_NAME)


Dockerfile: DockerMake.yml
	./docker-make.sh -n cloud-workstation
	mv docker_makefiles/Dockerfile.cloud-workstation Dockerfile
