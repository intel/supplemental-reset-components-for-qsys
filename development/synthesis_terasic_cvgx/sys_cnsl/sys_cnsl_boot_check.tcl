#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

# include the header file for Qsys system macros
set INCLUDE_HEADER "jtag_master_header.tcl"
if { [ file exists "$INCLUDE_HEADER" ] } {
	source "$INCLUDE_HEADER"
} else {
	puts "ERROR: could not locate include file '$INCLUDE_HEADER'"
	puts "Have you run the create_sys_cnsl_header.sh script which creates the header file?"
	return -code error "could not locate include file '$INCLUDE_HEADER'"
}

# open the service path to our expected JTAG Master master service
set jm [ lindex [ get_service_paths master ] [ lsearch [ get_service_paths master ] "*(110:132 v1 #0)*" ] ]
if { [ string length "$jm" ] == 0 } {
	set jm [ lindex [ get_service_paths master ] [ lsearch [ get_service_paths master ] "*phy_0/master.master" ] ]
	if { [ string length "$jm" ] == 0 } {
		return -code error "could not locate expected master service path"
	}
}

open_service master "$jm"

# extract the SysID values
set sysid_list [ master_read_32 $jm $SYSID_BASE 2 ]

puts [ format "  ACTUAL SYSID ID: %s" [ lindex $sysid_list 0 ] ]
puts [ format "EXPECTED SYSID ID: 0x%08x" $SYSID_ID ]
if { [ lsearch $sysid_list [ format "0x%08x" $SYSID_ID ] ] == 0 } {
	puts "sysID ID value is correct."
} else {
	puts "sysID ID value is INCORRECT."
}

puts [ format "  ACTUAL SYSID TS: %s" [ lindex $sysid_list 1 ] ]
puts [ format "EXPECTED SYSID TS: 0x%08x" $SYSID_TIMESTAMP ]
if { [ lsearch $sysid_list [ format "0x%08x" $SYSID_TIMESTAMP ] ] == 1 } {
	puts "sysID TS value is correct."
} else {
	puts "sysID TS value is INCORRECT."
}

# extract the debouncer values
set debouncer_reg [ master_read_32 $jm $RESETS_CPU_RESET_N_RESET_DEBOUNCER_BASE 1 ]
set debounce_count [ expr ($debouncer_reg & $RESET_DEBOUNCER_CAPTURE_DEBOUNCE_COUNT_MASK) >> $RESET_DEBOUNCER_CAPTURE_DEBOUNCE_COUNT_OFST ]
set deassertion_edge_count [ expr ($debouncer_reg & $RESET_DEBOUNCER_DEASSERTION_EDGE_COUNT_MASK) >> $RESET_DEBOUNCER_DEASSERTION_EDGE_COUNT_OFST ]
set assertion_edge_count [ expr ($debouncer_reg & $RESET_DEBOUNCER_ASSERTION_EDGE_COUNT_MASK) >> $RESET_DEBOUNCER_ASSERTION_EDGE_COUNT_OFST ]
puts ""
puts [ format "         debouncer_reg = 0x%08x" $debouncer_reg ]
puts [ format "        debounce_count = 0x%08x" $debounce_count ]
puts [ format "deassertion_edge_count = 0x%08x" $deassertion_edge_count ]
puts [ format "  assertion_edge_count = 0x%08x" $assertion_edge_count ]

# extract the ddr_cal_success event timer values
set event_timer_ddr_cal_success_reg [ master_read_32 $jm $RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_BASE 1 ]
puts ""
puts [ format "event_timer_ddr_cal_success_reg = 0x%08x" $event_timer_ddr_cal_success_reg ]

# extract the ddr_init_done event timer values
set event_timer_ddr_init_done_reg [ master_read_32 $jm $RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_BASE 1 ]
puts ""
puts [ format "event_timer_ddr_init_done_reg = 0x%08x" $event_timer_ddr_init_done_reg ]

# extract the ddr pll reset monitor values
set ddr_pll_reset_monitor_reg [ master_read_32 $jm $RESETS_DDR_PLL_RESET_MONITOR_BASE 1 ]
set ddr_prm_capture_lock_count [ expr ($ddr_pll_reset_monitor_reg & $PLL_RESET_MONITOR_CAPTURE_LOCK_COUNT_MASK) >> $PLL_RESET_MONITOR_CAPTURE_LOCK_COUNT_OFST ]
set ddr_prm_lock_counter_width [ expr ($ddr_pll_reset_monitor_reg & $PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH_MASK) >> $PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH_OFST ]
set ddr_prm_unlock_count [ expr ($ddr_pll_reset_monitor_reg & $PLL_RESET_MONITOR_UNLOCK_COUNT_MASK) >> $PLL_RESET_MONITOR_UNLOCK_COUNT_OFST ]
puts ""
puts [ format " ddr_pll_reset_monitor_reg = 0x%08x" $ddr_pll_reset_monitor_reg ]
puts [ format "ddr_prm_capture_lock_count = 0x%08x" $ddr_prm_capture_lock_count ]
puts [ format "ddr_prm_lock_counter_width = 0x%08x" $ddr_prm_lock_counter_width ]
puts [ format "      ddr_prm_unlock_count = 0x%08x" $ddr_prm_unlock_count ]

# extract the pll pll reset monitor values
set pll_pll_reset_monitor_reg [ master_read_32 $jm $RESETS_PLL_PLL_RESET_MONITOR_BASE 1 ]
set pll_prm_capture_lock_count [ expr ($pll_pll_reset_monitor_reg & $PLL_RESET_MONITOR_CAPTURE_LOCK_COUNT_MASK) >> $PLL_RESET_MONITOR_CAPTURE_LOCK_COUNT_OFST ]
set pll_prm_lock_counter_width [ expr ($pll_pll_reset_monitor_reg & $PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH_MASK) >> $PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH_OFST ]
set pll_prm_unlock_count [ expr ($pll_pll_reset_monitor_reg & $PLL_RESET_MONITOR_UNLOCK_COUNT_MASK) >> $PLL_RESET_MONITOR_UNLOCK_COUNT_OFST ]
puts ""
puts [ format " pll_pll_reset_monitor_reg = 0x%08x" $pll_pll_reset_monitor_reg ]
puts [ format "pll_prm_capture_lock_count = 0x%08x" $pll_prm_capture_lock_count ]
puts [ format "pll_prm_lock_counter_width = 0x%08x" $pll_prm_lock_counter_width ]
puts [ format "      pll_prm_unlock_count = 0x%08x" $pll_prm_unlock_count ]

# extract the reset event counter values
puts ""
set reset_event_counter_value [ master_read_32 $jm $RESETS_REC_CPU_RESET_N_BASE 1 ]
set rec_assertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_ASSERT_COUNT_OFST ]
set rec_deassertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST ]
set rec_assertion_value [ expr $rec_assertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
set rec_deassertion_value [ expr $rec_deassertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
puts "CPU_RESET_N"
puts [ format "    deassertion = 0x%08x" $rec_deassertion_value ]
puts [ format "      assertion = 0x%08x" $rec_assertion_value ]

set reset_event_counter_value [ master_read_32 $jm $RESETS_REC_DDR_CAL_FAIL_BASE 1 ]
set rec_assertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_ASSERT_COUNT_OFST ]
set rec_deassertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST ]
set rec_assertion_value [ expr $rec_assertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
set rec_deassertion_value [ expr $rec_deassertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
puts "DDR_CAL_FAIL"
puts [ format "    deassertion = 0x%08x" $rec_deassertion_value ]
puts [ format "      assertion = 0x%08x" $rec_assertion_value ]

set reset_event_counter_value [ master_read_32 $jm $RESETS_REC_DDR_LOCK_FAILURE_BASE 1 ]
set rec_assertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_ASSERT_COUNT_OFST ]
set rec_deassertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST ]
set rec_assertion_value [ expr $rec_assertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
set rec_deassertion_value [ expr $rec_deassertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
puts "DDR_LOCK_FAILURE"
puts [ format "    deassertion = 0x%08x" $rec_deassertion_value ]
puts [ format "      assertion = 0x%08x" $rec_assertion_value ]

set reset_event_counter_value [ master_read_32 $jm $RESETS_REC_DDR_LOST_CAL_SUCCESS_BASE 1 ]
set rec_assertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_ASSERT_COUNT_OFST ]
set rec_deassertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST ]
set rec_assertion_value [ expr $rec_assertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
set rec_deassertion_value [ expr $rec_deassertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
puts "DDR_LOST_CAL_SUCCESS"
puts [ format "    deassertion = 0x%08x" $rec_deassertion_value ]
puts [ format "      assertion = 0x%08x" $rec_assertion_value ]

set reset_event_counter_value [ master_read_32 $jm $RESETS_REC_DDR_LOST_INIT_DONE_BASE 1 ]
set rec_assertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_ASSERT_COUNT_OFST ]
set rec_deassertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST ]
set rec_assertion_value [ expr $rec_assertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
set rec_deassertion_value [ expr $rec_deassertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
puts "DDR_LOST_INIT_DONE"
puts [ format "    deassertion = 0x%08x" $rec_deassertion_value ]
puts [ format "      assertion = 0x%08x" $rec_assertion_value ]

set reset_event_counter_value [ master_read_32 $jm $RESETS_REC_DDR_TIMEOUT_CAL_SUCCESS_BASE 1 ]
set rec_assertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_ASSERT_COUNT_OFST ]
set rec_deassertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST ]
set rec_assertion_value [ expr $rec_assertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
set rec_deassertion_value [ expr $rec_deassertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
puts "DDR_TIMEOUT_CAL_SUCCESS"
puts [ format "    deassertion = 0x%08x" $rec_deassertion_value ]
puts [ format "      assertion = 0x%08x" $rec_assertion_value ]

set reset_event_counter_value [ master_read_32 $jm $RESETS_REC_DDR_TIMEOUT_INIT_DONE_BASE 1 ]
set rec_assertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_ASSERT_COUNT_OFST ]
set rec_deassertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST ]
set rec_assertion_value [ expr $rec_assertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
set rec_deassertion_value [ expr $rec_deassertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
puts "DDR_TIMEOUT_INIT_DONE"
puts [ format "    deassertion = 0x%08x" $rec_deassertion_value ]
puts [ format "      assertion = 0x%08x" $rec_assertion_value ]

set reset_event_counter_value [ master_read_32 $jm $RESETS_REC_DEBUG_RESETS_BASE 1 ]
set rec_assertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_ASSERT_COUNT_OFST ]
set rec_deassertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST ]
set rec_assertion_value [ expr $rec_assertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
set rec_deassertion_value [ expr $rec_deassertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
puts "DEBUG_RESETS"
puts [ format "    deassertion = 0x%08x" $rec_deassertion_value ]
puts [ format "      assertion = 0x%08x" $rec_assertion_value ]

set reset_event_counter_value [ master_read_32 $jm $RESETS_REC_PLL_LOCK_FAILURE_BASE 1 ]
set rec_assertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_ASSERT_COUNT_OFST ]
set rec_deassertion_value [ expr ($reset_event_counter_value & $RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> $RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST ]
set rec_assertion_value [ expr $rec_assertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
set rec_deassertion_value [ expr $rec_deassertion_value & ((1 << $RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1) ]
puts "PLL_LOCK_FAILURE"
puts [ format "    deassertion = 0x%08x" $rec_deassertion_value ]
puts [ format "      assertion = 0x%08x" $rec_assertion_value ]

# print reset modules assignments
puts "\nRESET MODULES ASSIGNMENTS\n"
if {	[ expr \
		($RMA_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_CONDUIT != 0) || \
		($RMA_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_INTERRUPT != 0) || \
		($RMA_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_RESET != 0) || \
		($RMA_DEFAULT_SLAVE_ENABLE_CLEAR_EVENT != 0) || \
		($RMA_DEFAULT_SLAVE_ENABLE_READ_RESPONSE != 0) || \
		($RMA_DEFAULT_SLAVE_ENABLE_WRITE_RESPONSE != 0) ]
	} {
	puts "DEFAULT_SLAVE has extra features enabled."
} else {
	puts "DEFAULT_SLAVE has NO extra features enabled."
}
if { [ expr ($RMA_DEFAULT_SLAVE_NEVER_RESPOND != 0) ] } {
	puts "DEFAULT_SLAVE asserts waitrequest never."
} else {
	puts "DEFAULT_SLAVE asserts waitrequest when accessed."
}
puts [ format "DEFAULT_SLAVE is %d byte(s) wide." $RMA_DEFAULT_SLAVE_DATA_BYTES ]
puts [ format "DEFAULT_SLAVE read data pattern is 0x%08x." $RMA_DEFAULT_SLAVE_READ_DATA_PATTERN ]
puts [ format "DEFAULT_SLAVE response pattern is 0x%08x." $RMA_DEFAULT_SLAVE_RESPONSE_PATTERN ]

puts ""
if {	[ expr \
		($RMA_RESETS_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_CONDUIT != 0) || \
		($RMA_RESETS_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_INTERRUPT != 0) || \
		($RMA_RESETS_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_RESET != 0) || \
		($RMA_RESETS_DEFAULT_SLAVE_ENABLE_CLEAR_EVENT != 0) || \
		($RMA_RESETS_DEFAULT_SLAVE_ENABLE_READ_RESPONSE != 0) || \
		($RMA_RESETS_DEFAULT_SLAVE_ENABLE_WRITE_RESPONSE != 0) ]
	} {
	puts "RESETS_DEFAULT_SLAVE has extra features enabled."
} else {
	puts "RESETS_DEFAULT_SLAVE has NO extra features enabled."
}
if { [ expr ($RMA_RESETS_DEFAULT_SLAVE_NEVER_RESPOND != 0) ] } {
	puts "RESETS_DEFAULT_SLAVE asserts waitrequest never."
} else {
	puts "RESETS_DEFAULT_SLAVE asserts waitrequest when accessed."
}
puts [ format "RESETS_DEFAULT_SLAVE is %d byte(s) wide." $RMA_RESETS_DEFAULT_SLAVE_DATA_BYTES ]
puts [ format "RESETS_DEFAULT_SLAVE read data pattern is 0x%08x." $RMA_RESETS_DEFAULT_SLAVE_READ_DATA_PATTERN ]
puts [ format "RESETS_DEFAULT_SLAVE response pattern is 0x%08x." $RMA_RESETS_DEFAULT_SLAVE_RESPONSE_PATTERN ]

puts ""
if {	[ expr \
		($RMA_SLOW_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_CONDUIT != 0) || \
		($RMA_SLOW_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_INTERRUPT != 0) || \
		($RMA_SLOW_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_RESET != 0) || \
		($RMA_SLOW_DEFAULT_SLAVE_ENABLE_CLEAR_EVENT != 0) || \
		($RMA_SLOW_DEFAULT_SLAVE_ENABLE_READ_RESPONSE != 0) || \
		($RMA_SLOW_DEFAULT_SLAVE_ENABLE_WRITE_RESPONSE != 0) ]
	} {
	puts "SLOW_DEFAULT_SLAVE has extra features enabled."
} else {
	puts "SLOW_DEFAULT_SLAVE has NO extra features enabled."
}
if { [ expr ($RMA_SLOW_DEFAULT_SLAVE_NEVER_RESPOND != 0) ] } {
	puts "SLOW_DEFAULT_SLAVE asserts waitrequest never."
} else {
	puts "SLOW_DEFAULT_SLAVE asserts waitrequest when accessed."
}
puts [ format "SLOW_DEFAULT_SLAVE is %d byte(s) wide." $RMA_SLOW_DEFAULT_SLAVE_DATA_BYTES ]
puts [ format "SLOW_DEFAULT_SLAVE read data pattern is 0x%08x." $RMA_SLOW_DEFAULT_SLAVE_READ_DATA_PATTERN ]
puts [ format "SLOW_DEFAULT_SLAVE response pattern is 0x%08x." $RMA_SLOW_DEFAULT_SLAVE_RESPONSE_PATTERN ]

puts ""
puts [ format "Power on reset duration is %d ns." [ expr \
		(1000000000 / $RMA_RESETS_POWER_ON_RESET_0_CLOCK_FREQ) * \
		($RMA_RESETS_POWER_ON_RESET_0_POR_COUNT) ] ]

puts ""
puts [ format "CPU_RESET_N debouncer duration is %d ns." [ expr \
		(1000000000 / $RMA_RESETS_CPU_RESET_N_RESET_DEBOUNCER_CLOCK_FREQ) * \
		(1 << $RMA_RESETS_CPU_RESET_N_RESET_DEBOUNCER_DEBOUNCE_COUNTER_WIDTH) ] ]

puts ""
puts [ format "Master Reset assertion delay duration is %d ns." [ expr \
		(1000000000 / $RMA_RESETS_MASTER_RESET_CLOCK_FREQ) * \
		(1 << $RMA_RESETS_MASTER_RESET_DELAY_COUNTER_WIDTH) ] ]

puts ""
puts [ format "PLL Reset Monitor reset duration is %d ns." [ expr \
		(1000000000 / $RMA_RESETS_PLL_PLL_RESET_MONITOR_CLOCK_FREQ) * \
		(1 << $RMA_RESETS_PLL_PLL_RESET_MONITOR_RESET_COUNTER_WIDTH) ] ]
puts [ format "PLL Reset Monitor lock duration is %d ns." [ expr \
		(1000000000 / $RMA_RESETS_PLL_PLL_RESET_MONITOR_CLOCK_FREQ) * \
		(1 << $RMA_RESETS_PLL_PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH) ] ]
if { [ expr ($RMA_RESETS_PLL_PLL_RESET_MONITOR_ENABLE_LOCK_FAILURE_CONDUIT != 0) ] } {
	puts "PLL Reset Monitor lock failure conduit is enabled."
}
if { [ expr ($RMA_RESETS_PLL_PLL_RESET_MONITOR_ENABLE_LOCK_FAILURE_RESET != 0) ] } {
	puts "PLL Reset Monitor lock failure reset is enabled."
}
if { [ expr ($RMA_RESETS_PLL_PLL_RESET_MONITOR_ENABLE_LOCK_SUCCESS_CONDUIT != 0) ] } {
	puts "PLL Reset Monitor lock success conduit is enabled."
}
if { [ expr ($RMA_RESETS_PLL_PLL_RESET_MONITOR_ENABLE_LOCK_SUCCESS_RESET != 0) ] } {
	puts "PLL Reset Monitor lock success reset is enabled."
}

puts ""
puts [ format "DDR PLL Reset Monitor reset duration is %d ns." [ expr \
		(1000000000 / $RMA_RESETS_DDR_PLL_RESET_MONITOR_CLOCK_FREQ) * \
		(1 << $RMA_RESETS_DDR_PLL_RESET_MONITOR_RESET_COUNTER_WIDTH) ] ]
puts [ format "DDR PLL Reset Monitor lock duration is %d ns." [ expr \
		(1000000000 / $RMA_RESETS_DDR_PLL_RESET_MONITOR_CLOCK_FREQ) * \
		(1 << $RMA_RESETS_DDR_PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH) ] ]
if { [ expr ($RMA_RESETS_DDR_PLL_RESET_MONITOR_ENABLE_LOCK_FAILURE_CONDUIT != 0) ] } {
	puts "DDR PLL Reset Monitor lock failure conduit is enabled."
}
if { [ expr ($RMA_RESETS_DDR_PLL_RESET_MONITOR_ENABLE_LOCK_FAILURE_RESET != 0) ] } {
	puts "DDR PLL Reset Monitor lock failure reset is enabled."
}
if { [ expr ($RMA_RESETS_DDR_PLL_RESET_MONITOR_ENABLE_LOCK_SUCCESS_CONDUIT != 0) ] } {
	puts "DDR PLL Reset Monitor lock success conduit is enabled."
}
if { [ expr ($RMA_RESETS_DDR_PLL_RESET_MONITOR_ENABLE_LOCK_SUCCESS_RESET != 0) ] } {
	puts "DDR PLL Reset Monitor lock success reset is enabled."
}

puts ""
puts [ format "DDR calibration success timeout duration is %d ns." [ expr \
		(1000000000 / $RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_CLOCK_FREQ) * \
		(1 << $RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_TIMEOUT_COUNTER_WIDTH) ] ]
if { [ expr ($RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_ENABLE_ACQUIRED_CONDUIT != 0) ] } {
	puts "DDR calibration success acquired conduit is enabled."
}
if { [ expr ($RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_ENABLE_ACQUIRED_RESET != 0) ] } {
	puts "DDR calibration success acquired reset is enabled."
}
if { [ expr ($RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_ENABLE_LOST_CONDUIT != 0) ] } {
	puts "DDR calibration success lost conduit is enabled."
}
if { [ expr ($RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_ENABLE_LOST_RESET != 0) ] } {
	puts "DDR calibration success lost reset is enabled."
}
if { [ expr ($RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_ENABLE_TIMEOUT_CONDUIT != 0) ] } {
	puts "DDR calibration success timeout conduit is enabled."
}
if { [ expr ($RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_ENABLE_TIMEOUT_RESET != 0) ] } {
	puts "DDR calibration success timeout reset is enabled."
}

puts ""
puts [ format "DDR init done timeout duration is %d ns." [ expr \
		(1000000000 / $RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_CLOCK_FREQ) * \
		(1 << $RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_TIMEOUT_COUNTER_WIDTH) ] ]
if { [ expr ($RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_ENABLE_ACQUIRED_CONDUIT != 0) ] } {
	puts "DDR init done acquired conduit is enabled."
}
if { [ expr ($RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_ENABLE_ACQUIRED_RESET != 0) ] } {
	puts "DDR init done acquired reset is enabled."
}
if { [ expr ($RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_ENABLE_LOST_CONDUIT != 0) ] } {
	puts "DDR init done lost conduit is enabled."
}
if { [ expr ($RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_ENABLE_LOST_RESET != 0) ] } {
	puts "DDR init done lost reset is enabled."
}
if { [ expr ($RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_ENABLE_TIMEOUT_CONDUIT != 0) ] } {
	puts "DDR init done timeout conduit is enabled."
}
if { [ expr ($RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_ENABLE_TIMEOUT_RESET != 0) ] } {
	puts "DDR init done timeout reset is enabled."
}

