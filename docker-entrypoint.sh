#!/bin/bash

set -e

echo "Attempting to start server in '$1' mode (container side)"

cd /usr/src/app

if [ "$1" = 'server' ]; then

    carton exec -- perl ./local/bin/morbo \
    --verbose \
    --watch lib \
    --watch script \
    --watch templates \
    --watch public \
    --watch t_a_c.conf \
    --listen http://*:3000 ./script/tac

elif [ "$1" = 'ci' ]; then

    carton exec -- provewatcher \
    --watch lib \
    --watch script \
    --watch templates \
    --watch public \
    --watch t_a_c.conf \
    --run 'prove --lib'

elif [ "$1" = 'unittest' ]; then

    carton exec -- prove \
    --lib --verbose

elif [ "$1" = 'shell' ]; then

    bash -il

else

    carton exec -- perl ./local/bin/morbo \
    --listen http://*:3000 ./script/tac

fi

exit $?
