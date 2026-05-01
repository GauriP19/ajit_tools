#!/usr/bin/env bash
set -e

if ! sudo -v; then
    echo "Warning: sudo permission is not available; skipping Ubuntu dependency install."
    echo "Warning: install the required packages manually if the build fails."
    exit 0
fi

sudo apt-get update
sudo apt-get install -y \
    build-essential \
    gperf \
    bison \
    flex \
    texinfo \
    help2man \
    libncurses-dev \
    python3-dev \
    autoconf \
    automake \
    libtool \
    libtool-bin \
    gawk \
    wget \
    bzip2 \
    xz-utils \
    unzip \
    patch \
    rsync \
    git \
    meson \
    ninja-build \
    ca-certificates
