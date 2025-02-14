#!/usr/bin/env bash

set -o errexit

base_os="alpine"
base_os_version="3.16.2"
catt_version="v0.12.9"
container=$(buildah from $base_os:$base_os_version)
image_name="gpeavy04/catt"

# Labels
buildah config --label maintainer="garrett.peavy <garrett.peavy@gmail.com>" $container
buildah config --label version=$catt_version $container
buildah config --label repo="github.com/gpeavy/docker-catt" $container

buildah run $container apk add --no-cache python3 py3-pip
buildah run $container python3 -m pip install catt==$catt_version
buildah run $container rm -rf /root/.cache/pip

buildah config --entrypoint catt $container

# Finally saves the running container to an image
buildah commit --format docker $container $image_name:latest
buildah tag $image_name:latest $image_name:$catt_version
