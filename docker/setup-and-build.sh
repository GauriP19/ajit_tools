#!/usr/bin/env bash

MODE="${1:-build}"
LOG_DIR="process_logs"
IMAGE_NAME="${IMAGE_NAME:-ajit-tools-ubuntu22}"
IMAGE_TAG="${IMAGE_TAG:-latest}"
CONTAINER_NAME="${CONTAINER_NAME:-ajit-tools-ubuntu22}"
DOCKER_DIR="$(pwd)"
REPO_ROOT="${DOCKER_DIR}/.."

mkdir -p "${LOG_DIR}"
LOG_FILE="${LOG_DIR}/setup-and-build-${MODE}-$(date -u +%Y%m%dT%H%M%SZ).txt"
exec > >(tee -a "${LOG_FILE}") 2>&1

echo "Log file: ${LOG_FILE}"

usage() {
  echo "Usage: ./setup-and-build.sh [build|shell|start|logs]"
}

ensure_docker() {
  ./install-docker-engine.sh

  if ! docker info >/dev/null 2>&1; then
    echo "Docker is installed, but this shell cannot use it as ${USER} yet."
    echo "Log out and back in, or run: newgrp docker"
    exit 1
  fi
}

ensure_image() {
  if ! docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}" >/dev/null 2>&1; then
    ./build-image.sh
  fi
}

start_container() {
  echo "Repository mount: ${REPO_ROOT} -> /workspace/ajit_tools"

  if docker container inspect "${CONTAINER_NAME}" >/dev/null 2>&1; then
    docker start "${CONTAINER_NAME}"
  else
    docker run \
      --detach \
      --init \
      --name "${CONTAINER_NAME}" \
      --volume "${REPO_ROOT}:/workspace/ajit_tools" \
      --workdir /workspace/ajit_tools \
      "${IMAGE_NAME}:${IMAGE_TAG}" \
      sleep infinity
  fi

  docker ps --filter "name=${CONTAINER_NAME}"
}

run_build() {
  docker exec \
    --env AJIT_SKIP_APT=1 \
    "${CONTAINER_NAME}" \
    bash -lc 'cd /workspace/ajit_tools && ./build_all.sh'
}

case "${MODE}" in
  build)
    ensure_docker
    ./build-image.sh
    start_container
    run_build
    ;;
  shell)
    ensure_docker
    ensure_image
    start_container
    docker exec -it "${CONTAINER_NAME}" bash -lc 'cd /workspace/ajit_tools && bash'
    ;;
  start)
    ensure_docker
    ensure_image
    start_container
    ;;
  logs)
    echo "Process logs:"
    find "${LOG_DIR}" -maxdepth 1 -type f -print 2>/dev/null | sort || true

    echo
    echo "Container logs for ${CONTAINER_NAME}:"
    docker logs "${CONTAINER_NAME}"
    ;;
  *)
    usage
    exit 1
    ;;
esac
