#!/bin/bash

# Enable exit on error
set -e

docker build -t tac_as_poc .

exit $?
