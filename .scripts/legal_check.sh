#!/bin/bash
#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

BRIEF=0
HELP=0

[ $# -gt 0 ] && {
	case "${1}" in
	
	-b|--brief)
		BRIEF=1
		;;
		
	-h|--help)
		HELP=1
		;;
		
	*)
		HELP=1
		;;

	esac
}

[ "${HELP:?}" -eq 1 ] && {
	echo ""
	echo "USAGE: $(basename $0) [option]"
	echo "    -h, --help  : displays this help message"
	echo "    -b, --brief : suppress file names from output"
	echo ""
	exit 1	
}

cd $(dirname $0)

GREP_PATTERNS_FILE="./grep_patterns.shinc"

[ -f "${GREP_PATTERNS_FILE:?}" ] || {
	echo ""
	echo "ERROR: cannot locate grep patterns file"
	echo "'${GREP_PATTERNS_FILE:?}'"
	echo ""
	exit 1
}

. ${GREP_PATTERNS_FILE:?}

SCRIPT_DIR="$(pwd)"
OUTPUT_FILE="${SCRIPT_DIR:?}/repo_legal_check.txt"

[ -f "${OUTPUT_FILE:?}" ] && {
	echo ""
	echo "ERROR: output file already exists"
	echo "'${OUTPUT_FILE:?}'"
	echo ""
	exit 1
}

TEMP_LICENSE_FILE=$(mktemp --tmpdir --suffix=.txt license-XXXX)

[ -f "${TEMP_LICENSE_FILE:?}" ] || {
	echo ""
	echo "ERROR: could not create temp license file"
	echo ""
	exit 1
}

TEMP_DATA_FILE=$(mktemp --tmpdir --suffix=.txt data-XXXX)

[ -f "${TEMP_DATA_FILE:?}" ] || {
	echo ""
	echo "ERROR: could not create temp data file"
	echo ""
	rm "${TEMP_LICENSE_FILE:?}"
	exit 1
}

cd ..

check_license_and_copyright () {
FILE_COUNT=0
LICENSE_ERRORS=0
COPYRIGHT_ERRORS=0

while read NEXT_FILE
do
	[ "${BRIEF:?}" -eq 0 ] && {
		echo "${NEXT_FILE:?}" | tee -a "${OUTPUT_FILE:?}"
	}
	
	# Extract and verify the license body
	sed -e "${LICENSE_START_LINE:?}! d" "${NEXT_FILE:?}" \
	> "${TEMP_DATA_FILE:?}"
	diff -q "${TEMP_DATA_FILE:?}" "${TEMP_LICENSE_FILE:?}" \
	> /dev/null 2>&1 || {
		echo "ERROR: during license check" | tee -a "${OUTPUT_FILE:?}"
		echo "'${NEXT_FILE:?}'" | tee -a "${OUTPUT_FILE:?}"
		((LICENSE_ERRORS++))
	}

	# Extract and verify the copyright line
	sed -e "${COPYRIGHT_START_LINE:?}! d" "${NEXT_FILE:?}" \
	> "${TEMP_DATA_FILE:?}"
	grep -q -e "${COPYRIGHT_PATTERN:?}" \
	"${TEMP_DATA_FILE:?}" \
	> /dev/null 2>&1 || {
		echo "ERROR: during copyright check" | tee -a "${OUTPUT_FILE:?}"
		echo "'${NEXT_FILE:?}'" | tee -a "${OUTPUT_FILE:?}"
		((COPYRIGHT_ERRORS++))
	}
	
	((FILE_COUNT++))
done < <(\
	find -type 'f' | \
	sort | \
	grep -v -e "${GREP_GIT_DIR:?}" | \
	grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
	grep -e "${FILES_TO_FIND:?}" )

echo "" | tee -a "${OUTPUT_FILE:?}"
echo "${FILE_COUNT:?} files examined" | tee -a "${OUTPUT_FILE:?}"
echo "${LICENSE_ERRORS:?} license errors" | tee -a "${OUTPUT_FILE:?}"
echo "${COPYRIGHT_ERRORS:?} copyright errors" | tee -a "${OUTPUT_FILE:?}"
echo "" | tee -a "${OUTPUT_FILE:?}"
}

#-------------------------------------------------------------------------------
# store a hash based license in the temp license file
cat << EOF > "${TEMP_LICENSE_FILE:?}"
# SPDX-License-Identifier: MIT-0
EOF

#-------------------------------------------------------------------------------
# Process all TCL files in repo
echo "### Checking TCL files:" | tee -a "${OUTPUT_FILE:?}"

LICENSE_START_LINE=4
COPYRIGHT_START_LINE=2
COPYRIGHT_PATTERN="# Copyright (c) [-0-9]* Intel Corporation"
FILES_TO_FIND="${GREP_TCL_FILES:?}"
check_license_and_copyright

#-------------------------------------------------------------------------------
# Process all SDC files in repo
echo "### Checking SDC files:" | tee -a "${OUTPUT_FILE:?}"

LICENSE_START_LINE=4
COPYRIGHT_START_LINE=2
COPYRIGHT_PATTERN="# Copyright (c) [-0-9]* Intel Corporation"
FILES_TO_FIND="${GREP_SDC_FILES:?}"
check_license_and_copyright

#-------------------------------------------------------------------------------
# Process all DO files in repo
echo "### Checking DO files:" | tee -a "${OUTPUT_FILE:?}"

LICENSE_START_LINE=4
COPYRIGHT_START_LINE=2
COPYRIGHT_PATTERN="# Copyright (c) [-0-9]* Intel Corporation"
FILES_TO_FIND="${GREP_DO_FILES:?}"
check_license_and_copyright

#-------------------------------------------------------------------------------
# Process all create-this files in repo
echo "### Checking create-this files:" | tee -a "${OUTPUT_FILE:?}"

LICENSE_START_LINE=5
COPYRIGHT_START_LINE=3
COPYRIGHT_PATTERN="# Copyright (c) [-0-9]* Intel Corporation"
FILES_TO_FIND="${GREP_CREATE_THIS_FILES:?}"
check_license_and_copyright

#-------------------------------------------------------------------------------
# Process all SH files in repo
echo "### Checking SH files:" | tee -a "${OUTPUT_FILE:?}"

LICENSE_START_LINE=5
COPYRIGHT_START_LINE=3
COPYRIGHT_PATTERN="# Copyright (c) [-0-9]* Intel Corporation"
FILES_TO_FIND="${GREP_SH_FILES:?}"
check_license_and_copyright

#-------------------------------------------------------------------------------
# store a C based license in the temp license file
cat << EOF > "${TEMP_LICENSE_FILE:?}"
 * SPDX-License-Identifier: MIT-0
EOF

#-------------------------------------------------------------------------------
# Process all C files in repo
echo "### Checking C files:" | tee -a "${OUTPUT_FILE:?}"

LICENSE_START_LINE=4
COPYRIGHT_START_LINE=2
COPYRIGHT_PATTERN=" \* Copyright (c) [-0-9]* Intel Corporation"
FILES_TO_FIND="${GREP_C_FILES:?}"
check_license_and_copyright

#-------------------------------------------------------------------------------
# Process all H files in repo
echo "### Checking H files:" | tee -a "${OUTPUT_FILE:?}"

LICENSE_START_LINE=4
COPYRIGHT_START_LINE=2
COPYRIGHT_PATTERN=" \* Copyright (c) [-0-9]* Intel Corporation"
FILES_TO_FIND="${GREP_H_FILES:?}"
check_license_and_copyright

#-------------------------------------------------------------------------------
# Process all SV files in repo
echo "### Checking SV files:" | tee -a "${OUTPUT_FILE:?}"

LICENSE_START_LINE=4
COPYRIGHT_START_LINE=2
COPYRIGHT_PATTERN=" \* Copyright (c) [-0-9]* Intel Corporation"
FILES_TO_FIND="${GREP_SV_FILES:?}"
check_license_and_copyright

#-------------------------------------------------------------------------------
# Process all V files in repo
echo "### Checking V files:" | tee -a "${OUTPUT_FILE:?}"

LICENSE_START_LINE=4
COPYRIGHT_START_LINE=2
COPYRIGHT_PATTERN=" \* Copyright (c) [-0-9]* Intel Corporation"
FILES_TO_FIND="${GREP_V_FILES:?}"
check_license_and_copyright

#-------------------------------------------------------------------------------
# store an XML based license in the temp license file
cat << EOF > "${TEMP_LICENSE_FILE:?}"
SPDX-License-Identifier: MIT-0
EOF

#-------------------------------------------------------------------------------
# Process all STP files in repo
echo "### Checking STP files:" | tee -a "${OUTPUT_FILE:?}"

LICENSE_START_LINE=4
COPYRIGHT_START_LINE=2
COPYRIGHT_PATTERN="Copyright (c) [-0-9]* Intel Corporation"
FILES_TO_FIND="${GREP_STP_FILES:?}"
check_license_and_copyright

#-------------------------------------------------------------------------------
# Process all IPX files in repo
echo "### Checking IPX files:" | tee -a "${OUTPUT_FILE:?}"

LICENSE_START_LINE=4
COPYRIGHT_START_LINE=2
COPYRIGHT_PATTERN="Copyright (c) [-0-9]* Intel Corporation"
FILES_TO_FIND="${GREP_IPX_FILES:?}"
check_license_and_copyright

#-------------------------------------------------------------------------------
# store a percent based license in the temp license file
cat << EOF > "${TEMP_LICENSE_FILE:?}"
% SPDX-License-Identifier: MIT-0
EOF

#-------------------------------------------------------------------------------
# Process all TEX files in repo
echo "### Checking TEX files:" | tee -a "${OUTPUT_FILE:?}"

LICENSE_START_LINE=4
COPYRIGHT_START_LINE=2
COPYRIGHT_PATTERN="% Copyright (c) [-0-9]* Intel Corporation"
FILES_TO_FIND="${GREP_TEX_FILES:?}"
check_license_and_copyright


rm "${TEMP_LICENSE_FILE:?}"
rm "${TEMP_DATA_FILE:?}"

