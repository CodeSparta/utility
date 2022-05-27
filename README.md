# oc-mirror

Download your registry.redhat.io pull secret from the Red Hat OpenShift Cluster Manager.
https://console.redhat.com/openshift/install/pull-secret

Make a copy of your pull secret in JSON format:
cat ./pull-secret | jq . > <path>/<pull_secret_file_in_json>  (ex /home/user/.docker/config.json)

chmod 
