#!/bin/bash

podman run -it -d \
--name utility \
-- pull always \
-- volume $HOME/.docker:/root/.docker \
-- volume $HOME/utility/:/root/utility \
localhost/utility:latest
