# AJIT Tools

This workspace contains the AJIT/SPARC-V8 processor tools, documentation,
cross-toolchain setup, RTOS code, and validation tests.

For reproducible builds, use the Ubuntu 22.04 Docker setup under `docker/`.
You can also build directly on the host by running `./build_all.sh`, but that
requires sudo privileges to install packages.

## Layout

- `ajit-processor/` - AJIT public processor resources, AHIR release files,
  simulators, debug tools, and processor build scripts.
- `sparc_ctng/` - crosstool-NG based SPARC Linux uClibc toolchain build.
- `os/` - RTOS sources, including CORTOS and CORTOS2.
- `testing/` - examples, validation tests, and temporary test programs.
- `docs/` - architecture, ABI, processor, toolchain, debug, and verification
  documentation.
- `ajit_env` - shell environment setup for AJIT paths, toolchain binaries, and
  runtime libraries.
- `build_all.sh` - top-level build helper for Python 3.6, SCons, the SPARC
  toolchain, and AJIT processor resources.

## Quick Start

From the repository root:

```bash
./build_all.sh
source ./ajit_env
```

`build_all.sh` installs required Ubuntu packages with `apt`, builds a local
Python 3.6.15 under `.local/`, installs SCons, builds the SPARC cross-toolchain
under `sparc_ctng/x-tools/`, and then builds the AjitPublicResources.

For later shells, run:

```bash
source ./ajit_env
```

Clean outputs produced by `build_all.sh`:

```bash
./clean.sh
```

## Ubuntu 22.04 Docker Setup

For the Docker build flow, go into the Docker directory and run the wrapper:

```bash
cd docker
./setup-and-build.sh
```

See `docker/README.md` for the full Docker workflow, post-build container
access, and log locations.

## Building Pieces Manually

Build only the SPARC toolchain:

```bash
cd sparc_ctng
./build_toolchain.sh
```

Build only the AJIT public resources after the environment is set:

```bash
source ./ajit_env
cd ajit-processor/AjitPublicResources
./build.sh
```

## More Documentation

- Toolchain details: `sparc_ctng/README.md`
- Architecture and processor manuals: `docs/`
