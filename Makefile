
image:
	./docker-make.sh cloud-workstation

dockerfile: Dockerfile
	
Dockerfile: DockerMake.yml
	./docker-make.sh -n cloud-workstation
	mv docker_makefiles/Dockerfile.cloud-workstation Dockerfile
