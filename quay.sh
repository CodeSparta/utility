#!/bin/bash
read -p "Do you have the quay pull secret (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  mkdir -p $HOME/.docker
  read -sp "Enter quay pull secret: "
  echo "$REPLY" > $HOME/.docker/config.json
  echo "Configured pull secret";
else
  echo "Please refer to https://codectl.io/docs/user-guide/pre-req/ documentation on Quay pull secrets. You can also nagivate to https://cloud.redhat.com/openshift/install/metal/user-provisioned for more information";
fi
