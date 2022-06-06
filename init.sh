#!/bin/bash

read -sp "Enter quay pull secret: "
echo "$REPLY" > $HOME/.docker/config.json

#Obtain baremtal installer
podman exec -d utility oc adm release extract --registry-config /root/.docker/config.json --command openshift-baremetal-install --to tar-bundles quay.io/openshift-release-dev/ocp-release@sha256:a546cd80eae8f94ea0779091e978a09ad47ea94f0769b153763881edb2f5056e


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
