FROM google/cloud-sdk:alpine as gcloud

ARG DOCKER_USER=${DOCKER_USER:-developer}

RUN adduser "${DOCKER_USER}";echo "${DOCKER_USER}:${DOCKER_USER}" | chpasswd
USER ${DOCKER_USER}
