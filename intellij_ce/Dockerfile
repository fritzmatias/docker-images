ARG IMAGE_TAG=stable
FROM developertools:${IMAGE_TAG} as base

ENV DEBIAN_TARGETS=stable\ testing
# ENV DEBIAN_USER=developer
ARG NODEJS_DEBIAN_VERSION=${NODEJS_DEBIAN_VERSION}
ARG NPM_DEBIAN_VERSION=${NPM_DEBIAN_VERSION}
ARG JAVA_ID=22

COPY files/jetbrains.stable.sources /etc/apt/sources.list.disable/
COPY files/jetbrains-ppa-archive-keyring.gpg /usr/share/keyrings/

RUN \
    /run.sh APTinstall \
        ca-certificates-java \
        openjdk-${JAVA_ID}-jdk \
        npm${NPM_DEBIAN_VERSION} \
        nodejs${NODEJS_DEBIAN_VERSION} \
        maven \
        gradle \
        intellij-idea-community  

# https://shape.host/resources/comprehensive-guide-on-installing-sdkman-on-ubuntu-22-04-lts
# RUN \
    # /run.sh update \
    # && apt-get install -y \ 
        # curl \
        # zip \
        # unzip \
    # && /run.sh clean \
    # && echo '#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!'>/home/${USER}/.bash_profile \
    # && echo 'export SDKMAN_DIR="$HOME/.sdkman"'>/home/${USER}/.bash_profile \
    # && echo '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"'>/home/${USER}/.bash_profile \
    # && chown ${USER}:${USER} /home/${USER}/.bash_profile \
    # && cat /home/${USER}/.bash_profile

# RUN sudo -i -u ${USER} curl -s "https://get.sdkman.io" -o sdkman_installer.sh 
# RUN sudo -i -u ${USER} . sdkman_installer.sh 
# RUN sudo -i -u ${USER} cat .bash_profile
# RUN sudo -i -u ${USER} sdk version 
# RUN sudo -i -u ${USER} sdk install java 22-open 
# RUN sudo -i -u ${USER} sdk install gradle
        
COPY files/*.desktop /etc/xdg/autostart/

