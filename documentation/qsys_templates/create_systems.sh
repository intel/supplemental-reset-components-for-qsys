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
	qsys-script \
	quartus_sh \
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
Version 16.0.0 Build 211 04/27/2016 SJ Standard Edition
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
SYSTEMS="
main_subsystem
sync_subsystem
async_subsystem
emif_sys
por_sys
prm_sys
rad_sys
rd_sys
rec_sys
rua_sys
tdas_sys
"

while [ -n "${1}" ] ; do
case "${1}" in

01|create_qsys|all)
set -x

for NEXTFILE in ${SYSTEMS:?}
do

[ -f "${NEXTFILE:?}.qsys" ] && {
	set +x
	echo "ERROR: file already exists"
	exit 1
}

qsys-script \
	--script="./create_qsys_system_${NEXTFILE}.tcl" \
	> "${BUILD_LOGS:?}"/01_create_qsys_system_${NEXTFILE}_log.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }

done
set +x
;;&

02|finale|all)
cat << EOF

Build is complete.

EOF
;;&

clean)
set -x

for NEXTFILE in ${SYSTEMS:?}
do

[ -f "${NEXTFILE:?}.qsys" ] && {
	rm "${NEXTFILE:?}.qsys"
}

done
set +x
;;&

*)
;;
esac
shift
done

exit 0

