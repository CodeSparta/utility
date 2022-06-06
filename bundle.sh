#!/bin/bash

podman save -o $HOME/utility/tar-bundles/utility.tar localhost/utility:latest

podman exec utility ansible-playbook /root/utility/roles/utility-bundle/site.yaml

tar -czf utility/tar-bundles/sparta-utility.tar.gz \
utility/ansible-roles \
utility/tar-bundles/utility.tar \
utility/tar-bundles/mirror-registry.tar.gz \
utility/tar-bundles/oc-mirror.tar.gz \
utility/tar-bundles/openshift-client-linux.tar.gz \
utility/tar-bundles/openshift-install-linux.tar.gz \
utility/tar-bundles/openshift-baremetal-install

rm -rf $HOME/utility/ansible-roles/registry \
$HOME/utility/ansible-roles/ocp-install-build-config \
$HOME/utility/tar-bundles/utility.tar \
$HOME/utility/tar-bundles/mirror-registry.tar.gz \
$HOME/utility/tar-bundles/oc-mirror.tar.gz \
$HOME/utility/tar-bundles/openshift-client-linux.tar.gz \
$HOME/utility/tar-bundles/openshift-install-linux.tar.gz \
$HOME/utility/tar-bundles/openshift-baremetal-install
