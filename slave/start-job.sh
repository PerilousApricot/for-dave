#!/bin/bash
set -x

echo "For dave (inside job)"
IMAGE="evansde77/py_ci_image"
env | grep PATH
dir_name="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "host ${HOST_VOLUME_PATH} cont $CONTAINER_VOLUME_PATH"
# Slave relative is the path ON THE HOST
SLAVE_RELATIVE="${HOST_VOLUME_PATH}/$(readlink -f $CONTAINER_VOLUME_PATH/$(pwd)/job)"

echo "Start build slave (Will run job inside)"
docker run --name dave-jenkins-job \
    -v "${SLAVE_RELATIVE}/job:${CONTAINER_VOLUME_PATH}" \
    "${IMAGE}" \
    cat ${CONTAINER_VOLUME_PATH}/README
