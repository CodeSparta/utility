#!/bin/bash

#Check for config.json
if [[ ! -f  $HOME/.docker/config.json ]] ; then
    echo 'File "config.json" is not there, aborting. Please run quay.sh to configure the pull secret'
    exit
fi

#Run oc-mirror inside the container
podman exec utility  oc-mirror --config=./imageset-config.yaml file://output
#Check for output file
sleep 1
if test -e ./output ; then echo "Download in progress" ; else echo "oc-mirror failed" ; fi

while [ ! -f ./output/mirror_seq* ] ; do echo "Waiting for oc-mirror to finish" && sleep 10 ; done

#Tar up files to move to high side
echo "Archiving files to be moved"
tar cvf ocp-images.tar ./output/mirror_seq*
if test -e ocp-images.tar ; then echo "Archive successful" ; else echo "Archive failed" ; fi
echo "Now transfer ocp-images.tar to high side"
