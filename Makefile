
REMOTE_NAME ?= joshmahowald/cloud-workstation
IMAGE_NAME ?= cloud-workstation
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

awscli: DockerMake.yml
	./docker-make.sh -n awscli
	docker build -t aws-cli -f docker_makefiles/Dockerfile.awscli  . 

kub-station: DockerMake.yml
	./docker-make.sh -n kub-station
	docker build -t kub -f docker_makefiles/Dockerfile.kub-station  . 
