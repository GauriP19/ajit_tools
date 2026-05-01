#!/usr/bin/env bash

AJIT_HOME="$(pwd)"

PYTHON36_VERSION="3.6.15"
SCONS_VERSION="4.8.1"

# Keep the legacy Python isolated inside this workspace.
INSTALL_ROOT="${AJIT_HOME}/.local"
PYTHON36_HOME="${INSTALL_ROOT}/python-${PYTHON36_VERSION}"
BUILD_ROOT="/tmp/ajit-python36-build"
JOBS="${JOBS:-$(nproc)}"
LOG_DIR="${AJIT_HOME}/logs"
PYTHON_BUILD_LOG="${LOG_DIR}/python36-build.log"

# Download the exact Python release needed by the AJIT build.
PYTHON_TARBALL="Python-${PYTHON36_VERSION}.tgz"
PYTHON_URL="https://www.python.org/ftp/python/${PYTHON36_VERSION}/${PYTHON_TARBALL}"

build_python36() {
  echo "Installing Python ${PYTHON36_VERSION} under ${PYTHON36_HOME}"
  echo "This does not replace or modify the system Python."

  # Install host packages needed to compile Python, native extensions, and
  # the crosstool-NG/AJIT build.
  sudo apt update || return 1
  sudo apt install -y \
    build-essential make curl wget ca-certificates git \
    autoconf automake libtool libtool-bin gperf bison flex \
    texinfo help2man gawk bzip2 unzip patch rsync \
    meson ninja-build python3-dev \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
    libsqlite3-dev libffi-dev libncurses-dev libncursesw5-dev \
    xz-utils tk-dev liblzma-dev || return 1

  # Rebuild the private Python install from scratch. This removes only the
  # temporary build directory and ${AJIT_HOME}/.local/python-${PYTHON36_VERSION};
  # it does not touch the system Python.
  rm -rf "${BUILD_ROOT}" "${PYTHON36_HOME}" || return 1
  mkdir -p "${BUILD_ROOT}" "${INSTALL_ROOT}" || return 1
  cd "${BUILD_ROOT}" || return 1

  # Fetch and unpack the Python source before patching it.
  curl -fL "${PYTHON_URL}" -o "${PYTHON_TARBALL}" || return 1
  tar -xzf "${PYTHON_TARBALL}" || return 1
  cd "Python-${PYTHON36_VERSION}" || return 1

  # Patch Python 3.6 for newer system headers and ctypes behavior.
  sed -i 's/\<sinpi\>/_Py_sinpi/g' Modules/mathmodule.c
  sed -i 's/^\([[:space:]]*\)CFUNCTYPE(c_int)(lambda: None)/\1# Skipped on modern Linux: crashes Python 3.6 ctypes during import./' Lib/ctypes/__init__.py

  # Build the private Python used by the legacy AJIT tools.
  ./configure --prefix="${PYTHON36_HOME}" --without-system-ffi --with-ensurepip=upgrade || return 1
  make -j"${JOBS}" || return 1
  make install || return 1

  # Keep packaging tools within versions that still support Python 3.6.
  "${PYTHON36_HOME}/bin/python3.6" -E -m pip install --upgrade \
    "pip<22" "setuptools<60" "wheel<0.38" || return 1

  "${PYTHON36_HOME}/bin/python3.6" -E -m pip install "SCons==${SCONS_VERSION}" || return 1
  export PATH="${PYTHON36_HOME}/bin:${PATH}"

  "${PYTHON36_HOME}/bin/python3.6" -m pip install "PyYAML<6"


  # Verify the Python install before starting the larger builds.
  "${PYTHON36_HOME}/bin/python3.6" -E --version || return 1
  "${PYTHON36_HOME}/bin/python3.6" -E -c "import ctypes, math, ssl, sqlite3" || return 1
  "${PYTHON36_HOME}/bin/python3.6" -E -m SCons --version || return 1
  "${PYTHON36_HOME}/bin/scons" --version || return 1
  "${PYTHON36_HOME}/bin/python3.6" -c "import yaml; print(yaml.__version__)" || return 1
}

mkdir -p "${LOG_DIR}" || exit 1
echo "Python build log: ${PYTHON_BUILD_LOG}"
build_python36 2>&1 | tee "${PYTHON_BUILD_LOG}"
if [ "${PIPESTATUS[0]}" -ne 0 ]; then
  exit 1
fi
export PATH="${PYTHON36_HOME}/bin:${PATH}"

cd "$AJIT_HOME/sparc_ctng" || exit 1
# The crosstool-NG target name and sparc-linux command aliases come from
# sparc_ctng/configs/ct-ng.defconfig.
./build_toolchain.sh || exit 1

cd "$AJIT_HOME" || exit 1
# Load the paths produced by the Python and toolchain builds.
source ./ajit_env || exit 1

cd "$AJIT_HOME/ajit-processor/AjitPublicResources" || exit 1
# Build the processor models, tools, and public resources.
./build.sh || exit 1

cd "$AJIT_HOME" || exit 1
