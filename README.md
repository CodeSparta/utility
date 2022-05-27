# oc-mirror

Download your registry.redhat.io pull secret from the Red Hat OpenShift Cluster Manager.
https://console.redhat.com/openshift/install/pull-secret

Make a copy of your pull secret in JSON format:
cat ./pull-secret | jq . > <path>/<pull_secret_file_in_json>  (ex /home/user/.docker/config.json)

Modify the imageset-config.yaml file to include what you need for your install.

Made the init.sh script executable.
chmod +x init.sh

When the init.sh script is finished it generates a move.tar with oc-mirror.tar.gz, openshift-client-linux.tar.gz, openshift-install-linux.tar.gz, and the images from the specified image set.