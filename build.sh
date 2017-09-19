#!/usr/bin/env bash

set -e
RELEASE=$TRAVIS_TAG
BRANCH=$TRAVIS_BRANCH
IMAGE=zenreach/kafka-connect

docker build -t $IMAGE .

if [ "$RELEASE" != "" ]; then
    docker tag ${IMAGE}:latest ${IMAGE}:${RELEASE}
    echo "Pushing Docker Image ..."
    docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
    docker push ${IMAGE}:${RELEASE}
elif [ "$BRANCH" = "master" ]; then
    echo "Pushing Docker Image ..."
    docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
    docker push ${IMAGE}:latest
else
    echo "Not A Release. Not Pushing Docker Image."
fi
