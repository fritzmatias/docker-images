FROM node:alpine as base
RUN apk add --no-cache \
        ca-certificates \ 
        java-cacerts \
        openjdk21\
    && update-ca-certificates \
    && apk add --no-cache --virtual .build-deps \
        bash \
    && npm install -g \ 
        firebase-tools \
    && npm cache --force clean \
    && firebase setup:emulators:database \
    && firebase setup:emulators:firestore \
    && firebase setup:emulators:pubsub \
    && firebase setup:emulators:storage \
    && firebase setup:emulators:ui \
    && java -version \
    && node --version \
    && npm --version

#https://firebase.google.com/docs/cli?authuser=0#mac-linux-npm
#https://firebase.google.com/docs/emulator-suite/install_and_configure?hl=en&authuser=0#startup