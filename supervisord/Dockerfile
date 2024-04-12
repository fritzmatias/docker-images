ARG IMAGE_TAG=stable
FROM debian_base:${IMAGE_TAG} as base

RUN \
    /run.sh APTinstall \
        supervisor 

COPY ./files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
FROM base as supervisord

