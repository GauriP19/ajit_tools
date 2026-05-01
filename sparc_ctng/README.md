# SPARC Linux uClibc crosstool-NG Setup

This directory builds the AJIT SPARC-V8 Linux uClibc toolchain using the
configs in `./configs`. The generated toolchain target uses the `ajit` vendor
field, and `sparc-linux` is kept as the command alias.

## Included Files

- `configs/ct-ng.defconfig`: top-level `crosstool-ng` defconfig.
- `configs/uClibc-ng-ajit.config`: external `uClibc-ng` config.
- `install-ubuntu-deps.sh`: installs the Ubuntu packages needed for the build.
- `build_toolchain.sh`: installs Ubuntu dependencies, clones `crosstool-ng` if
  needed, installs `ct-ng` into `./ctng-install`, and builds the toolchain from
  `./work`.

## Build

From this directory, run:

```bash
./build_toolchain.sh
```

The script first runs `./install-ubuntu-deps.sh`. That helper uses
`sudo apt-get` to install host packages. If sudo permission is not available,
it prints a warning, skips dependency installation, and lets the build continue.

The script does the following:

1. Sets `CONFIG_DIR`, `CTNG_SRC_DIR`, `CTNG_INSTALL_DIR`, and `WORK_DIR`
   relative to the script directory.
2. Installs required Ubuntu packages with `./install-ubuntu-deps.sh`.
3. Clones `https://github.com/crosstool-ng/crosstool-ng` into
   `./crosstool-ng` if that checkout does not already exist.
4. Runs `./bootstrap`, `./configure --prefix=./ctng-install`, `make`, and
   `make install` inside the local `crosstool-ng` checkout.
5. Adds `./ctng-install/bin` to `PATH`.
6. Copies `configs/uClibc-ng-ajit.config` into `./work`.
7. Runs `DEFCONFIG=./configs/ct-ng.defconfig ct-ng defconfig`,
   `ct-ng olddefconfig`, and `ct-ng build` from `./work`.
8. Writes the crosstool-NG build log to `./work/build.log`.
9. Installs the completed cross toolchain under `./x-tools`.

After the script runs, the directory layout is:

- `./crosstool-ng`: local `crosstool-ng` source checkout.
- `./ctng-install`: local `ct-ng` installation used by the build.
- `./work`: toolchain build work directory.
- `./work/build.log`: crosstool-NG build log.
- `./x-tools`: generated SPARC cross toolchain.

If you want to restart from scratch, remove `./crosstool-ng`,
`./ctng-install`, `./work`, and `./x-tools`, then run
`./build_toolchain.sh` again.
