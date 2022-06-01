FROM registry.access.redhat.com/ubi8/ubi:latest

USER 0

# Package List
ARG DNF_LIST="\
  vim \
  file \
  wget \
  tree \
  openssh-server \
  ansible-core \
  python38 \
  rhel-system-roles \
"

ARG OCP_LIST="\
  https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux.tar.gz \
  https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/openshift-client-linux.tar.gz \
  https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/oc-mirror.tar.gz \
"

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
     && ln /usr/bin/vim /usr/bin/vi                                             \
     && dnf clean all                                                           \
     && rm -rf                                                                  \
          /root/*                                                               \
          /var/cache/*                                                          \
          /var/log/dnf*                                                         \
          /var/log/yum*                                                         \
    && echo

# Copy over OpenShift modules
ENV TMP_DIR = /tmp
RUN wget ${OCP_LIST} ${TMP_DIR}
RUN unzip ${TMP_DIR}/openshift-install-linux.tar.gz && cp openshift-install /usr/local/bin \
  && unzip ${TMP_DIR}/openshift-client-linux.tar.gz && cp oc /usr/local/bin \
  && unzip ${TMP_DIR}/oc-mirror.tar.gz && cp oc-mirror /usr/local/bin \
  && chmod +x /usr/local/bin/

RUN rm -rf ${TMP_DIR}/*

ENTRYPOINT ["/bin/sh"]
WORKDIR /root/utility
