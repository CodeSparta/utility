#!/bin/bash

#Checks input for version number, if entering 4.X, it will pull latest-4.X, if entering a more specific version number ex 4.4.4 it will pull 4.4.4
while [[ 1 ]] ; do
    echo -n "Enter a number: "
    read VERSION
    if [[ "$VERSION" = 4.[0-9] ]] || [[ "$VERSION" =~ 4.[0-9][0-9] ]] ; then
        VERSION=latest-$VERSION
        echo "installing $VERSION"
        break
    elif [[ "$VERSION" = 4.*.* ]] || [[ "$VERSION" =~ 4.**.** ]] ; then
        echo "installing $VERSION"
        break
    fi

done

#Run the utility container from the utility image pulled from git
podman run --name utility -d -it -v ${PWD}:/mirror:Z -v ${HOME}/.docker:/root/.docker:Z localhost/utility:latest

#Inside of the container, pull down openshift-install.tar.gz, openshift-client.tar.gz, and oc-mirror
podman exec -d -w /mirror utility curl https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${VERSION}/openshift-install-linux.tar.gz -o openshift-install-linux.tar.gz
podman exec -d -w /mirror utility curl https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/${VERSION}/openshift-client-linux.tar.gz -o openshift-client-linux.tar.gz
podman exec -d -w /mirror utility curl https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/${VERSION}/oc-mirror.tar.gz -o oc-mirror.tar.gz

#check for oc-mirror download to finish
echo "Waiting for oc-mirror to download"
while [ ! -f oc-mirror.tar.gz ] ; do sleep 10 ; done

#Extract oc-mirror.tar.gz to be able to execute oc-mirror in utility container
podman exec -d -w /mirror utility tar xvfz oc-mirror.tar.gz --directory /tmp
sleep 1
podman exec -d -w /mirror utility chmod +x /tmp/oc-mirror
sleep 1
podman exec -d -w /mirror utility mv /tmp/oc-mirror /usr/local/bin

#Run oc-mirror inside the container
podman exec -d -w /mirror utility  oc-mirror --config=./example.yaml file://output

#Check for output file
sleep 1
if test -e ./output ; then echo "Download in progress" ; else echo "Download failed" ; fi

while [ ! -f ./output/mirror_seq* ] ; do echo "Waiting for oc-mirror to finish" && sleep 10 ; done

#Tar up files to move to high side
echo "Archiving files to be moved"
tar cvzf move.tar oc-mirror.tar.gz openshift-client-linux.tar.gz openshift-install-linux.tar.gz ./output/mirror_seq*
if test -e move.tar ; then echo "Archive successful" ; else echo "Archive failed" ; fi
echo "Now transfer move.tar to high side"
