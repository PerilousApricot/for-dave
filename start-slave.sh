#!/bin/bash
set -x

echo "For dave"
# Downgrade docker client
IMAGE="melo-docker-image"
docker build -t ${IMAGE} .

dir_name="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir -p ${dir_name}/slave/job
echo "Chutney rules" > ${dir_name}/slave/job/README

docker pull "${IMAGE}"
HOST_VOLUME_PATH="${dir_name}/slave"
CONTAINER_VOLUME_PATH=/tmp/slave
which docker

echo "Start build slave (Will run job inside)"
docker run --name dave-jenkins-slave \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "${HOST_VOLUME_PATH}:${CONTAINER_VOLUME_PATH}" \
    -e "HOST_VOLUME_PATH=${HOST_VOLUME_PATH}" \
    -e "CONTAINER_VOLUME_PATH=${CONTAINER_VOLUME_PATH}" \
    -w "${CONTAINER_VOLUME_PATH}" \
    "${IMAGE}" \
    ./start-job.sh
