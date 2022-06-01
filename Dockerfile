FROM registry.access.redhat.com/ubi8/ubi:latest

USER 0

RUN dnf install ansible-core python38 rhel-system-roles bind nginx podman -y \
    && dnf clean all
#rhel system roles
