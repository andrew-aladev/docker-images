#!/bin/bash
set -e

DIR=$(dirname "${BASH_SOURCE[0]}")
cd "$DIR"

source "../../../utils.sh"
source "./env.sh"

CONTAINER=$(buildah from "$FROM_IMAGE_NAME")
buildah config --label maintainer="$MAINTAINER" "$CONTAINER"

build emerge -ve @world \
  --exclude="sys-devel/gcc sys-devel/binutils sys-libs/musl sys-kernel/linux-headers"

commit