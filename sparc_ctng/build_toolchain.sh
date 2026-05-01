#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)" || exit 1

CONFIG_DIR="$SCRIPT_DIR/configs"
CTNG_SRC_DIR="$SCRIPT_DIR/crosstool-ng"
CTNG_INSTALL_DIR="$SCRIPT_DIR/ctng-install"
WORK_DIR="$SCRIPT_DIR/work"

# Install host packages required by crosstool-NG.
"$SCRIPT_DIR/install-ubuntu-deps.sh" || exit 1

# crosstool-NG aborts if LD_LIBRARY_PATH is set.
if [ -n "${LD_LIBRARY_PATH:-}" ]; then
    echo "Warning: unsetting LD_LIBRARY_PATH for crosstool-NG."
    unset LD_LIBRARY_PATH
fi

# Fetch crosstool-NG only when the source tree is missing.
if [ ! -d "$CTNG_SRC_DIR/.git" ]; then
    git clone https://github.com/crosstool-ng/crosstool-ng "$CTNG_SRC_DIR" || exit 1
fi

# Keep generated install and build files out of the source checkout.
mkdir -p "$CTNG_INSTALL_DIR" || exit 1
mkdir -p "$WORK_DIR" || exit 1

# Build and install the local ct-ng command.
cd "$CTNG_SRC_DIR" || exit 1
./bootstrap || exit 1
./configure --prefix="$CTNG_INSTALL_DIR" || exit 1
make || exit 1
make install || exit 1

export PATH="$CTNG_INSTALL_DIR/bin:$PATH"

# Stage the AJIT uClibc configuration beside the ct-ng work files.
cp "$CONFIG_DIR/uClibc-ng-ajit.config" "$WORK_DIR/uClibc-ng-ajit.config" || exit 1

cd "$WORK_DIR" || exit 1
# Generate the final toolchain config and build the SPARC target.
DEFCONFIG="$CONFIG_DIR/ct-ng.defconfig" ct-ng defconfig || exit 1
ct-ng olddefconfig || exit 1
echo "crosstool-NG build log: $WORK_DIR/build.log"
ct-ng build || exit 1
