#!/bin/bash
#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

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
OUTPUT_FILE="${SCRIPT_DIR:?}/repo_file_list.txt"

[ -f "${OUTPUT_FILE:?}" ] && {
	echo ""
	echo "ERROR: output file already exists"
	echo "'${OUTPUT_FILE:?}'"
	echo ""
	exit 1
}

cd ..

echo "### C files in repo:" | tee "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_C_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### create-this files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_CREATE_THIS_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### DO files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_DO_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### H files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_H_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### IPX files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_IPX_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### LICENSE files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_LICENSE_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### PNG files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_PNG_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### README files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_README_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### SDC files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_SDC_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### SH files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_SH_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### STP files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_STP_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### SV files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_SV_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### TCL files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_TCL_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### TEX files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_TEX_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### V files in repo:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_V_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### Files not matched by any grep pattern:" | tee -a "${OUTPUT_FILE:?}"

find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -v -e "${GREP_C_FILES:?}" | \
grep -v -e "${GREP_CREATE_THIS_FILES:?}" | \
grep -v -e "${GREP_DO_FILES:?}" | \
grep -v -e "${GREP_H_FILES:?}" | \
grep -v -e "${GREP_IPX_FILES:?}" | \
grep -v -e "${GREP_LICENSE_FILES:?}" | \
grep -v -e "${GREP_PNG_FILES:?}" | \
grep -v -e "${GREP_README_FILES:?}" | \
grep -v -e "${GREP_SDC_FILES:?}" | \
grep -v -e "${GREP_SH_FILES:?}" | \
grep -v -e "${GREP_STP_FILES:?}" | \
grep -v -e "${GREP_SV_FILES:?}" | \
grep -v -e "${GREP_TCL_FILES:?}" | \
grep -v -e "${GREP_TEX_FILES:?}" | \
grep -v -e "${GREP_V_FILES:?}" | \
tee -a "${OUTPUT_FILE:?}"

echo "" | tee -a "${OUTPUT_FILE:?}"

