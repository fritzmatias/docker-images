LOGDIR=./logs
[ -d $LOGDIR ] || mkdir -p "$LOGDIR"

exp(){
local file=$1;
for var in $(cat "$file" 2>/dev/null|sed -e 's/#.*//g'); do
    echo "exporting $var"
    export $var
done
}

build(){
local environment=$1; shift
local images="$@"
local opt="$DOCKER_OPTIONS"

    echo "Running build with options: $opt for images: $images. Override options via 'export DOCKER_OPTIONS=opt1 opt2'"
    [ "$environment"x != x ] && [ -f "$environment" ] || (echo "file not found: $environment" && exit 1)
    for image in $images; do
    local log="${LOGDIR}/${image}.log"
        ( exp "$environment" >"${log}" \
        && docker-compose build  $opt "$image" >>"${log}" \
        && echo "$image done." ) \
        || (echo "Error on: $image check log: $log" && false) || return 2
    done;
        echo y|docker image prune >/dev/null
    }

opt=$1; shift
case $opt in
    env)
        environment=$1; shift
        [ "$environment"x != x ] && [ -f "$environment" ]  || (echo "file not found: $environment" && exit 1)
        exp "$environment"
    ;;
    build)
        build $@
    ;;
    buildAll)
        images=$(grep '_image:' docker-compose.yml |sed -e 's/://g' ) 
        environment=$1; shift
        echo $images
        build $environment $images
    ;;
esac