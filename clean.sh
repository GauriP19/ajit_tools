#!/usr/bin/env bash

AJIT_HOME="$(pwd)"
PYTHON36_HOME="${AJIT_HOME}/.local/python-3.6.15"
PYTHON_BUILD_ROOT="/tmp/ajit-python36-build"
PYTHON_BUILD_LOG="${AJIT_HOME}/logs/python36-build.log"
PUBLIC_RESOURCES_DIR="${AJIT_HOME}/ajit-processor/AjitPublicResources"

echo "Cleaning build_all.sh outputs from ${AJIT_HOME}"

if [ -d "${PYTHON36_HOME}/bin" ]; then
  export PATH="${PYTHON36_HOME}/bin:${PATH}"
fi

if [ -f "${AJIT_HOME}/ajit_env" ]; then
  cd "${AJIT_HOME}" || exit 1
  source ./ajit_env || exit 1
fi

if [ -x "${PUBLIC_RESOURCES_DIR}/clean.sh" ]; then
  if command -v scons >/dev/null 2>&1; then
    cd "${PUBLIC_RESOURCES_DIR}" || exit 1
    ./clean.sh || exit 1
  else
    echo "Skipping AjitPublicResources/clean.sh because scons is not available"
  fi
fi

cd "${AJIT_HOME}" || exit 1

rm -rf \
  "${PYTHON36_HOME}" \
  "${PYTHON_BUILD_ROOT}" \
  "${PUBLIC_RESOURCES_DIR}/tools/antlr3Cruntime/build" \
  "${PUBLIC_RESOURCES_DIR}/tools/antlr3Cruntime/libantlr3c-3.4" \
  "${AJIT_HOME}/sparc_ctng/crosstool-ng" \
  "${AJIT_HOME}/sparc_ctng/ctng-install" \
  "${AJIT_HOME}/sparc_ctng/work" \
  "${AJIT_HOME}/sparc_ctng/x-tools"

rm -f \
  "${PYTHON_BUILD_LOG}" \
  "${PUBLIC_RESOURCES_DIR}/build.log"

find "${PUBLIC_RESOURCES_DIR}" -name .sconsign.dblite -type f -delete 2>/dev/null || true
rmdir "${AJIT_HOME}/logs" 2>/dev/null || true
rmdir "${AJIT_HOME}/.local" 2>/dev/null || true

echo "Clean complete."
