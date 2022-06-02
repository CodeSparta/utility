#!/bin/bash

read -sp "Enter quay pull secret: "
echo "$REPLY" > $HOME/.docker/config.json

#Run oc-mirror inside the container
podman exec -d utility  oc-mirror --config=./imageset-config.yaml file://output
#Check for output file
sleep 1
if test -e ./output ; then echo "Download in progress" ; else echo "oc-mirror failed" ; fi

while [ ! -f ./output/mirror_seq* ] ; do echo "Waiting for oc-mirror to finish" && sleep 10 ; done

#Tar up files to move to high side
echo "Archiving files to be moved"
cp ./output/mirror_seq* ocp-images.tar
if test -e ocp-images.tar ; then echo "Archive successful" ; else echo "Archive failed" ; fi
echo "Now transfer ocp-images.tar to high side"
