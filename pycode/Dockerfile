ARG IMAGE_TAG=stable
FROM vscode:${IMAGE_TAG} AS base

ENV DEBIAN_TARGETS stable/ testing
ARG DOCKER_USER=developer


RUN \
    /run.sh APTinstall \
        python3 \
        python3-pip \
        python3-virtualenvwrapper 

COPY files/*.code_extensions /home/${DOCKER_USER}/
RUN /bash_scripts.d/code_extensions.install.sh /home/${DOCKER_USER}/ \
    && /run.sh clean

