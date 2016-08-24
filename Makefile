
REMOTE_NAME ?= genesysarch/cloud-workstation
image:
	./docker-make.sh cloud-workstation


push:
	docker tag cloud-workstation $(REMOTE_NAME)
	docker push $(REMOTE_NAME)

dockerfile: Dockerfile

Dockerfile: DockerMake.yml
	./docker-make.sh -n cloud-workstation
	mv docker_makefiles/Dockerfile.cloud-workstation Dockerfile
