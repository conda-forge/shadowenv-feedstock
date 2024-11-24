#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

export CARGO_PROFILE_RELEASE_STRIP=symbols
export CARGO_PROFILE_RELEASE_LTO=fat

# check licenses
cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY.yml

# build statically linked binary with Rust
cargo install --bins --no-track --locked --root ${PREFIX} --path .
mkdir -p ${PREFIX}/share/man/man1
mkdir -p ${PREFIX}/share/man/man5
install -m 644 man/man1/shadowenv.1 ${PREFIX}/share/man/man1/shadowenv.1
install -m 644 man/man5/shadowlisp.5 ${PREFIX}/share/man/man5/shadowlisp.5
