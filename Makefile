VERSION := $(shell cat VERSION)

build:
	packer build -var "image_version=$(VERSION)" packer.json

.PHONY: build
