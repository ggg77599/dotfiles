#! /bin/sh
#
# pushCheck.sh
# Copyright (C) 2019 mrg <mrg@MrGMacBookPro.local>
#
# Distributed under terms of the MIT license.
#


# before push run this script to check

# generate vimrc.mini

# create a docker container
docker run --rm -d -i -t ubuntu:18.04 /bin/bash
docker ps

containerId=$(docker ps --format {{.ID}})

docker cp ~/Development/dotfiles $containerId:/

echo "docker cp ~/Development/dotfiles $containerId:/"
echo "docker exec -i -t $containerId /bin/bash"
echo "docker stop $containerId"

docker exec -i -t $containerId /bin/bash

docker stop $containerId
echo "docker stop $containerId"

# install minimal
# command test

# install basic
# command test

# install developer
# command test

