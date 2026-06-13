#!/usr/bin/env bash

LOG_DIR="process_logs"
mkdir -p "${LOG_DIR}"
LOG_FILE="${LOG_DIR}/install-docker-engine-$(date -u +%Y%m%dT%H%M%SZ).txt"
exec > >(tee -a "${LOG_FILE}") 2>&1

echo "Log file: ${LOG_FILE}"

. /etc/os-release
CODENAME="${VERSION_CODENAME}"
if [ -z "${CODENAME}" ]; then
  echo "Could not detect Ubuntu codename."
  exit 1
fi

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu ${CODENAME} stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

if ! getent group docker >/dev/null; then
  sudo groupadd docker
fi
sudo usermod -aG docker "${USER}"

docker --version
sudo docker run --rm hello-world

echo "Docker is installed. Log out and back in for docker-group membership to apply."
