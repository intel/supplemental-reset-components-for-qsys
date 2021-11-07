#!/bin/sh
#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

#
# This script is used to extract all of the C macro parameters from our custom
# components.  This is required because some of the components do not get
# connected to the data master of the Nios processor, so they are not reported
# in the system.h header that the BSP generator creates.  This also serves as
# an example of how to do this for masters other than the Nios processor in
# general, as that situation can often arise as well.
#

# simple test to see if we were invoked properly
[ ${#:?} -eq 1 ] || {
	echo "" >&2
	echo "USAGE: ${0:?} <SWINFO file input>" >&2
	echo "" >&2
	exit 1
}

# verify that the SWINFO file exists
SWINFO_INPUT_FILE=$(realpath ${1:?})
[ -f "${SWINFO_INPUT_FILE:?}" ] || {
	echo "" >&2
	echo "ERROR: file not found..." >&2
	echo "'${SWINFO_INPUT_FILE:?}'" >&2
	echo "" >&2
	exit 1
}

# test the XML structure we expect "SopcSystem' at the top
COUNT=$(xmllint --xpath "count(SopcSystem)" "${SWINFO_INPUT_FILE:?}") || {
	echo "" >&2
	echo "ERROR: xmllint..." >&2
	echo "" >&2
	exit 1
}

[ ${COUNT:?} -ne "1" ] && {
	echo "" >&2
	echo "ERROR: count(SopcSystem) did not return 1..." >&2
	echo "" >&2
	exit 1
}

# make sure that we have some modules to scan
COUNT=$(xmllint --xpath "count(SopcSystem/module)" "${SWINFO_INPUT_FILE:?}")

[ ${COUNT:?} -lt "1" ] && {
	echo "" >&2
	echo "ERROR: count(SopcSystem/module) did not return 1 or greater..." >&2
	echo "" >&2
	exit 1
}

# get the name of the Qsys system we are analyzing
QSYS_NAME=$(xmllint --xpath "string(SopcSystem/name)" "${SWINFO_INPUT_FILE:?}")

# check to see if the output file exists already
OUTPUT_FILENAME="$(dirname "${SWINFO_INPUT_FILE:?}")/${QSYS_NAME:?}_reset_modules_assignments.h"
[ -f "${OUTPUT_FILENAME:?}" ] && {
	echo "" >&2
	echo "ERROR: output file already exists..." >&2
	echo "'${OUTPUT_FILENAME:?}'" >&2
	echo "" >&2
	exit 1
}

# write the intro header to the output file
echo "#ifndef __${QSYS_NAME^^}_RMA_H_" > "${OUTPUT_FILENAME:?}"
echo "#define __${QSYS_NAME^^}_RMA_H_" >> "${OUTPUT_FILENAME:?}"
echo "" >> "${OUTPUT_FILENAME:?}"

# scan the modules
for MODULE in $(seq 1 ${COUNT:?})
do
	# get the module class name
	CLASSNAME=$(xmllint --xpath "string(SopcSystem/module[${MODULE:?}]/className)" "${SWINFO_INPUT_FILE:?}")

	# only process the module classes that we expect to handle
	case "${CLASSNAME:?}" in
		event_timer | \
		pll_reset_monitor | \
		power_on_reset | \
		reset_assertion_delay | \
		reset_debouncer | \
		reset_event_counter | \
		trivial_default_avalon_slave )

		# get the module name
		NAME=$(xmllint --xpath "string(SopcSystem/module[${MODULE:?}]/name)" "${SWINFO_INPUT_FILE:?}")

		# check to see if we have any assignments to process
		ASSIGNMENT_COUNT=$(xmllint --xpath "count(SopcSystem/module[${MODULE:?}]/assignment)" "${SWINFO_INPUT_FILE:?}")

		[ ${ASSIGNMENT_COUNT:?} -lt "1" ] && {
			echo "" >&2
			echo "ERROR: in module '${MODULE:?}' count(*/assignment) did not return 1 or greater..." >&2
			echo "" >&2
			exit 1
		}

		# write the module preamble
		echo "/*" >> "${OUTPUT_FILENAME:?}"
		echo " * module '${NAME:?}' of type '${CLASSNAME:?}'" >> "${OUTPUT_FILENAME:?}"
		echo " *" >> "${OUTPUT_FILENAME:?}"
		echo " */" >> "${OUTPUT_FILENAME:?}"
		echo "" >> "${OUTPUT_FILENAME:?}"

		# process each assignment
		for ASSIGNMENT_INDEX in $(seq 1 ${ASSIGNMENT_COUNT:?})
		do
			# get the assignment name
			ASSIGNMENT_NAME=$(xmllint --xpath "string(SopcSystem/module[${MODULE:?}]/assignment[${ASSIGNMENT_INDEX:?}]/name)" "${SWINFO_INPUT_FILE:?}")

			# get the assignment value
			ASSIGNMENT_VALUE=$(xmllint --xpath "string(SopcSystem/module[${MODULE:?}]/assignment[${ASSIGNMENT_INDEX:?}]/value)" "${SWINFO_INPUT_FILE:?}")

			# write the C macro for this assignment
			echo "#define RMA_${NAME^^}_${ASSIGNMENT_NAME##*.} (${ASSIGNMENT_VALUE:?})" >> "${OUTPUT_FILENAME:?}"
		done
		echo "" >> "${OUTPUT_FILENAME:?}"
		echo "" >> "${OUTPUT_FILENAME:?}"
	;;
	*)
	;;
	esac
done

# write the trailer
echo "#endif /* __${QSYS_NAME^^}_RMA_H_ */" >> "${OUTPUT_FILENAME:?}"
echo "" >> "${OUTPUT_FILENAME:?}"

echo "Created reset modules assignments header file:"
echo "'${OUTPUT_FILENAME:?}'"

exit 0

