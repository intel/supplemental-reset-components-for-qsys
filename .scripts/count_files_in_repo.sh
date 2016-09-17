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
OUTPUT_FILE="${SCRIPT_DIR:?}/repo_file_count.txt"

[ -f "${OUTPUT_FILE:?}" ] && {
	echo ""
	echo "ERROR: output file already exists"
	echo "'${OUTPUT_FILE:?}'"
	echo ""
	exit 1
}

cd ..

TOTAL_COUNT=0

echo "### C files in repo:" | tee "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_C_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### create-this files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_CREATE_THIS_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### DO files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_DO_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### H files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_H_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### IPX files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_IPX_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### LICENSE files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_LICENSE_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### PNG files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_PNG_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### README files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_README_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### SDC files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_SDC_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### SH files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_SH_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### STP files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_STP_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### SV files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_SV_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### TCL files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_TCL_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### TEX files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_TEX_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### V files in repo:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
grep -e "${GREP_V_FILES:?}" | \
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

echo "### Files not matched by any grep pattern:" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
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
wc -l )

echo "${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"
TOTAL_COUNT=$((TOTAL_COUNT + THIS_COUNT))

echo "" | tee -a "${OUTPUT_FILE:?}"

[ ${THIS_COUNT:?} -gt 0 ] && {
	echo "WARNING: Files found without grep pattern match" | tee -a "${OUTPUT_FILE:?}"
}

echo "Total grep count is: ${TOTAL_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"

THIS_COUNT=$( \
find -type 'f' | \
sort | \
grep -v -e "${GREP_GIT_DIR:?}" | \
grep -v -e "${GREP_SCRIPTS_DIR:?}" | \
wc -l )

echo "Total file count is: ${THIS_COUNT:?}" | tee -a "${OUTPUT_FILE:?}"

[ ${THIS_COUNT:?} -eq ${TOTAL_COUNT:?} ] || {
	echo "ERROR: Counts disagree, grep patterns must match multiple files" | tee -a "${OUTPUT_FILE:?}"
	exit 1
}

echo "Counts agree, grep patterns appear to be unique" | tee -a "${OUTPUT_FILE:?}"

