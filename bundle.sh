#!/bin/bash

podman save -o ${HOME}/utility/tar-bundles/utility.tar localhost/utility:latest

podman exec -d utility  oc-mirror ansible-playbook /root/utility/roles/utility-bundle/site.yaml

tar -czf ${HOME}/utility/tar-bundles/sparta-utility.tar.gz ${HOME}/utility/ansible-roles ${HOME}/utility/tar-bundles/utility.tar
