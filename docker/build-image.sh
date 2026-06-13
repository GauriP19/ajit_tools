#!/usr/bin/env bash

BUILD_CONTEXT="."
LOG_DIR="process_logs"
mkdir -p "${LOG_DIR}"
LOG_FILE="${LOG_DIR}/build-image-$(date -u +%Y%m%dT%H%M%SZ).txt"
exec > >(tee -a "${LOG_FILE}") 2>&1

IMAGE_NAME="${IMAGE_NAME:-ajit-tools-ubuntu22}"
IMAGE_TAG="${IMAGE_TAG:-latest}"
HOST_USER="${HOST_USER:-ajit}"

echo "Log file: ${LOG_FILE}"
echo "Image: ${IMAGE_NAME}:${IMAGE_TAG}"

docker build \
  --build-arg "HOST_UID=$(id -u)" \
  --build-arg "HOST_GID=$(id -g)" \
  --build-arg "HOST_USER=${HOST_USER}" \
  --tag "${IMAGE_NAME}:${IMAGE_TAG}" \
  "${BUILD_CONTEXT}"
