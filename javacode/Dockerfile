ARG IMAGE_TAG=stable
FROM vscode:${IMAGE_TAG} AS base

ENV DEBIAN_TARGETS=${DOCKER_TARGETS:-"stable/ testing"}
ARG DOCKER_USER=${DOCKER_USER:-developer}
ARG JAVA_ID=${JAVA_ID:-22}

RUN \
    /run.sh APTinstall \
        ca-certificates-java \
        openjdk-${JAVA_ID}-jdk \
        npm${NPM_DEBIAN_VERSION} \
        nodejs${NODEJS_DEBIAN_VERSION} \
        maven \
        gradle 

COPY files/*.code_extensions /home/${DOCKER_USER}/
RUN /bash_scripts.d/code_extensions.install.sh /home/${DOCKER_USER}/ \
    && /run.sh clean

