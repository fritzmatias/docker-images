ARG IMAGE_TAG=stable
FROM xrdp:${IMAGE_TAG} as base

RUN \
    /run.sh APTinstall \
        postgresql-client \
        default-mysql-client \
        firefox-esr \
        git \
        gitleaks

