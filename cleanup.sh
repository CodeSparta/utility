#!/bin/bash

rm -rf oc-mirror.tar.gz openshift-client-linux.tar.gz  openshift-install-linux.tar.gz output move.tar
podman stop utility
podman rm utility
