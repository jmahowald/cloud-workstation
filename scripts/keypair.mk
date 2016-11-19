# Big props to https://github.com/kz8s/tack.git
# Trying to do this in terraform sucks


$(DIR_KEY_PAIR)/: ; mkdir -p $@

# I've seen both AWS REGION and AWS_DEFAULT_REGION
# as conventions in environment variables
# this uses the region if defined, otherwise the default region
AWS_REGION ?= $(AWS_DEFAULT_REGION)


$(DIR_KEY_PAIR)/$(AWS_EC2_KEY_NAME).pem: | $(DIR_KEY_PAIR)/
	@aws --region ${AWS_DEFAULT_REGION} ec2 create-key-pair \
		--key-name ${AWS_EC2_KEY_NAME} \
		--query 'KeyMaterial' \
		--output text \
	> $@
	@chmod 400 $@

## create ec2 key-pair
create-keypair: $(DIR_KEY_PAIR)/$(AWS_EC2_KEY_NAME).pem

## delete ec2 key-pair
delete-keypair:
	@aws --region ${AWS_DEFAULT_REGION} ec2 delete-key-pair --key-name ${AWS_EC2_KEY_NAME} || true
	@-rm -rf $(DIR_KEY_PAIR)/

.PHONY: create-keypair delete-keypair
