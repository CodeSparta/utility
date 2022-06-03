FROM registry.access.redhat.com/ubi8/ubi:latest

USER 0
#################################################################################
# DNF Package List
ARG DNF_LIST="\
  vim \
  file \
  wget \
  openssh-server \
  zip \
  python3 \
"

#Ansible pip packages
ARG PIP_LIST="\
  k8s \
  boto \
  boto3 \
  awscli \
  passlib \
  ansible \
  botocore \
  github3.py \
  kubernetes \
"

ARG OCP_LIST="\
  https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux.tar.gz \
  https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/openshift-client-linux.tar.gz \
  https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/oc-mirror.tar.gz \
  https://mirror.openshift.com/pub/openshift-v4/clients/mirror-registry/latest/mirror-registry.tar.gz \
"

#################################################################################
# DNF Install Packages
ARG DNF_FLAGS="\
  -y \
  --setopt=tsflags=nodocs \
  --exclude container-selinux \
  --setopt=install_weak_deps=false \
"
# DNF Update & Install Packages
RUN set -ex                                                                     \
     && dnf install ${DNF_FLAGS} ${DNF_LIST}                                    \
     && dnf clean all                                                           \
    && echo

# PIP install packages
RUN set -ex                                                                     \
     && python3 -m pip install --upgrade pip                                    \
     && pip3 install --upgrade ${PIP_LIST}                                      \
    && echo

#################################################################################
# Copy over OpenShift modules
RUN set -ex \
  && wget ${OCP_LIST}


RUN set -ex \
  && tar xvf openshift-install-linux.tar.gz -C /usr/local/bin \
  && tar xvf openshift-client-linux.tar.gz -C /usr/local/bin \
  && tar xvf oc-mirror.tar.gz -C /usr/local/bin \
  && echo

RUN set -ex \
  && chmod -R +x /usr/local/bin \
 && echo

#################################################################################
# Finalize
RUN mkdir -p /root/.docker
WORKDIR /root/utility
