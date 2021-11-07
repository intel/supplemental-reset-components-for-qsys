#!/bin/sh
#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

# extract the JTAG Master header from the sopcinfo file
NEXT_FILE="../test_sys.sopcinfo"
[ -f "${NEXT_FILE:?}" ] || {
	echo ""
	echo "ERROR: could not find file '${NEXT_FILE:?}'"
	echo ""
	exit 1
}
sopc-create-header-files "${NEXT_FILE:?}" --single jtag_master_header.h --format h --module master

# extract the #define macros from the JTAG Master header file
NEXT_FILE="jtag_master_header.h"
[ -f "${NEXT_FILE:?}" ] || {
	echo ""
	echo "ERROR: could not find file '${NEXT_FILE:?}'"
	echo ""
	exit 1
}
grep -e "^#define\s.*\s\S*$" "${NEXT_FILE:?}" | sed -e "s/#define/set/" > jtag_master_header.tcl

# extract the #define macros from the reset_debouncer_regs.h header file
NEXT_FILE="../software/boot_check_bsp/drivers/inc/reset_debouncer_regs.h"
[ -f "${NEXT_FILE:?}" ] || {
	echo ""
	echo "ERROR: could not find file '${NEXT_FILE:?}'"
	echo ""
	exit 1
}
MACRO_PREFIX="RESET_DEBOUNCER_"
grep -e "^#define\s${MACRO_PREFIX}.*\s\S*$" ${NEXT_FILE} | \
sed -e "s/^#define\s\(${MACRO_PREFIX}.*\)\s\(\S*\)$/set \1 [ expr \2 ]/" >> jtag_master_header.tcl

# extract the #define macros from the pll_reset_monitor_regs.h header file
NEXT_FILE="../software/boot_check_bsp/drivers/inc/pll_reset_monitor_regs.h"
[ -f "${NEXT_FILE:?}" ] || {
	echo ""
	echo "ERROR: could not find file '${NEXT_FILE:?}'"
	echo ""
	exit 1
}
MACRO_PREFIX="PLL_RESET_MONITOR_"
grep -e "^#define\s${MACRO_PREFIX}.*\s\S*$" ${NEXT_FILE} | \
sed -e "s/^#define\s\(${MACRO_PREFIX}.*\)\s\(\S*\)$/set \1 [ expr \2 ]/" >> jtag_master_header.tcl

# extract the #define macros from the reset_event_counter_regs.h header file
NEXT_FILE="../software/boot_check_bsp/drivers/inc/reset_event_counter_regs.h"
[ -f "${NEXT_FILE:?}" ] || {
	echo ""
	echo "ERROR: could not find file '${NEXT_FILE:?}'"
	echo ""
	exit 1
}
MACRO_PREFIX="RESET_EVENT_COUNTER_"
grep -e "^#define\s${MACRO_PREFIX}.*\s\S*$" ${NEXT_FILE} | \
sed -e "s/^#define\s\(${MACRO_PREFIX}.*\)\s\(\S*\)$/set \1 [ expr \2 ]/" >> jtag_master_header.tcl

# extract the #define macros from the test_sys_reset_modules_assignments.h header file
NEXT_FILE="../software/boot_check/test_sys_reset_modules_assignments.h"
[ -f "${NEXT_FILE:?}" ] || {
	echo ""
	echo "ERROR: could not find file '${NEXT_FILE:?}'"
	echo ""
	exit 1
}
MACRO_PREFIX="RMA_"
grep -e "^#define\s${MACRO_PREFIX}.*\s\S*$" ${NEXT_FILE} | \
sed -e "s/^#define\s\(${MACRO_PREFIX}.*\)\s\(\S*\)$/set \1 [ expr \2 ]/" >> jtag_master_header.tcl

