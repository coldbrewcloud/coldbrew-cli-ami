#!/usr/bin/env bash

echo "Copying Source Image ${SOURCE_IMAGE_NAME} (${SOURCE_IMAGE_ID}) in ${SOURCE_REGION} to all other regions"

for $REGION_NAME in `cat aws_regions.txt`; do
    IMAGE_ID=$SOURCE_IMAGE_ID
    if [ "${SOURCE_REGION}" -ne "${REGION_NAME}" ]; then
        IMAGE_ID=`aws ec2 copy-image --region=${REGION_NAME} --name=${SOURCE_IMAGE_NAME} --source-region=${SOURCE_REGION} --source-image-id=${SOURCE_IMAGE_ID} | jq -r .ImageId`
    fi
    echo $IMAGE_ID > ecs-ci-ami/default/${REGION_NAME}
done
