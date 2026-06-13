#!/usr/bin/env bash

CONTAINER_NAME="${CONTAINER_NAME:-ajit-tools-ubuntu22}"

docker start "${CONTAINER_NAME}" >/dev/null
docker exec -it "${CONTAINER_NAME}" bash -lc 'cd /workspace/ajit_tools && bash'
