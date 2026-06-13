# Ubuntu 22.04 Docker Setup for AJIT Tools

This directory builds `ajit_tools` inside an Ubuntu 22.04 Docker container while
keeping the source tree on the host. The repository is bind-mounted into the
container at `/workspace/ajit_tools`, so edits made on the host are visible in
the container and build output remains in the same checkout.

The container user is created with the host UID/GID. Files produced by the AJIT
build should therefore remain editable from the host without `sudo`.

## Build Instructions

Run all commands below from the `docker/` directory:

```bash
cd docker
```

### 1. Install Docker Engine

Install Docker Engine and add the current user to the `docker` group:

```bash
./install-docker-engine.sh
```

The script uses Docker's official Ubuntu apt repository, installs Docker Engine,
creates the `docker` group if needed, and adds your user to that group.

### 2. Log Out And Log Back In

After the install script finishes, log out of the host session and log back in so
the new `docker` group membership takes effect.

As a short-term alternative for the current terminal, you can run:

```bash
newgrp docker
```

Verify Docker works without `sudo`:

```bash
docker info
```

### 3. Build The Image And Run The AJIT Build

Run the setup/build wrapper:

```bash
./setup-and-build.sh
```

This does the full build flow:

1. Verifies Docker is installed and usable by the current user.
2. Builds the `ajit-tools-ubuntu22:latest` image from `Dockerfile`.
3. Starts a persistent container named `ajit-tools-ubuntu22`.
4. Mounts the repository at `/workspace/ajit_tools`.
5. Runs `./build_all.sh` inside the container with `AJIT_SKIP_APT=1`.


If `./setup-and-build.sh` reports that Docker is installed but the current shell
cannot use it yet, log out and back in, or run `newgrp docker`, then rerun:

```bash
./setup-and-build.sh
```

### 4. Open The Existing Container When Needed

After the container exists, open an interactive shell in it with:

```bash
./open-container.sh
```

This starts the existing `ajit-tools-ubuntu22` container if needed and opens a
shell in `/workspace/ajit_tools`.
