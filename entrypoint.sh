#!/bin/bash -e

USERNAME="$1"

groupmod -n "$USERNAME" worker
usermod -d "/home/${USERNAME}/" -l "${USERNAME}" worker

if [[ -e /home/worker ]]; then
    rm -rf /home/worker
fi

cd "/home/${USERNAME}"

gosu "$@"
