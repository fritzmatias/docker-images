#! /bin/bash
error(){
    echo "[ERROR] $@" >&2
}
warn(){
    echo "[Warn] $@" >&2
}
info(){
    echo "[info] $@" >&2
}
usage(){
    cat <<EOF
    script to manage environment variables and wrap firebase command

    init        to initialize a firebase direcotry
    start       to start all the emulators
    command     to execute firebase commands directly

EOF
}
#checking npm outdates 
npm -g outdated firebase-tools || warn try to rebuild the image

# https://firebase.google.com/docs/cli?authuser=0#mac-linux-npm
if [ "${GOOGLE_APPLICATION_CREDENTIALS}"x = x ]; then
    info "GOOGLE_APPLICATION_CREDENTIALS env variable usage is recomended. Can be set with google serviceAccountKey.json like
           - GOOGLE_APPLICATION_CREDENTIALS=/home/user/certs/serviceAccountKey.json on your docker compose file"
    firebase login --no-localhost || exit 1
else
    info "To be logged using credentials: $GOOGLE_APPLICATION_CREDENTIALS"
fi

if [ "${FIREBASE_PROJECT_ID}"x = x ]; then 
    firebase projects:list 
    error "environment variable FIREBASE_PROJECT_ID must be set"
    exit 1
else
    info "using firebase project: ${FIREBASE_PROJECT_ID}"
fi

FIREBASE_PROJECT_DIR="${FIREBASE_IMAGE_DIR:-$HOME/firebase}"
FUNCTIONS_DIR=/functions
PUBLIC_DIR=/public
[ $(ls -1a "$FIREBASE_PROJECT_DIR"|wc -l) -eq 2 ] && (cd "$FIREBASE_PROJECT_DIR" && firebase init emulators )

cmd=$1
echo executing ... $cmd
case $cmd in
    init)
        cd "$FIREBASE_PROJECT_DIR" && firebase init emulators
        ;;
    start)
        cd "$FIREBASE_PROJECT_DIR" && info "using firebase path:$FIREBASE_PROJECT_DIR" && firebase --project "${FIREBASE_PROJECT_ID}" emulators:start
        ;;
    command)
        cd "$FIREBASE_PROJECT_DIR" && info "using firebase path:$FIREBASE_PROJECT_DIR" && firebase --project "${FIREBASE_PROJECT_ID}" $@
        ;;
    *)
        usage
esac