#!/bin/bash

# Enable exit on error
set -e

echo "Attempting to start server in $1 mode (host side)"

if [ "$1" = 'server' ]; then

    # server
    docker run \
    -v $PWD/log:/usr/src/app/log \
    -v $PWD/lib:/usr/src/app/lib \
    -v $PWD/templates:/usr/src/app/templates \
    -v $PWD/public:/usr/src/app/public \
    --rm \
    -e "MOJO_MODE=$MOJO_MODE" \
    -p 3000:3000 \
    --name tac_as_poc-server \
    jonasbn/tac_as_poc \
    server

elif [ "$1" = 'ci' ]; then

    # ci
    docker run \
    -v $PWD/t:/usr/src/app/t \
    -v $PWD/log:/usr/src/app/log \
    -v $PWD/lib:/usr/src/app/lib \
    -v $PWD/templates:/usr/src/app/templates \
    -v $PWD/public:/usr/src/app/public \
    --rm \
    -e "MOJO_MODE=$MOJO_MODE" \
    -e "TEST_VERBOSE=$TEST_VERBOSE" \
    --name tac_as_poc-ci \
    jonasbn/tac_as_poc \
    ci

elif [ "$1" = 'unittest' ]; then

    # unittest
    docker run \
    -v $PWD/t:/usr/src/app/t \
    -v $PWD/log:/usr/src/app/log \
    -v $PWD/lib:/usr/src/app/lib \
    --rm \
    -e "MOJO_MODE=$MOJO_MODE" \
    -e "TEST_VERBOSE=$TEST_VERBOSE" \
    -e "TEST_METHOD=$TEST_METHOD" \
    -it \
    --name tac_as_poc-unittest \
    jonasbn/tac_as_poc \
    unittest

elif [ "$1" = 'shell' ]; then

    # shell
    docker run \
    --rm \
    --name tac_as_poc-shell \
    -it \
    jonasbn/tac_as_poc \
    shell

elif [ "$1" = 'snapshot' ]; then

    # snapshot
    docker create -ti --name tac_as_poc-dummy jonasbn/tac_as_poc bash
    docker cp tac_as_poc-dummy:/usr/src/app/cpanfile.snapshot ./cpanfile.snapshot && \
    docker rm -f tac_as_poc-dummy

else
    echo "Usage: docker run [ server | ci | unittest | shell | snapshot ]"
fi

exit $?
