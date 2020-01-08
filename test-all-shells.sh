#!/bin/sh

set -e

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
    shellspec --shell "$shell" --no-kcov
done
