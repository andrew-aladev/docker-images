#!/bin/bash
set -e

DIR=$(dirname "${BASH_SOURCE[0]}")
cd "$DIR"

source "../../../utils.sh"
source "./env.sh"

check_up_to_date

CONTAINER=$(buildah from "$FROM_IMAGE_NAME")
buildah config --label maintainer="$MAINTAINER" --arch="arm" "$CONTAINER"

run update
build upgrade \
  --exclude="sys-devel/gcc sys-devel/binutils sys-libs/glibc sys-kernel/linux-headers"
run cleanup

commit