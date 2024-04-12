ARG IMAGE_TAG=stable
FROM developertools:${IMAGE_TAG} AS base

ARG DOCKER_USER developer

RUN \
    /run.sh APTinstall \
        gpg \
        curl 

RUN curl -sS https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/microsoft.gpg

FROM base AS stage1
COPY --from=base /etc/apt/trusted.gpg.d/* /etc/apt/trusted.gpg.d/

COPY files/*.list /etc/apt/sources.list.d/
RUN \
    /run.sh APTinstall \
        code 

COPY files/*.desktop /etc/xdg/autostart/
COPY files/*.code_extensions /home/${DOCKER_USER}/
COPY files/code_extensions.clean.sh /bash_scripts.d/
COPY files/code_extensions.install.sh /bash_scripts.d/
RUN /bash_scripts.d/code_extensions.install.sh /home/${DOCKER_USER}/ \
    && /run.sh clean
# RUN for e in $(cat /home/${DOCKER_USER}/*.code_extensions|grep -v '#'|sort -u); do sudo -u ${DOCKER_USER} code --install-extension "${e}" ; done;

