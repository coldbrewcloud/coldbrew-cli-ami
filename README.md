# coldbrew-cli-ami

The default ECS Container Instances AMI image for **coldbrew-cli**.

## Requirements

To build AMI images, you will need [Packer](https://www.packer.io/).

## Instructions

To build the AMI image:

```bash
packer build packer.json
```

This will build a new AMI image in `us-west-2` region and will copy it to all other ECS-supported regions.
