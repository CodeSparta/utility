#!/bin/bash

podman run -it -rm -d \
--name utility \
-- pull always \
-- volume $HOME/.docker:/root/.docker \
-- volume $HOME/utility/:/root/utility \
localhost/utility:latest
