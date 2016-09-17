#!/bin/bash
#
# Copyright (c) 2016 Intel Corporation
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
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

This example was created and tested with this version of the Altera ACDS tools:

Quartus Prime Shell
Version 15.1.2 Build 193 02/01/2016 SJ Standard Edition
Copyright (C) 1991-2016 Altera Corporation. All rights reserved.

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
	> "${BUILD_LOGS:?}"/02_create_test_sys_qsys_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

03|qsys-generate|all)
set -x
qsys-generate \
	test_sys.qsys \
	--testbench=STANDARD \
	--testbench-simulation=VERILOG \
	--part=5CGXFC5C6F27C7 \
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

