ARGBASH_CMD ?= docker run --rm -v $(shell pwd):/workspace artifactory.corp.code42.com:5000/c42/cloud-workstation argbash

%.sh: %.m4
	$(ARGBASH_CMD) -o $*.sh $*.m4

../scripts/%:  %.sh
	cp $*.sh ../scripts/$*
	chmod 755 ../scripts/$*
