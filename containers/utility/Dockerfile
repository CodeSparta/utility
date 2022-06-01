FROM registry.access.redhat.com/ubi8/ubi:latest

ARG VERSION 4.10
USER 0

OCP_PACKAGES https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${VERSION}/openshift-install-linux.tar.gz https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/${VERSION}/openshift-client-linux.tar.gz https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest-4.10/oc-mirror.tar.gz

#Install packages
RUN dnf install --setopt=tsflags=nodocs ansible-core python38 rhel-system-roles -y \
    && dnf clean all

# Copy over OpenShift modules
ENV TMP_DIR = /tmp

RUN wget ${OCP_PACKAGES} ${TMP_DIR}
RUN unzip ${TMP_DIR}/openshift-install-linux.tar.gz && cp openshift-install /usr/local/bin
RUN unzip ${TMP_DIR}/openshift-client-linux.tar.gz && cp oc /usr/local/bin
RUN unzip ${TMP_DIR}/oc-mirror.tar.gz && cp oc-mirror /usr/local/bin
RUN chmod +x /usr/local/bin/

RUN rm -rf ${TMP_DIR}/*
