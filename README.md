# coldbrew-cli-ami

[![Build Status](https://travis-ci.org/coldbrewcloud/coldbrew-cli-ami.svg?branch=master)](https://travis-ci.org/coldbrewcloud/coldbrew-cli-ami)

The default ECS Container Instances AMI image for **coldbrew-cli**.

## Requirements

To build AMI images, you will need [Packer](https://www.packer.io/).

## Instructions

To build the AMI image:

```bash
packer build -var "image_version=`cat VERSION`" packer.json
```

This will build a new AMI image in `us-west-2` region and will copy it to all other ECS-supported regions.
