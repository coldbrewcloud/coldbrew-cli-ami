#!/usr/bin/env bash

echo "Copying Source Image ${SOURCE_IMAGE_NAME} (${SOURCE_IMAGE_ID}) in ${SOURCE_REGION} to all other regions"

for REGION_NAME in `cat aws_regions.txt`; do
    IMAGE_ID=$SOURCE_IMAGE_ID
    if [ "${SOURCE_REGION}" != "${REGION_NAME}" ]; then
        echo "Copying Source Image to ${REGION_NAME}"
        IMAGE_ID=`aws ec2 copy-image --region=${REGION_NAME} --name=${SOURCE_IMAGE_NAME} --source-region=${SOURCE_REGION} --source-image-id=${SOURCE_IMAGE_ID} | jq -r .ImageId`

        ## TOOD: have to WAIT until copied image become fully availalbe
        ##  ....
        
        echo "Making ${IMAGE_ID} public"
        aws ec2 modify-image-attribute --image-id ${IMAGE_ID} --launch-permission "{\"Add\": [{\"Group\":\"all\"}]}"
        echo "Tagging ${IMAGE_ID}"
        aws ec2 create-tags --resources ${IMAGE_ID} --tags Key=coldbrew_cli_created,Value=${TS}
    fi
    echo $IMAGE_ID > ecs-ci-ami/default/${REGION_NAME}
done
