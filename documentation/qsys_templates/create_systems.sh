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

