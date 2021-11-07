#!/bin/bash
#
# Copyright (c) 2016-2021 Intel Corporation
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
	qsys-script \
	qsys-generate \
	quartus_sh \
	quartus_map \
	quartus_sta \
	elf2flash \
	nios2-elf-objcopy \
	quartus_cpf \
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
Version 21.1.0 Build 842 10/21/2021 SJ Standard Edition
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

01|create_reset_subsys_qsys|all)
set -x
[ -f reset_subsys.qsys ] && {
	set +x
	echo "ERROR: file already exists"
	exit 1
}
qsys-script \
	--script="scripts/create_reset_subsys_qsys.tcl" \
	> "${BUILD_LOGS:?}"/01_create_reset_subsys_qsys_log.txt 2>&1 \
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
	> "${BUILD_LOGS:?}"/02_create_test_sys_qsys_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

03|qsys-generate|all)
set -x
qsys-generate \
	test_sys.qsys \
	--synthesis=VERILOG \
	--part=5CGXFC5C6F27C7 \
	> "${BUILD_LOGS:?}"/03_qsys-generate_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

04|boot_check|all)
set -x
pushd software/boot_check > /dev/null
./create-this-app \
	> "${BUILD_LOGS:?}"/04_boot_check_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
popd > /dev/null
set +x
;;&

05|create_test_project_top_quartus|all)
set -x
quartus_sh \
	--script="scripts/create_test_project_top_quartus.tcl" \
	> "${BUILD_LOGS:?}"/05_create_test_project_top_quartus_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

06|quartus_map|all)
set -x
quartus_map \
	test_project_top \
	> "${BUILD_LOGS:?}"/06_quartus_map_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

07|quartus_sta|all)
set -x
quartus_sta \
	--script="test_sys/synthesis/submodules/test_sys_ddr_emif_p0_pin_assignments.tcl" \
	test_project_top \
	> "${BUILD_LOGS:?}"/07_quartus_sta_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

08|flow_compile|all)
set -x
quartus_sh \
	--flow compile \
	test_project_top \
	> "${BUILD_LOGS:?}"/08_flow_compile_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
[ -f "${BUILD_LOGS:?}"/08_flow_compile_log.txt ] || {
	echo ""
	echo "ERROR: could not locate log file..."
	echo "'${BUILD_LOGS:?}/08_flow_compile_log.txt'"
	echo ""
	exit 1
}
grep -i "critical warning" "${BUILD_LOGS:?}"/08_flow_compile_log.txt && {
cat << EOF

********************************************************************************
* WARNING: critical warnings reported from flow compile...
********************************************************************************

EOF
} || {
	echo "INFO: no critical warnings reported from flow compile..."
}
;;&

09|finale|all)
cat << EOF

Build is complete.  The files of interest are:

-------------------------------------------------------------------------------
FPGA SOF file:
output_files/test_project_top.sof

Program the SOF file into the FPGA using one of these commands:
[]$ nios2-configure-sof output_files/test_project_top.sof
	or
[]$ quartus_pgm -m jtag -o "p;output_files/test_project_top.sof"

Then you can query the JTAG UART output with:
[]$ nios2-terminal

To reset the target board press the "CPU RESET" push button, or use this command
to reset the Nios II processor and the rest of the target subsystem:
[]$ nios2-download -r -g

-------------------------------------------------------------------------------
SignalTap file:
resets.stp

In the top level project directory there is a SignalTap file that defines the
reset signals that are interesting to observe.  You can open the Quartus project
and then open this SignalTap file to apply the configuration to the design and
recompile it.

-------------------------------------------------------------------------------
System Console scripts:
sys_cnsl/create_sys_cnsl_header.sh
sys_cnsl/sys_cnsl_boot_check.tcl
sys_cnsl/sys_cnsl_dump_jtaguart.tcl
sys_cnsl/sys_cnsl_reset_target.tcl

The sys_cnsl directory contains a few scripts that can be executed in System
Console.  The create_sys_cnsl_header.sh shell script can be run first to create
TCL variables in an include file that the sys_cnsl_boot_check.tcl script will
include.

To use these scripts, program the FPGA and then do this:
[]$ cd sys_cnsl
[]$ ./create_sys_cnsl_header.sh
[]$ system-console
	Then in the System Console window:
% source sys_cnsl_boot_check.tcl
% source sys_cnsl_reset_target.tcl
% source sys_cnsl_dump_jtaguart.tcl


EOF
;;&

*)
;;
esac
shift
done

exit 0

