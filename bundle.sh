#!/bin/bash

#Obtain baremtal installer
podman exec -d utility oc adm release extract --registry-config /root/.docker/config.json --command openshift-baremetal-install --to tar-bundles quay.io/openshift-release-dev/ocp-release@sha256:a546cd80eae8f94ea0779091e978a09ad47ea94f0769b153763881edb2f5056e

podman save -o $HOME/utility/tar-bundles/utility.tar localhost/utility:latest

podman exec utility ansible-playbook /root/utility/roles/utility-bundle/site.yaml

tar -czf tar-bundles/sparta-utility.tar.gz \
ansible-roles \
sparta2 \
tar-bundles/utility.tar \
tar-bundles/mirror-registry.tar.gz \
tar-bundles/openshift-client-linux.tar.gz \
tar-bundles/openshift-install-linux.tar.gz \
tar-bundles/openshift-baremetal-install

rm -rf $HOME/utility/ansible-roles/registry \
$HOME/utility/ansible-roles/ocp-install-build-config \
$HOME/utility/tar-bundles/utility.tar \
$HOME/utility/tar-bundles/mirror-registry.tar.gz \
$HOME/utility/tar-bundles/openshift-client-linux.tar.gz \
$HOME/utility/tar-bundles/openshift-install-linux.tar.gz \
$HOME/utility/tar-bundles/openshift-baremetal-install

echo "Now transfer sparta-utility.tar.gz to high side"
