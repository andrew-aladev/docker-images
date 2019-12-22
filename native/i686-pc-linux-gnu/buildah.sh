#!/bin/bash
set -e

DIR=$(dirname "${BASH_SOURCE[0]}")
cd "$DIR"

source "../../utils.sh"
source "./env.sh"

CONTAINER=$(buildah from "$FROM_IMAGE_NAME")
buildah config --label maintainer="$MAINTAINER" "$CONTAINER"

run rm -r /usr/share/doc
run rm -r /usr/share/man
run rm -r /usr/share/info

copy root/ /
run env-update

run emerge-webrsync

run eselect profile set default/linux/x86/17.0
run env-update
run source /etc/profile

build emerge -v1 sys-devel/gcc sys-devel/binutils sys-libs/glibc
build emerge -ve @world
build emerge -v app-portage/gentoolkit
build emerge -v clang

run update
build upgrade
run cleanup

run find /etc -maxdepth 1 -name ._cfg* -delete
run eselect news read

commit