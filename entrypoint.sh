#!/bin/bash -e

USERNAME="$1"

groupmod -n "$USERNAME" worker
usermod -d "/home/${USERNAME}/" -l "${USERNAME}" worker

if [[ -e /home/worker ]]; then
    rm -rf /home/worker
fi

chown "${USERNAME}:${USERNAME}" "/home/${USERNAME}"

if [[ -e "/home/${USERNAME}/.cache" ]]; then
    chown "${USERNAME}:${USERNAME}" "/home/${USERNAME}/.cache"
fi

cd "/home/${USERNAME}"

gosu "$@"
