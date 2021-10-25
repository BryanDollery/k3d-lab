NAME=bryan

default: fmt pack

pack:
	time -p docker container run -it --rm \
		--env AWS_PROFILE=labs \
		-v $$PWD/../../../creds:/root/.aws \
		-v $$PWD:/$$(basename $$PWD) \
		--hostname "$$(basename $$PWD)" \
		--name "$$(basename $$PWD)" \
		-w /$$(basename $$PWD) \
		--entrypoint="/usr/local/bin/packer" \
		bryandollery/terraform-packer-aws-alpine:15 build -var="name=${NAME}" packer.pkr.hcl

fmt:
	docker container run -it --rm \
		-v $$PWD:/$$(basename $$PWD) \
		--name "$$(basename $$PWD)" \
		-w /$$(basename $$PWD) \
		--entrypoint="/usr/local/bin/packer" \
		bryandollery/terraform-packer-aws-alpine:15 fmt -var="name=${NAME}" packer.pkr.hcl
