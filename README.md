# Gentoo images for software testing.

You can find them on https://hub.docker.com/u/puchuu.

## Goal

GCC and Clang (where possible) with sanitizers for most popular platforms.

## Build

Packages are building using qemu static user, compilation is heavy.
Recommended CPU is any modern one with >= 8 cores.

Please install qemu with `QEMU_USER_TARGETS="aarch64 aarch64_be arm armeb mips mips64 mips64el mipsel mipsn32 mipsn32el"` and start `qemu-binfmt` service.

Than add your local user to `/etc/subuid` and `/etc/subgid`:

```sh
my_user:100000:65536
```

Please ensure that your local user is in `docker` group.

Than open [`env.sh`](env.sh) and update variables.

```sh
./build.sh
```

Build is rootless, just use your regular `my_user`.

## License

MIT
