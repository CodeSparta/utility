# Utility
The utility container exists to deploy out the following containerized services in a disconnected environment by utilizing podman.

## Customizable
The build container is meant to run with the latest Openshift packages and latest ansible core versions. To modify Openshift version packages you modify the ARG OCP_LIST in the Dockerfile to point to your specific mirror tar.gz files.

### Services   
  - Ansible
  - Openshift-installer
  - OC command line
  - kubectl
  - oc-mirror
  - mirror-registry
  - awscli

## Build conatiner
On a internet connected box to build the container.

```
git clone https://github.com/CodeSparta/Utility
cd utility/containers/utility
podman build -t utility .
```

### Test or utilize the container

The commands below will start the container locally and allow the user execution into the container. 
```
podman run -d -it --name utility localhost/utility:latest
podman exec -it utility /bin/bash
```
