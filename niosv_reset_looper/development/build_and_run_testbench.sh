#!/bin/bash
#
# Copyright (c) 2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

[ ${#} -lt "1" ] && {
cat << EOF

USAGE: $(basename ${0}) <arg> [<arg>] ...

    <arg> may be a specific build stage to execute followed by additional build
          stages to execute.  Or the argument may be "all" to execute all build
          stages.

Typical usage is: '$(basename ${0}) all'

EOF
exit 1
}

set -x
#
# change into the directory of this script
#
cd $(dirname ${0:?})
pwd

#
# setup a build log directory
#
BUILD_LOGS="$(pwd)/build_logs"

[ -d "${BUILD_LOGS:?}" ] || {
	mkdir -p "${BUILD_LOGS:?}"
}

#
# verify that the tools we know we need are available
#
type \
	-P \
	quartus_sh \
	ip-make-ipx \
	qsys-script \
	qsys-generate \
	vsim \
	> "${BUILD_LOGS:?}"/00_tool_check_log.txt 2>&1 \
	|| {
		set +x
		echo ""
		echo "ERROR: could not locate all of the tools we need."
		echo ""
		exit 1
	}

set +x

#
# display the users tool versions
#
cat << EOF

This version of this example was tested with this version of the Intel tools:

Quartus Prime Shell
Version 21.4.0 Build 67 12/06/2021 SC Pro Edition
Copyright (C) 2021  Intel Corporation. All rights reserved.

If your tools are not from this version you may experience build issues related
to those version differences.

Your tool version appears to be:

EOF

quartus_sh \
	--version \
	|| { echo "ERROR" ; exit 1 ; }

echo

#
# build the example
#
while [ -n "${1}" ] ; do
case "${1}" in

01|ip-make-ipx|all)
set -x
[ -f test_component.ipx ] && {
	set +x
	echo "ERROR: file already exists"
	exit 1
}
ip-make-ipx \
	--source-directory=.. \
	--output=test_component.ipx \
	> "${BUILD_LOGS:?}"/01_ip-make-ipx_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

02|create_test_sys_qsys|all)
set -x
[ -f test_sys.qsys ] && {
	set +x
	echo "ERROR: file already exists"
	exit 1
}
qsys-script \
	--script="scripts/create_test_sys_qsys.tcl" \
	--new-quartus-project=test_proj \
	> "${BUILD_LOGS:?}"/02_create_test_sys_qsys_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

03|qsys-generate|all)
set -x
qsys-generate \
	test_sys.qsys \
	--quartus-project=test_proj \
	--testbench=STANDARD \
	--testbench-simulation=VERILOG \
	--part=10AS066N3F40E2SG \
	> "${BUILD_LOGS:?}"/03_qsys-generate_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

04|run_sim_test|all)
set -x
pushd sim_src > /dev/null 2>&1
./run_sim_test.sh \
	> "${BUILD_LOGS:?}"/04_run_sim_test_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
popd > /dev/null 2>&1
set +x
echo "Simulation ran successfully."
;;&

*)
;;
esac
shift
done

exit 0

