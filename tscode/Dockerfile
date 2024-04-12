ARG IMAGE_TAG=stable
FROM vscode:${IMAGE_TAG} AS base

ARG NODEJS_DEBIAN_VERSION=${NODEJS_DEBIAN_VERSION}
ARG NPM_DEBIAN_VERSION=${NPM_DEBIAN_VERSION}
ARG DOCKER_USER developer


RUN /run.sh APTinstall \
        nodejs${NODE_DEBIAN_VERSION} \
        npm${NPM_DEBIAN_VERSION} 

COPY files/*.code_extensions /home/${DOCKER_USER}/tscode.code_extensions
RUN /bash_scripts.d/code_extensions.install.sh /home/${DOCKER_USER}/ \
    && /run.sh clean
# RUN for e in $(cat /home/${DOCKER_USER}/tscode.extensions|grep -v '#'); do sudo -u ${DOCKER_USER} code --force --install-extension "${e}" ; done;

