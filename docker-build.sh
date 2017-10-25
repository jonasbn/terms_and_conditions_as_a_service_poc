#!/bin/bash

# Enable exit on error
set -e

echo "Building server containers for the following images: '$1'"

if [ "$1" = 'server' ]; then

    # server
    docker build -t tac_as_poc-server .

elif [ "$1" = 'ci' ]; then

    # ci server
    docker build -t tac_as_poc-ci .

elif [ "$1" = 'unittest' ]; then

    # unittest
    docker build -t tac_as_poc-unittest .

elif [ "$1" = 'all' ]; then

    docker build -t tac_as_poc-server .
    docker build -t tac_as_poc-ci .
    docker build -t tac_as_poc-unittest .

else
    echo "Usage: ./docker-build.sh [ server | ci | unittest | all ]"
fi

exit $?
