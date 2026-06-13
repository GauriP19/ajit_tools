# Ubuntu 22.04 Docker Setup for AJIT Tools

This directory keeps the host clean while building `ajit_tools` in an exact
Ubuntu 22.04 userspace. The source tree stays on the host and is bind-mounted
into the container, so VS Code, Vim, git, and normal host tools keep working on
the same files.

The build runs inside Docker as a non-root user with the host UID/GID. Files
created by Python, crosstool-NG, SCons, and AJIT build scripts should therefore
remain editable and deletable from the host without `sudo`.

## Design

1. Install Docker Engine on the Ubuntu host and add the current user to the
   `docker` group.
2. Build an `ubuntu:22.04` image containing all package dependencies needed by
   `build_all.sh`.
3. Start a persistent container with this repository mounted at
   `/workspace/ajit_tools`.
4. Run `./build_all.sh` in the container with `AJIT_SKIP_APT=1`, so dependency
   installation happens only in the image layer and the actual toolchain build
   runs as the non-root mapped user.

## Script Breakdown

- `install-docker-engine.sh`
  Internal helper used by `setup-and-build.sh`. It
  installs Docker Engine from Docker's official Ubuntu apt repository, creates
  the `docker` group if needed, and adds the current user to it.

- `build-image.sh`
  Internal helper used by `setup-and-build.sh`. It builds
  `ajit-tools-ubuntu22:latest` from `Dockerfile` and passes the current host
  UID/GID into the image so the container user matches the host user.

- `setup-and-build.sh`
  User-facing wrapper. It installs or refreshes Docker Engine, verifies the
  user can run Docker, builds the image, starts the persistent container, runs
  the AJIT build, opens an interactive shell, starts the container, or prints
  logs.

- `open-container.sh`
  Post-build helper. It starts the existing container and opens an interactive
  shell at `/workspace/ajit_tools` without reinstalling Docker or rebuilding
  the image.

- `process_logs/`
  Stores timestamped logs from the helper scripts.

## One-command Host Setup and Build

From this directory:

```bash
./setup-and-build.sh
```

If Docker was just installed, the script may stop after adding the user to the
`docker` group. Start a new login shell, or run `newgrp docker`, then run the
same command again.

Open an interactive shell in the container:

```bash
./open-container.sh
```

Start the existing container without running a build:

```bash
./setup-and-build.sh start
```

Print wrapper process logs and Docker container logs:

```bash
./setup-and-build.sh logs
```

The important log locations are:

- `docker/process_logs/*.txt`
- `logs/python36-build.log`
- `sparc_ctng/work/build.log`

## Custom Names

Override image or container names with environment variables:

```bash
IMAGE_NAME=my-ajit-ubuntu22 IMAGE_TAG=test ./setup-and-build.sh
CONTAINER_NAME=my-ajit-container ./setup-and-build.sh start
```
