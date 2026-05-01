# SPARC Linux uClibc crosstool-NG Setup

This directory builds the AJIT SPARC-V8 Linux uClibc toolchain using the
configs in `./configs`. The generated toolchain target uses the `ajit` vendor
field, and `sparc-linux` is kept as the command alias.

## Included Files

- `configs/ct-ng.defconfig`: top-level `crosstool-ng` defconfig.
- `configs/uClibc-ng-ajit.config`: external `uClibc-ng` config.
- `build_toolchain.sh`: clones `crosstool-ng` if needed, installs `ct-ng` into
  `./ctng-install`, and builds the toolchain from `./work`.

## Build

From this directory, run:

```bash
./build_toolchain.sh
```

The script does the following:

1. Sets `CONFIG_DIR`, `CTNG_SRC_DIR`, `CTNG_INSTALL_DIR`, and `WORK_DIR`
   relative to the script directory.
2. Clones `https://github.com/crosstool-ng/crosstool-ng` into
   `./crosstool-ng` if that checkout does not already exist.
3. Runs `./bootstrap`, `./configure --prefix=./ctng-install`, `make`, and
   `make install` inside the local `crosstool-ng` checkout.
4. Adds `./ctng-install/bin` to `PATH`.
5. Copies `configs/uClibc-ng-ajit.config` into `./work`.
6. Runs `DEFCONFIG=./configs/ct-ng.defconfig ct-ng defconfig`,
   `ct-ng olddefconfig`, and `ct-ng build` from `./work`.
7. Writes the crosstool-NG build log to `./work/build.log`.
8. Installs the completed cross toolchain under `./x-tools`.

After the script runs, the directory layout is:

- `./crosstool-ng`: local `crosstool-ng` source checkout.
- `./ctng-install`: local `ct-ng` installation used by the build.
- `./work`: toolchain build work directory.
- `./work/build.log`: crosstool-NG build log.
- `./x-tools`: generated SPARC cross toolchain.

If you want to restart from scratch, remove `./crosstool-ng`,
`./ctng-install`, `./work`, and `./x-tools`, then run
`./build_toolchain.sh` again.
