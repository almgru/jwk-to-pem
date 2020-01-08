#!/bin/sh

set -e

SEED="$(shuf -i 0-65535 -n 1)"
printf "Using seed: %s\n\n" "$SEED"

for shell in \
    /bin/bash \
    '/bin/busybox sh' \
    /bin/dash \
    /bin/ksh \
    /bin/mksh \
    /bin/posh \
    /bin/yash \
    /bin/zsh\
    ; do
    shellspec --random examples:"$SEED" --shell "$shell" --no-kcov
done
