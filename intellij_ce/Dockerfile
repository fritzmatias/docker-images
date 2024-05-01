ARG IMAGE_TAG=stable
FROM javacode:${IMAGE_TAG} as base

ENV DEBIAN_TARGETS=stable\ testing
ARG NODEJS_DEBIAN_VERSION=${NODEJS_DEBIAN_VERSION}
ARG NPM_DEBIAN_VERSION=${NPM_DEBIAN_VERSION}
ARG JAVA_ID=22

COPY files/jetbrains.stable.sources /etc/apt/sources.list.disable/
COPY files/jetbrains-ppa-archive-keyring.gpg /usr/share/keyrings/

RUN \
    /run.sh APTinstall \
        intellij-idea-community  

        
COPY files/*.desktop /etc/xdg/autostart/
RUN \
    chmod 777 /usr/lib/jvm \
    && ln -s /usr/lib/jvm /home/${DOCKER_USER}/.jdks
