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
package require -exact qsys 14.0

create_system {reset_subsys}

set_project_property {DEVICE_FAMILY} {CYCLONEV}
set_project_property {DEVICE} {5CGXFC5C6F27C7}

proc create_qsys_system {} {

    #
    # Manually reorder this list of component instances to reflect the order
    # that you wish to see them appear in the Qsys GUI.
    #
	add_instance_power_on_reset_0
	add_instance_debug_resets
	add_instance_cpu_reset_n
	add_instance_cpu_reset_n_reset_debouncer
	add_instance_system_in
	add_instance_system_reset_out
	add_instance_master_reset_merge
	add_instance_master_reset
	add_instance_ddr_ref_clk
	add_instance_ddr_reset_out
	add_instance_ddr_pll_reset_monitor
	add_instance_ddr_soft_reset
	add_instance_ddr_afi_reset
	add_instance_ddr_pll_sharing_to_pll_locked
	add_instance_ddr_emif_status_breakout
	add_instance_ddr_event_timer_ddr_cal_success
	add_instance_ddr_event_timer_ddr_init_done
	add_instance_pll_ref_clk
	add_instance_pll_reset_out
	add_instance_pll_pll_reset_monitor
	add_instance_mm_bridge
	add_instance_default_slave
	add_instance_rec_debug_resets
	add_instance_rec_cpu_reset_n
	add_instance_rec_ddr_lock_failure
	add_instance_rec_ddr_cal_fail
	add_instance_rec_ddr_lost_cal_success
	add_instance_rec_ddr_timeout_cal_success
	add_instance_rec_ddr_lost_init_done
	add_instance_rec_ddr_timeout_init_done
	add_instance_rec_pll_lock_failure

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

proc add_instance_cpu_reset_n { } {
    add_instance cpu_reset_n altera_reset_bridge
    set_instance_parameter_value cpu_reset_n {ACTIVE_LOW_RESET} {1}
    set_instance_parameter_value cpu_reset_n {SYNCHRONOUS_EDGES} {none}
    set_instance_parameter_value cpu_reset_n {NUM_RESET_OUTPUTS} {1}
    set_instance_parameter_value cpu_reset_n {USE_RESET_REQUEST} {0}
}

proc add_instance_cpu_reset_n_reset_debouncer { } {
    add_instance cpu_reset_n_reset_debouncer reset_debouncer
    set_instance_parameter_value cpu_reset_n_reset_debouncer {DEBOUNCE_COUNTER_WIDTH} {15}
}

proc add_instance_ddr_afi_reset { } {
    add_instance ddr_afi_reset altera_reset_bridge
    set_instance_parameter_value ddr_afi_reset {ACTIVE_LOW_RESET} {0}
    set_instance_parameter_value ddr_afi_reset {SYNCHRONOUS_EDGES} {none}
    set_instance_parameter_value ddr_afi_reset {NUM_RESET_OUTPUTS} {1}
    set_instance_parameter_value ddr_afi_reset {USE_RESET_REQUEST} {0}
}

proc add_instance_ddr_emif_status_breakout { } {
    add_instance ddr_emif_status_breakout emif_status_breakout
}

proc add_instance_ddr_event_timer_ddr_cal_success { } {
    add_instance ddr_event_timer_ddr_cal_success event_timer
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {TIMEOUT_COUNTER_WIDTH} {22}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {EVENT_INPUT_CONDUIT_ROLE} {event_input}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {ENABLE_ACQUIRED_RESET} {1}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {ACQUIRED_RESET_ROLE} {0}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {ENABLE_ACQUIRED_CONDUIT} {0}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {ACQUIRED_CONDUIT_ROLE} {acquired}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {ENABLE_LOST_RESET} {1}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {LOST_RESET_ROLE} {1}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {ENABLE_LOST_CONDUIT} {0}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {LOST_CONDUIT_ROLE} {lost}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {ENABLE_TIMEOUT_RESET} {1}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {TIMEOUT_RESET_ROLE} {1}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {ENABLE_TIMEOUT_CONDUIT} {0}
    set_instance_parameter_value ddr_event_timer_ddr_cal_success {TIMEOUT_CONDUIT_ROLE} {timeout}
}

proc add_instance_ddr_event_timer_ddr_init_done { } {
    add_instance ddr_event_timer_ddr_init_done event_timer
    set_instance_parameter_value ddr_event_timer_ddr_init_done {TIMEOUT_COUNTER_WIDTH} {4}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {EVENT_INPUT_CONDUIT_ROLE} {event_input}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {ENABLE_ACQUIRED_RESET} {0}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {ACQUIRED_RESET_ROLE} {0}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {ENABLE_ACQUIRED_CONDUIT} {0}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {ACQUIRED_CONDUIT_ROLE} {acquired}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {ENABLE_LOST_RESET} {1}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {LOST_RESET_ROLE} {1}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {ENABLE_LOST_CONDUIT} {0}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {LOST_CONDUIT_ROLE} {lost}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {ENABLE_TIMEOUT_RESET} {1}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {TIMEOUT_RESET_ROLE} {1}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {ENABLE_TIMEOUT_CONDUIT} {0}
    set_instance_parameter_value ddr_event_timer_ddr_init_done {TIMEOUT_CONDUIT_ROLE} {timeout}
}

proc add_instance_ddr_pll_reset_monitor { } {
    add_instance ddr_pll_reset_monitor pll_reset_monitor
    set_instance_parameter_value ddr_pll_reset_monitor {RESET_COUNTER_WIDTH} {5}
    set_instance_parameter_value ddr_pll_reset_monitor {LOCK_COUNTER_WIDTH} {16}
    set_instance_parameter_value ddr_pll_reset_monitor {PLL_LOCKED_CONDUIT_ROLE} {pll_locked}
    set_instance_parameter_value ddr_pll_reset_monitor {ENABLE_LOCK_SUCCESS_RESET} {1}
    set_instance_parameter_value ddr_pll_reset_monitor {LOCK_SUCCESS_RESET_ROLE} {0}
    set_instance_parameter_value ddr_pll_reset_monitor {ENABLE_LOCK_SUCCESS_CONDUIT} {0}
    set_instance_parameter_value ddr_pll_reset_monitor {LOCK_SUCCESS_CONDUIT_ROLE} {lock_success}
    set_instance_parameter_value ddr_pll_reset_monitor {ENABLE_LOCK_FAILURE_RESET} {1}
    set_instance_parameter_value ddr_pll_reset_monitor {LOCK_FAILURE_RESET_ROLE} {1}
    set_instance_parameter_value ddr_pll_reset_monitor {ENABLE_LOCK_FAILURE_CONDUIT} {0}
    set_instance_parameter_value ddr_pll_reset_monitor {LOCK_FAILURE_CONDUIT_ROLE} {lock_failure}
}

proc add_instance_ddr_pll_sharing_to_pll_locked { } {
    add_instance ddr_pll_sharing_to_pll_locked pll_sharing_to_pll_locked
}

proc add_instance_ddr_ref_clk { } {
    add_instance ddr_ref_clk altera_clock_bridge
    set_instance_parameter_value ddr_ref_clk {EXPLICIT_CLOCK_RATE} {0.0}
    set_instance_parameter_value ddr_ref_clk {NUM_CLOCK_OUTPUTS} {1}
}

proc add_instance_ddr_reset_out { } {
    add_instance ddr_reset_out altera_reset_controller
    set_instance_parameter_value ddr_reset_out {NUM_RESET_INPUTS} {1}
    set_instance_parameter_value ddr_reset_out {OUTPUT_RESET_SYNC_EDGES} {deassert}
    set_instance_parameter_value ddr_reset_out {SYNC_DEPTH} {2}
    set_instance_parameter_value ddr_reset_out {RESET_REQUEST_PRESENT} {0}
    set_instance_parameter_value ddr_reset_out {RESET_REQ_WAIT_TIME} {1}
    set_instance_parameter_value ddr_reset_out {MIN_RST_ASSERTION_TIME} {3}
    set_instance_parameter_value ddr_reset_out {RESET_REQ_EARLY_DSRT_TIME} {1}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN0} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN1} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN2} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN3} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN4} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN5} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN6} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN7} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN8} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN9} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN10} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN11} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN12} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN13} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN14} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_IN15} {0}
    set_instance_parameter_value ddr_reset_out {USE_RESET_REQUEST_INPUT} {0}
}

proc add_instance_ddr_soft_reset { } {
    add_instance ddr_soft_reset altera_reset_controller
    set_instance_parameter_value ddr_soft_reset {NUM_RESET_INPUTS} {4}
    set_instance_parameter_value ddr_soft_reset {OUTPUT_RESET_SYNC_EDGES} {deassert}
    set_instance_parameter_value ddr_soft_reset {SYNC_DEPTH} {2}
    set_instance_parameter_value ddr_soft_reset {RESET_REQUEST_PRESENT} {0}
    set_instance_parameter_value ddr_soft_reset {RESET_REQ_WAIT_TIME} {1}
    set_instance_parameter_value ddr_soft_reset {MIN_RST_ASSERTION_TIME} {3}
    set_instance_parameter_value ddr_soft_reset {RESET_REQ_EARLY_DSRT_TIME} {1}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN0} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN1} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN2} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN3} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN4} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN5} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN6} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN7} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN8} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN9} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN10} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN11} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN12} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN13} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN14} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_IN15} {0}
    set_instance_parameter_value ddr_soft_reset {USE_RESET_REQUEST_INPUT} {0}
}

proc add_instance_debug_resets { } {
    add_instance debug_resets altera_reset_bridge
    set_instance_parameter_value debug_resets {ACTIVE_LOW_RESET} {0}
    set_instance_parameter_value debug_resets {SYNCHRONOUS_EDGES} {none}
    set_instance_parameter_value debug_resets {NUM_RESET_OUTPUTS} {1}
    set_instance_parameter_value debug_resets {USE_RESET_REQUEST} {0}
}

proc add_instance_default_slave { } {
    add_instance default_slave trivial_default_avalon_slave
    set_instance_parameter_value default_slave {DATA_BYTES} {4}
    set_instance_parameter_value default_slave {READ_DATA_PATTERN} {239}
    set_instance_parameter_value default_slave {ENABLE_READ_RESPONSE} {0}
    set_instance_parameter_value default_slave {RESPONSE_PATTERN} {0}
    set_instance_parameter_value default_slave {ENABLE_WRITE_RESPONSE} {0}
    set_instance_parameter_value default_slave {NEVER_RESPOND} {0}
    set_instance_parameter_value default_slave {ENABLE_CLEAR_EVENT} {0}
    set_instance_parameter_value default_slave {CLEAR_EVENT_CONDUIT_ROLE} {clear_event}
    set_instance_parameter_value default_slave {ENABLE_ACCESS_EVENT_CONDUIT} {0}
    set_instance_parameter_value default_slave {ACCESS_EVENT_CONDUIT_ROLE} {access_event_conduit}
    set_instance_parameter_value default_slave {ENABLE_ACCESS_EVENT_RESET} {0}
    set_instance_parameter_value default_slave {ENABLE_ACCESS_EVENT_INTERRUPT} {0}
}

proc add_instance_master_reset { } {
    add_instance master_reset reset_assertion_delay
    set_instance_parameter_value master_reset {DELAY_COUNTER_WIDTH} {4}
}

proc add_instance_master_reset_merge { } {
    add_instance master_reset_merge altera_reset_controller
    set_instance_parameter_value master_reset_merge {NUM_RESET_INPUTS} {8}
    set_instance_parameter_value master_reset_merge {OUTPUT_RESET_SYNC_EDGES} {deassert}
    set_instance_parameter_value master_reset_merge {SYNC_DEPTH} {2}
    set_instance_parameter_value master_reset_merge {RESET_REQUEST_PRESENT} {0}
    set_instance_parameter_value master_reset_merge {RESET_REQ_WAIT_TIME} {1}
    set_instance_parameter_value master_reset_merge {MIN_RST_ASSERTION_TIME} {3}
    set_instance_parameter_value master_reset_merge {RESET_REQ_EARLY_DSRT_TIME} {1}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN0} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN1} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN2} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN3} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN4} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN5} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN6} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN7} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN8} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN9} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN10} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN11} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN12} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN13} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN14} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_IN15} {0}
    set_instance_parameter_value master_reset_merge {USE_RESET_REQUEST_INPUT} {0}
}

proc add_instance_mm_bridge { } {
    add_instance mm_bridge altera_avalon_mm_bridge
    set_instance_parameter_value mm_bridge {DATA_WIDTH} {32}
    set_instance_parameter_value mm_bridge {SYMBOL_WIDTH} {8}
    set_instance_parameter_value mm_bridge {ADDRESS_WIDTH} {6}
    set_instance_parameter_value mm_bridge {USE_AUTO_ADDRESS_WIDTH} {0}
    set_instance_parameter_value mm_bridge {ADDRESS_UNITS} {SYMBOLS}
    set_instance_parameter_value mm_bridge {MAX_BURST_SIZE} {1}
    set_instance_parameter_value mm_bridge {MAX_PENDING_RESPONSES} {1}
    set_instance_parameter_value mm_bridge {LINEWRAPBURSTS} {0}
    set_instance_parameter_value mm_bridge {PIPELINE_COMMAND} {0}
    set_instance_parameter_value mm_bridge {PIPELINE_RESPONSE} {0}
    set_instance_parameter_value mm_bridge {USE_RESPONSE} {0}
}

proc add_instance_pll_pll_reset_monitor { } {
    add_instance pll_pll_reset_monitor pll_reset_monitor
    set_instance_parameter_value pll_pll_reset_monitor {RESET_COUNTER_WIDTH} {5}
    set_instance_parameter_value pll_pll_reset_monitor {LOCK_COUNTER_WIDTH} {16}
    set_instance_parameter_value pll_pll_reset_monitor {PLL_LOCKED_CONDUIT_ROLE} {export}
    set_instance_parameter_value pll_pll_reset_monitor {ENABLE_LOCK_SUCCESS_RESET} {1}
    set_instance_parameter_value pll_pll_reset_monitor {LOCK_SUCCESS_RESET_ROLE} {0}
    set_instance_parameter_value pll_pll_reset_monitor {ENABLE_LOCK_SUCCESS_CONDUIT} {0}
    set_instance_parameter_value pll_pll_reset_monitor {LOCK_SUCCESS_CONDUIT_ROLE} {lock_success}
    set_instance_parameter_value pll_pll_reset_monitor {ENABLE_LOCK_FAILURE_RESET} {1}
    set_instance_parameter_value pll_pll_reset_monitor {LOCK_FAILURE_RESET_ROLE} {1}
    set_instance_parameter_value pll_pll_reset_monitor {ENABLE_LOCK_FAILURE_CONDUIT} {0}
    set_instance_parameter_value pll_pll_reset_monitor {LOCK_FAILURE_CONDUIT_ROLE} {lock_failure}
}

proc add_instance_pll_ref_clk { } {
    add_instance pll_ref_clk altera_clock_bridge
    set_instance_parameter_value pll_ref_clk {EXPLICIT_CLOCK_RATE} {0.0}
    set_instance_parameter_value pll_ref_clk {NUM_CLOCK_OUTPUTS} {1}
}

proc add_instance_pll_reset_out { } {
    add_instance pll_reset_out altera_reset_controller
    set_instance_parameter_value pll_reset_out {NUM_RESET_INPUTS} {1}
    set_instance_parameter_value pll_reset_out {OUTPUT_RESET_SYNC_EDGES} {deassert}
    set_instance_parameter_value pll_reset_out {SYNC_DEPTH} {2}
    set_instance_parameter_value pll_reset_out {RESET_REQUEST_PRESENT} {0}
    set_instance_parameter_value pll_reset_out {RESET_REQ_WAIT_TIME} {1}
    set_instance_parameter_value pll_reset_out {MIN_RST_ASSERTION_TIME} {3}
    set_instance_parameter_value pll_reset_out {RESET_REQ_EARLY_DSRT_TIME} {1}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN0} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN1} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN2} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN3} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN4} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN5} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN6} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN7} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN8} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN9} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN10} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN11} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN12} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN13} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN14} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_IN15} {0}
    set_instance_parameter_value pll_reset_out {USE_RESET_REQUEST_INPUT} {0}
}

proc add_instance_power_on_reset_0 { } {
    add_instance power_on_reset_0 power_on_reset
    set_instance_parameter_value power_on_reset_0 {POR_COUNT} {25}
}

proc add_instance_rec_cpu_reset_n { } {
    add_instance rec_cpu_reset_n reset_event_counter
    set_instance_parameter_value rec_cpu_reset_n {COUNTER_WIDTH} {8}
}

proc add_instance_rec_ddr_cal_fail { } {
    add_instance rec_ddr_cal_fail reset_event_counter
    set_instance_parameter_value rec_ddr_cal_fail {COUNTER_WIDTH} {8}
}

proc add_instance_rec_ddr_lock_failure { } {
    add_instance rec_ddr_lock_failure reset_event_counter
    set_instance_parameter_value rec_ddr_lock_failure {COUNTER_WIDTH} {8}
}

proc add_instance_rec_ddr_lost_cal_success { } {
    add_instance rec_ddr_lost_cal_success reset_event_counter
    set_instance_parameter_value rec_ddr_lost_cal_success {COUNTER_WIDTH} {8}
}

proc add_instance_rec_ddr_lost_init_done { } {
    add_instance rec_ddr_lost_init_done reset_event_counter
    set_instance_parameter_value rec_ddr_lost_init_done {COUNTER_WIDTH} {8}
}

proc add_instance_rec_ddr_timeout_cal_success { } {
    add_instance rec_ddr_timeout_cal_success reset_event_counter
    set_instance_parameter_value rec_ddr_timeout_cal_success {COUNTER_WIDTH} {8}
}

proc add_instance_rec_ddr_timeout_init_done { } {
    add_instance rec_ddr_timeout_init_done reset_event_counter
    set_instance_parameter_value rec_ddr_timeout_init_done {COUNTER_WIDTH} {8}
}

proc add_instance_rec_debug_resets { } {
    add_instance rec_debug_resets reset_event_counter
    set_instance_parameter_value rec_debug_resets {COUNTER_WIDTH} {8}
}

proc add_instance_rec_pll_lock_failure { } {
    add_instance rec_pll_lock_failure reset_event_counter
    set_instance_parameter_value rec_pll_lock_failure {COUNTER_WIDTH} {8}
}

proc add_instance_system_in { } {
    add_instance system_in clock_source
    set_instance_parameter_value system_in {clockFrequency} {50000000.0}
    set_instance_parameter_value system_in {clockFrequencyKnown} {0}
    set_instance_parameter_value system_in {resetSynchronousEdges} {DEASSERT}
}

proc add_instance_system_reset_out { } {
    add_instance system_reset_out altera_reset_controller
    set_instance_parameter_value system_reset_out {NUM_RESET_INPUTS} {1}
    set_instance_parameter_value system_reset_out {OUTPUT_RESET_SYNC_EDGES} {deassert}
    set_instance_parameter_value system_reset_out {SYNC_DEPTH} {2}
    set_instance_parameter_value system_reset_out {RESET_REQUEST_PRESENT} {0}
    set_instance_parameter_value system_reset_out {RESET_REQ_WAIT_TIME} {1}
    set_instance_parameter_value system_reset_out {MIN_RST_ASSERTION_TIME} {3}
    set_instance_parameter_value system_reset_out {RESET_REQ_EARLY_DSRT_TIME} {1}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN0} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN1} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN2} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN3} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN4} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN5} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN6} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN7} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN8} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN9} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN10} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN11} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN12} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN13} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN14} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_IN15} {0}
    set_instance_parameter_value system_reset_out {USE_RESET_REQUEST_INPUT} {0}
}

proc add_connections_and_other_settings {} {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    # connections and connection parameters
    add_connection mm_bridge.m0 pll_pll_reset_monitor.s0 avalon
    set_connection_parameter_value mm_bridge.m0/pll_pll_reset_monitor.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/pll_pll_reset_monitor.s0 baseAddress {0x0034}
    set_connection_parameter_value mm_bridge.m0/pll_pll_reset_monitor.s0 defaultConnection {0}

    add_connection mm_bridge.m0 ddr_event_timer_ddr_init_done.s0 avalon
    set_connection_parameter_value mm_bridge.m0/ddr_event_timer_ddr_init_done.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/ddr_event_timer_ddr_init_done.s0 baseAddress {0x0030}
    set_connection_parameter_value mm_bridge.m0/ddr_event_timer_ddr_init_done.s0 defaultConnection {0}

    add_connection mm_bridge.m0 ddr_event_timer_ddr_cal_success.s0 avalon
    set_connection_parameter_value mm_bridge.m0/ddr_event_timer_ddr_cal_success.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/ddr_event_timer_ddr_cal_success.s0 baseAddress {0x002c}
    set_connection_parameter_value mm_bridge.m0/ddr_event_timer_ddr_cal_success.s0 defaultConnection {0}

    add_connection mm_bridge.m0 ddr_pll_reset_monitor.s0 avalon
    set_connection_parameter_value mm_bridge.m0/ddr_pll_reset_monitor.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/ddr_pll_reset_monitor.s0 baseAddress {0x0028}
    set_connection_parameter_value mm_bridge.m0/ddr_pll_reset_monitor.s0 defaultConnection {0}

    add_connection mm_bridge.m0 cpu_reset_n_reset_debouncer.s0 avalon
    set_connection_parameter_value mm_bridge.m0/cpu_reset_n_reset_debouncer.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/cpu_reset_n_reset_debouncer.s0 baseAddress {0x0024}
    set_connection_parameter_value mm_bridge.m0/cpu_reset_n_reset_debouncer.s0 defaultConnection {0}

    add_connection mm_bridge.m0 rec_pll_lock_failure.s0 avalon
    set_connection_parameter_value mm_bridge.m0/rec_pll_lock_failure.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/rec_pll_lock_failure.s0 baseAddress {0x0020}
    set_connection_parameter_value mm_bridge.m0/rec_pll_lock_failure.s0 defaultConnection {0}

    add_connection mm_bridge.m0 rec_ddr_timeout_init_done.s0 avalon
    set_connection_parameter_value mm_bridge.m0/rec_ddr_timeout_init_done.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/rec_ddr_timeout_init_done.s0 baseAddress {0x001c}
    set_connection_parameter_value mm_bridge.m0/rec_ddr_timeout_init_done.s0 defaultConnection {0}

    add_connection mm_bridge.m0 rec_ddr_lost_init_done.s0 avalon
    set_connection_parameter_value mm_bridge.m0/rec_ddr_lost_init_done.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/rec_ddr_lost_init_done.s0 baseAddress {0x0018}
    set_connection_parameter_value mm_bridge.m0/rec_ddr_lost_init_done.s0 defaultConnection {0}

    add_connection mm_bridge.m0 rec_ddr_timeout_cal_success.s0 avalon
    set_connection_parameter_value mm_bridge.m0/rec_ddr_timeout_cal_success.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/rec_ddr_timeout_cal_success.s0 baseAddress {0x0014}
    set_connection_parameter_value mm_bridge.m0/rec_ddr_timeout_cal_success.s0 defaultConnection {0}

    add_connection mm_bridge.m0 rec_ddr_lost_cal_success.s0 avalon
    set_connection_parameter_value mm_bridge.m0/rec_ddr_lost_cal_success.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/rec_ddr_lost_cal_success.s0 baseAddress {0x0010}
    set_connection_parameter_value mm_bridge.m0/rec_ddr_lost_cal_success.s0 defaultConnection {0}

    add_connection mm_bridge.m0 rec_ddr_cal_fail.s0 avalon
    set_connection_parameter_value mm_bridge.m0/rec_ddr_cal_fail.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/rec_ddr_cal_fail.s0 baseAddress {0x000c}
    set_connection_parameter_value mm_bridge.m0/rec_ddr_cal_fail.s0 defaultConnection {0}

    add_connection mm_bridge.m0 rec_ddr_lock_failure.s0 avalon
    set_connection_parameter_value mm_bridge.m0/rec_ddr_lock_failure.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/rec_ddr_lock_failure.s0 baseAddress {0x0008}
    set_connection_parameter_value mm_bridge.m0/rec_ddr_lock_failure.s0 defaultConnection {0}

    add_connection mm_bridge.m0 rec_cpu_reset_n.s0 avalon
    set_connection_parameter_value mm_bridge.m0/rec_cpu_reset_n.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/rec_cpu_reset_n.s0 baseAddress {0x0004}
    set_connection_parameter_value mm_bridge.m0/rec_cpu_reset_n.s0 defaultConnection {0}

    add_connection mm_bridge.m0 rec_debug_resets.s0 avalon
    set_connection_parameter_value mm_bridge.m0/rec_debug_resets.s0 arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/rec_debug_resets.s0 baseAddress {0x0000}
    set_connection_parameter_value mm_bridge.m0/rec_debug_resets.s0 defaultConnection {0}

    add_connection mm_bridge.m0 default_slave.slave avalon
    set_connection_parameter_value mm_bridge.m0/default_slave.slave arbitrationPriority {1}
    set_connection_parameter_value mm_bridge.m0/default_slave.slave baseAddress {0x0000}
    set_connection_parameter_value mm_bridge.m0/default_slave.slave defaultConnection {1}

    add_connection system_in.clk mm_bridge.clk clock

    add_connection system_in.clk default_slave.clock clock

    add_connection system_in.clk pll_pll_reset_monitor.s0_clk clock

    add_connection system_in.clk ddr_event_timer_ddr_init_done.s0_clk clock

    add_connection system_in.clk ddr_event_timer_ddr_cal_success.s0_clk clock

    add_connection system_in.clk ddr_pll_reset_monitor.s0_clk clock

    add_connection system_in.clk cpu_reset_n_reset_debouncer.s0_clk clock

    add_connection system_in.clk rec_debug_resets.s0_clk clock

    add_connection system_in.clk rec_cpu_reset_n.s0_clk clock

    add_connection system_in.clk rec_ddr_lock_failure.s0_clk clock

    add_connection system_in.clk rec_ddr_cal_fail.s0_clk clock

    add_connection system_in.clk rec_ddr_lost_cal_success.s0_clk clock

    add_connection system_in.clk rec_ddr_timeout_cal_success.s0_clk clock

    add_connection system_in.clk rec_ddr_lost_init_done.s0_clk clock

    add_connection system_in.clk rec_ddr_timeout_init_done.s0_clk clock

    add_connection system_in.clk rec_pll_lock_failure.s0_clk clock

    add_connection ddr_ref_clk.out_clk system_reset_out.clk clock

    add_connection ddr_ref_clk.out_clk ddr_reset_out.clk clock

    add_connection ddr_ref_clk.out_clk ddr_soft_reset.clk clock

    add_connection pll_ref_clk.out_clk pll_reset_out.clk clock

    add_connection pll_ref_clk.out_clk master_reset_merge.clk clock

    add_connection pll_ref_clk.out_clk power_on_reset_0.clock clock

    add_connection pll_ref_clk.out_clk master_reset.clock clock

    add_connection pll_ref_clk.out_clk rec_debug_resets.clock clock

    add_connection pll_ref_clk.out_clk rec_cpu_reset_n.clock clock

    add_connection pll_ref_clk.out_clk rec_ddr_lock_failure.clock clock

    add_connection pll_ref_clk.out_clk rec_ddr_cal_fail.clock clock

    add_connection pll_ref_clk.out_clk rec_ddr_lost_cal_success.clock clock

    add_connection pll_ref_clk.out_clk rec_ddr_timeout_cal_success.clock clock

    add_connection pll_ref_clk.out_clk rec_ddr_lost_init_done.clock clock

    add_connection pll_ref_clk.out_clk rec_ddr_timeout_init_done.clock clock

    add_connection pll_ref_clk.out_clk rec_pll_lock_failure.clock clock

    add_connection pll_ref_clk.out_clk cpu_reset_n_reset_debouncer.debounce_clock clock

    add_connection ddr_ref_clk.out_clk ddr_event_timer_ddr_init_done.event_clk clock

    add_connection ddr_ref_clk.out_clk ddr_event_timer_ddr_cal_success.event_clk clock

    add_connection ddr_ref_clk.out_clk ddr_pll_reset_monitor.pll_ref_clk clock

    add_connection pll_ref_clk.out_clk pll_pll_reset_monitor.pll_ref_clk clock

    add_connection ddr_emif_status_breakout.cal_success ddr_event_timer_ddr_cal_success.event_input conduit
    set_connection_parameter_value ddr_emif_status_breakout.cal_success/ddr_event_timer_ddr_cal_success.event_input endPort {}
    set_connection_parameter_value ddr_emif_status_breakout.cal_success/ddr_event_timer_ddr_cal_success.event_input endPortLSB {0}
    set_connection_parameter_value ddr_emif_status_breakout.cal_success/ddr_event_timer_ddr_cal_success.event_input startPort {}
    set_connection_parameter_value ddr_emif_status_breakout.cal_success/ddr_event_timer_ddr_cal_success.event_input startPortLSB {0}
    set_connection_parameter_value ddr_emif_status_breakout.cal_success/ddr_event_timer_ddr_cal_success.event_input width {0}

    add_connection ddr_event_timer_ddr_init_done.event_input ddr_emif_status_breakout.init_done conduit
    set_connection_parameter_value ddr_event_timer_ddr_init_done.event_input/ddr_emif_status_breakout.init_done endPort {}
    set_connection_parameter_value ddr_event_timer_ddr_init_done.event_input/ddr_emif_status_breakout.init_done endPortLSB {0}
    set_connection_parameter_value ddr_event_timer_ddr_init_done.event_input/ddr_emif_status_breakout.init_done startPort {}
    set_connection_parameter_value ddr_event_timer_ddr_init_done.event_input/ddr_emif_status_breakout.init_done startPortLSB {0}
    set_connection_parameter_value ddr_event_timer_ddr_init_done.event_input/ddr_emif_status_breakout.init_done width {0}

    add_connection ddr_pll_sharing_to_pll_locked.pll_locked ddr_pll_reset_monitor.pll_locked conduit
    set_connection_parameter_value ddr_pll_sharing_to_pll_locked.pll_locked/ddr_pll_reset_monitor.pll_locked endPort {}
    set_connection_parameter_value ddr_pll_sharing_to_pll_locked.pll_locked/ddr_pll_reset_monitor.pll_locked endPortLSB {0}
    set_connection_parameter_value ddr_pll_sharing_to_pll_locked.pll_locked/ddr_pll_reset_monitor.pll_locked startPort {}
    set_connection_parameter_value ddr_pll_sharing_to_pll_locked.pll_locked/ddr_pll_reset_monitor.pll_locked startPortLSB {0}
    set_connection_parameter_value ddr_pll_sharing_to_pll_locked.pll_locked/ddr_pll_reset_monitor.pll_locked width {0}

    add_connection ddr_event_timer_ddr_cal_success.acquired_reset ddr_event_timer_ddr_init_done.event_reset reset

    add_connection ddr_event_timer_ddr_cal_success.acquired_reset system_reset_out.reset_in0 reset

    add_connection ddr_emif_status_breakout.cal_fail rec_ddr_cal_fail.reset_event reset

    add_connection ddr_emif_status_breakout.cal_fail master_reset_merge.reset_in2 reset

    add_connection system_in.clk_reset mm_bridge.reset reset

    add_connection system_in.clk_reset default_slave.reset reset

    add_connection system_in.clk_reset cpu_reset_n_reset_debouncer.s0_reset reset

    add_connection system_in.clk_reset ddr_pll_reset_monitor.s0_reset reset

    add_connection system_in.clk_reset ddr_event_timer_ddr_cal_success.s0_reset reset

    add_connection system_in.clk_reset ddr_event_timer_ddr_init_done.s0_reset reset

    add_connection system_in.clk_reset pll_pll_reset_monitor.s0_reset reset

    add_connection system_in.clk_reset rec_debug_resets.s0_reset reset

    add_connection system_in.clk_reset rec_cpu_reset_n.s0_reset reset

    add_connection system_in.clk_reset rec_ddr_lock_failure.s0_reset reset

    add_connection system_in.clk_reset rec_ddr_cal_fail.s0_reset reset

    add_connection system_in.clk_reset rec_ddr_lost_cal_success.s0_reset reset

    add_connection system_in.clk_reset rec_ddr_timeout_cal_success.s0_reset reset

    add_connection system_in.clk_reset rec_ddr_lost_init_done.s0_reset reset

    add_connection system_in.clk_reset rec_ddr_timeout_init_done.s0_reset reset

    add_connection system_in.clk_reset rec_pll_lock_failure.s0_reset reset

    add_connection ddr_pll_reset_monitor.lock_failure_reset rec_ddr_lock_failure.reset_event reset

    add_connection pll_pll_reset_monitor.lock_failure_reset rec_pll_lock_failure.reset_event reset

    add_connection ddr_pll_reset_monitor.lock_failure_reset master_reset_merge.reset_in1 reset

    add_connection pll_pll_reset_monitor.lock_failure_reset master_reset_merge.reset_in7 reset

    add_connection ddr_pll_reset_monitor.lock_success_reset ddr_soft_reset.reset_in2 reset

    add_connection pll_pll_reset_monitor.lock_success_reset ddr_soft_reset.reset_in3 reset

    add_connection ddr_event_timer_ddr_cal_success.lost_reset rec_ddr_lost_cal_success.reset_event reset

    add_connection ddr_event_timer_ddr_init_done.lost_reset rec_ddr_lost_init_done.reset_event reset

    add_connection ddr_event_timer_ddr_cal_success.lost_reset master_reset_merge.reset_in3 reset

    add_connection ddr_event_timer_ddr_init_done.lost_reset master_reset_merge.reset_in5 reset

    add_connection ddr_afi_reset.out_reset ddr_event_timer_ddr_cal_success.event_reset reset

    add_connection debug_resets.out_reset rec_debug_resets.reset_event reset

    add_connection debug_resets.out_reset ddr_soft_reset.reset_in0 reset

    add_connection cpu_reset_n.out_reset cpu_reset_n_reset_debouncer.reset_input reset

    add_connection ddr_pll_reset_monitor.pll_reset ddr_reset_out.reset_in0 reset

    add_connection pll_pll_reset_monitor.pll_reset pll_reset_out.reset_in0 reset

    add_connection power_on_reset_0.reset master_reset.power_on_reset reset

    add_connection power_on_reset_0.reset cpu_reset_n_reset_debouncer.power_on_reset reset

    add_connection power_on_reset_0.reset rec_debug_resets.power_on_reset reset

    add_connection power_on_reset_0.reset rec_cpu_reset_n.power_on_reset reset

    add_connection power_on_reset_0.reset rec_ddr_lock_failure.power_on_reset reset

    add_connection power_on_reset_0.reset rec_ddr_cal_fail.power_on_reset reset

    add_connection power_on_reset_0.reset rec_ddr_lost_cal_success.power_on_reset reset

    add_connection power_on_reset_0.reset rec_ddr_timeout_cal_success.power_on_reset reset

    add_connection power_on_reset_0.reset rec_ddr_lost_init_done.power_on_reset reset

    add_connection power_on_reset_0.reset rec_ddr_timeout_init_done.power_on_reset reset

    add_connection power_on_reset_0.reset rec_pll_lock_failure.power_on_reset reset

    add_connection master_reset_merge.reset_out master_reset.reset_input reset

    add_connection cpu_reset_n_reset_debouncer.reset_output rec_cpu_reset_n.reset_event reset

    add_connection cpu_reset_n_reset_debouncer.reset_output master_reset_merge.reset_in0 reset

    add_connection master_reset.reset_output ddr_soft_reset.reset_in1 reset

    add_connection master_reset.reset_output_delayed pll_pll_reset_monitor.pll_reset_request reset

    add_connection master_reset.reset_output_delayed ddr_pll_reset_monitor.pll_reset_request reset

    add_connection ddr_event_timer_ddr_cal_success.timeout_reset rec_ddr_timeout_cal_success.reset_event reset

    add_connection ddr_event_timer_ddr_init_done.timeout_reset rec_ddr_timeout_init_done.reset_event reset

    add_connection ddr_event_timer_ddr_cal_success.timeout_reset master_reset_merge.reset_in4 reset

    add_connection ddr_event_timer_ddr_init_done.timeout_reset master_reset_merge.reset_in6 reset

    # exported interfaces
    add_interface cpu_reset_n_in_reset reset sink
    set_interface_property cpu_reset_n_in_reset EXPORT_OF cpu_reset_n.in_reset
    add_interface ddr_afi_reset_in_reset reset sink
    set_interface_property ddr_afi_reset_in_reset EXPORT_OF ddr_afi_reset.in_reset
    add_interface ddr_emif_status_breakout_status conduit end
    set_interface_property ddr_emif_status_breakout_status EXPORT_OF ddr_emif_status_breakout.status
    add_interface ddr_pll_sharing_to_pll_locked_pll_sharing conduit end
    set_interface_property ddr_pll_sharing_to_pll_locked_pll_sharing EXPORT_OF ddr_pll_sharing_to_pll_locked.pll_sharing
    add_interface ddr_ref_clk_in_clk clock sink
    set_interface_property ddr_ref_clk_in_clk EXPORT_OF ddr_ref_clk.in_clk
    add_interface ddr_reset_out_reset_out reset source
    set_interface_property ddr_reset_out_reset_out EXPORT_OF ddr_reset_out.reset_out
    add_interface ddr_soft_reset_reset_out reset source
    set_interface_property ddr_soft_reset_reset_out EXPORT_OF ddr_soft_reset.reset_out
    add_interface debug_resets_in_reset reset sink
    set_interface_property debug_resets_in_reset EXPORT_OF debug_resets.in_reset
    add_interface mm_bridge_s0 avalon slave
    set_interface_property mm_bridge_s0 EXPORT_OF mm_bridge.s0
    add_interface pll_pll_reset_monitor_pll_locked conduit end
    set_interface_property pll_pll_reset_monitor_pll_locked EXPORT_OF pll_pll_reset_monitor.pll_locked
    add_interface pll_ref_clk_in_clk clock sink
    set_interface_property pll_ref_clk_in_clk EXPORT_OF pll_ref_clk.in_clk
    add_interface pll_reset_out_reset_out reset source
    set_interface_property pll_reset_out_reset_out EXPORT_OF pll_reset_out.reset_out
    add_interface system_in_clk clock sink
    set_interface_property system_in_clk EXPORT_OF system_in.clk_in
    add_interface system_in_reset reset sink
    set_interface_property system_in_reset EXPORT_OF system_in.clk_in_reset
    add_interface system_reset_out_reset_out reset source
    set_interface_property system_reset_out_reset_out EXPORT_OF system_reset_out.reset_out

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
}

create_qsys_system

save_system {reset_subsys.qsys}

