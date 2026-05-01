#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)" || exit 1
CWD="$SCRIPT_DIR"
LOG_FILE="$CWD/build.log"

# Keep one build log beside this script while still printing progress.
exec > >(tee "$LOG_FILE") 2>&1
cd "$CWD" || exit 1
echo "AJIT public resources build log: $LOG_FILE"

# build the tools
echo "build tools";
cd tools;
scons;
cd $CWD;
# build test-environments
echo "build processor/TestEnvironments"
cd processor/TestEnvironments;
scons;
cd $CWD;
# the C reference model testbench.
source reference_C_model_exports.sh;
cd processor/C_reference_model/;
echo "build processor/C_reference_model";
scons;
cd -;
# the 64-bit C reference model testbench.
source reference_64bit_C_model_exports.sh;
cd processor/64bit/C_multi_core_multi_thread/;
echo "build processor/64bit/C_multi_core_multi_thread/";
scons;
cd $CWD
# ajit_debug_monitor_mt.
echo "build tools/ajit_debug_monitor_mt";
cd tools/ajit_debug_monitor_mt;
scons;
cd $CWD;
# ajit_debug_monitor.
echo "build tools/ajit_debug_monitor";
cd tools/ajit_debug_monitor;
scons;
cd $CWD;
# ajit_access_routines_mt (libajit*.a).
echo "build tools/ajit_access_routines_mt";
cd tools/ajit_access_routines_mt;
./build_lib.sh alt
./build_lib.sh default
cd $CWD;
