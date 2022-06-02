#!/bin/bash

mkdir -pv $HOME/.docker
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
tar cvzf move.tar oc-mirror.tar.gz openshift-client-linux.tar.gz openshift-install-linux.tar.gz ./output/mirror_seq*
if test -e move.tar ; then echo "Archive successful" ; else echo "Archive failed" ; fi
echo "Now transfer move.tar to high side"
