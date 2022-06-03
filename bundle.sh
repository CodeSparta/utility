#!/bin/bash

podman save -o ${HOME}/tar-bundles/utility.tar localhost/utility:latest

podman exec -d utility  oc-mirror ansible-playbook /root/utility/roles/utility-bundle/site.yaml

tar -czf ${HOME}/tar-bundles/sparta-utility.tar.gz ${HOME}/utility/ansible-roles ${HOME}/tar-bundles/utility.tar
