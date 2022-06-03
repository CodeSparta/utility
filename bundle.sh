#!/bin/bash

podman save -o ${HOME}/tar-bundles/utility.tar localhost/utility:latest

tar -czf ${HOME}/tar-bundles/sparta-utility.tar.gz ${HOME}/utility/ansible-roles ${HOME}/tar-bundles/utility.tar
