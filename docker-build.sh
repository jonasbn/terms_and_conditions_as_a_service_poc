#!/bin/bash

# Enable exit on error
set -e

echo "Building server containers for the following images: '$1'"

if [ "$1" = 'server' ]; then

    # server
    docker build -t terms_and_conditions_as_a_service_poc-server .

elif [ "$1" = 'ci' ]; then

    # ci server
    docker build -t terms_and_conditions_as_a_service_poc-ci .

elif [ "$1" = 'unittest' ]; then

    # unittest
    docker build -t terms_and_conditions_as_a_service_poc-unittest .

elif [ "$1" = 'all' ]; then

    docker build -t terms_and_conditions_as_a_service_poc-server .
    docker build -t terms_and_conditions_as_a_service_poc-ci .
    docker build -t terms_and_conditions_as_a_service_poc-unittest .

else
    echo "Usage: ./docker-build.sh [ server | ci | unittest | all ]"
fi

exit $?
