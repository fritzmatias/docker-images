FROM debian:bookworm-slim as base

ARG DEBIAN_TARGETS=${DEBIAN_TARGETS:-stable}
ARG DOCKER_USER=${DOCKER_USER:-developer}

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_TARGETS=${DEBIAN_TARGETS:-stable}
ENV DOCKER_USER=${DOCKER_USER:-developer}
ENV DOCKER_BASH_SCRIPTS_DIR=${DOCKER_BASH_SCRIPTS_DIR:-/bash_scripts.d/}

COPY files/run.sh /run.sh
COPY files/bash_scripts.d/* "${DOCKER_BASH_SCRIPTS_DIR}"
# COPY files/preferences.d/* /etc/apt/preferences.d/
COPY files/exclude.packages.d/* /etc/apt/preferences.d/
COPY files/sources.list.d/* /etc/apt/sources.list.disable/
COPY files/apt.conf.d/* /etc/apt/apt.conf.d/

RUN /run.sh APTinstall \
        ca-certificates \
        bash \
        sudo \
        vim \
        net-tools 

RUN groupadd -f --gid 999 docker \
 && echo "User:${DOCKER_USER}" \
 && groupadd -f ${DOCKER_USER} \
 && useradd -G docker,video -g ${DOCKER_USER} -m -d /home/${DOCKER_USER} --shell=/usr/bin/bash ${DOCKER_USER} \
 && echo "${DOCKER_USER}:${DOCKER_USER}" | chpasswd --crypt-method SHA512 \
 && adduser ${DOCKER_USER} sudo 


