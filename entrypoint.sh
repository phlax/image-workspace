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

copy_skel () {
    relpath="$(realpath --relative-to=/etc/skel "${1}")"
    userpath="/home/$USERNAME/${relpath}"
    if [[ ! -e "$userpath" ]]; then
        cp -a "$1" "$userpath"
        chown $USERNAME:$USERNAME "$userpath"
    fi
}

export -f copy_skel
find /etc/skel -name "*" -exec bash -c 'copy_skel "$0"' {} \;

PROMPT="PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\uspace\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '"
LASTLINE="$(tail -n1 "/home/$USERNAME/.bashrc")"

if [[ ! "$PROMPT" == "$LASTLINE" ]]; then
    echo "$PROMPT" >> "/home/$USERNAME/.bashrc"
fi

cd "/home/${USERNAME}"
gosu "$@"
