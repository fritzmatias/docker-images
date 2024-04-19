LOGDIR=./logs
# sets docker compose v2
[ "$RUN_DOCKER_COMPOSE"x = x ] \
    && docker compose version >/dev/null 2>&1 \
    && RUN_DOCKER_COMPOSE="docker compose" \
    && DEFAULT_DOCKER_OPTIONS="--pull --with-dependencies" \
    && echo using: ${RUN_DOCKER_COMPOSE} 

# sets docker compose v1
[ "$RUN_DOCKER_COMPOSE"x = x ] \
    && docker-compose --version >/dev/null 2>&1 \
    && RUN_DOCKER_COMPOSE="docker-compose" \
    && echo runner: ${RUN_DOCKER_COMPOSE} 

[ "$RUN_DOCKER_COMPOSE"x = x ] && echo "Error: docker compose command not found " >&2 && return 1

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
[ "${opt}"x = x ] && opt="$DEFAULT_DOCKER_OPTIONS"

    echo "Running build with options: $opt for images: $images. Override options via 'export DOCKER_OPTIONS=opt1 opt2'"
    [ "$environment"x != x ] && [ -f "$environment" ] || (echo "file not found: $environment" && exit 1)
    for image in $images; do
    local log="${LOGDIR}/${image}.log"
        ( exp "$environment" >"${log}" \
        && ${RUN_DOCKER_COMPOSE} build  $opt "$image" >>"${log}" \
        && echo "$image done." ) \
        || (echo "Error on: $image check log: $log" && false) || return 2
    done;
        echo y|docker image prune >/dev/null
    }

opt=$1; shift
case $opt in
    env)
        local r=0
        for environment in $@;do
            if [ "$environment"x != x ] && [ -f "$environment" ]; then
                exp "$environment"
            else
              echo "file not found: $environment" && r=1
            fi
        done
        return $r
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