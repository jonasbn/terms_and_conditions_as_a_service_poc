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
    --name terms_and_conditions_as_a_service_poc-server \
    terms_and_conditions_as_a_service_poc-server \
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
    --name terms_and_conditions_as_a_service_poc-ci \
    terms_and_conditions_as_a_service_poc-ci \
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
    --name terms_and_conditions_as_a_service_poc-unittest \
    terms_and_conditions_as_a_service_poc-unittest \
    unittest

elif [ "$1" = 'shell' ]; then

    # shell
    docker run \
    --rm \
    --name howismyperl-shell \
    -it terms_and_conditions_as_a_service_poc-server \
    shell

else
    echo "Usage: docker run [ server | ci | unittest | shell ]"
fi

exit $?
