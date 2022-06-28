#!/bin/bash
podman run -it -d \
--name utility \
--volume ${HOME}/.docker:/root/.docker:z \
--volume ${HOME}/utility/:/root/utility:z \
localhost/utility:latest
