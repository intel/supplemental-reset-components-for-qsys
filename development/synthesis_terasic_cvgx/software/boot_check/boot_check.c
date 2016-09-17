/*
 * Copyright (c) 2016 Intel Corporation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */
#include "sys/alt_stdio.h"
#include "alt_types.h"
#include "system.h"
#include "altera_avalon_sysid_qsys_regs.h"
#include "altera_avalon_jtag_uart_regs.h"
#include "altera_avalon_pio_regs.h"
#include "reset_debouncer_regs.h"
#include "pll_reset_monitor_regs.h"
#include "event_timer_regs.h"
#include "reset_event_counter_regs.h"
#include "sys/alt_timestamp.h"
#include "test_sys_reset_modules_assignments.h"

void blink_led(alt_u32 blink_time)
{
	if(alt_timestamp() >= blink_time) {
		IOWR_ALTERA_AVALON_PIO_DATA(LED_PIO_OUT_BASE, IORD_ALTERA_AVALON_PIO_DATA(LED_PIO_OUT_BASE) ^ 0x01);
		alt_timestamp_start();
	}
}

void jtag_uart_wait_empty(alt_u32 blink_time)
{
	alt_u32 jtag_uart_current_wspace;

	do {
		blink_led(blink_time);
		jtag_uart_current_wspace = (IORD_ALTERA_AVALON_JTAG_UART_CONTROL(JTAG_UART_BASE) &
									ALTERA_AVALON_JTAG_UART_CONTROL_WSPACE_MSK) >>
									ALTERA_AVALON_JTAG_UART_CONTROL_WSPACE_OFST;
	} while(JTAG_UART_WRITE_DEPTH != jtag_uart_current_wspace);
}

int main()
{
	alt_u32 debouncer_reg;
	alt_u32 debounce_count;
	alt_u32 deassertion_edge_count;
	alt_u32 assertion_edge_count;

	alt_u32 event_timer_ddr_cal_success_reg;
	alt_u32 event_timer_ddr_init_done_reg;

	alt_u32 ddr_pll_reset_monitor_reg;
	alt_u32 ddr_prm_capture_lock_count;
	alt_u32 ddr_prm_lock_counter_width;
	alt_u32 ddr_prm_unlock_count;

	alt_u32 pll_pll_reset_monitor_reg;
	alt_u32 pll_prm_capture_lock_count;
	alt_u32 pll_prm_lock_counter_width;
	alt_u32 pll_prm_unlock_count;

	alt_u32 sysid_id_reg;
	alt_u32 sysid_ts_reg;

	alt_u32 timestamp_quarter_second;
	alt_u32 timestamp_eigth_second;

	alt_u32 reset_event_counter_value;
	alt_u32 rec_assertion_value;
	alt_u32 rec_deassertion_value;

	//
	// start the timestamp timer
	//
	alt_timestamp_start();
	timestamp_quarter_second = alt_timestamp_freq() / 4;
	timestamp_eigth_second = alt_timestamp_freq() / 8;

	//
	// announce that we're alive
	//
	alt_putstr("Nios II booting...\n");


	//
	// extract the sysid values
	//
	sysid_id_reg = IORD_ALTERA_AVALON_SYSID_QSYS_ID(SYSID_BASE);
	sysid_ts_reg = IORD_ALTERA_AVALON_SYSID_QSYS_TIMESTAMP(SYSID_BASE);
	if(SYSID_ID == sysid_id_reg) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_putstr("\nExpected SYSID value found...\n");
	} else {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_putstr("\nERROR: Found unexpected SYSID value...\n");
	}
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("HW SYSID = 0x%x\n", sysid_id_reg);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("SW SYSID = 0x%x\n", SYSID_ID);

	if(SYSID_TIMESTAMP == sysid_ts_reg) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_putstr("\nExpected TIMESTAMP value found...\n");
	} else {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_putstr("\nERROR: Found unexpected TIMESTAMP value...\n");
	}
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("HW TIMESTAMP = 0x%x\n", sysid_ts_reg);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("SW TIMESTAMP = 0x%x\n", SYSID_TIMESTAMP);

	//
	// extract the debouncer values
	//
	debouncer_reg = IORD_RESET_DEBOUNCER(RESETS_CPU_RESET_N_RESET_DEBOUNCER_BASE);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("\ndebouncer_reg = 0x%x\n", debouncer_reg);

	debounce_count = (debouncer_reg & RESET_DEBOUNCER_CAPTURE_DEBOUNCE_COUNT_MASK) >> RESET_DEBOUNCER_CAPTURE_DEBOUNCE_COUNT_OFST;
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("debounce_count = 0x%x\n", debounce_count);

	deassertion_edge_count = (debouncer_reg & RESET_DEBOUNCER_DEASSERTION_EDGE_COUNT_MASK) >> RESET_DEBOUNCER_DEASSERTION_EDGE_COUNT_OFST;
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("deassertion_edge_count = 0x%x\n", deassertion_edge_count);

	assertion_edge_count = (debouncer_reg & RESET_DEBOUNCER_ASSERTION_EDGE_COUNT_MASK) >> RESET_DEBOUNCER_ASSERTION_EDGE_COUNT_OFST;
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("assertion_edge_count = 0x%x\n", assertion_edge_count);

	//
	// extract the ddr_cal_success event timer values
	//
	event_timer_ddr_cal_success_reg = IORD_EVENT_TIMER(RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_BASE);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("\nevent_timer_ddr_cal_success_reg = 0x%x\n", event_timer_ddr_cal_success_reg);

	//
	// extract the ddr_init_done event timer values
	//
	event_timer_ddr_init_done_reg = IORD_EVENT_TIMER(RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_BASE);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("\nevent_timer_ddr_init_done_reg = 0x%x\n", event_timer_ddr_init_done_reg);

	//
	// extract the ddr pll reset monitor values
	//
	ddr_pll_reset_monitor_reg = IORD_PLL_RESET_MONITOR(RESETS_DDR_PLL_RESET_MONITOR_BASE);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("\nddr_pll_reset_monitor_reg = 0x%x\n", ddr_pll_reset_monitor_reg);
	ddr_prm_capture_lock_count = (ddr_pll_reset_monitor_reg & PLL_RESET_MONITOR_CAPTURE_LOCK_COUNT_MASK) >> PLL_RESET_MONITOR_CAPTURE_LOCK_COUNT_OFST;
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("ddr_prm_capture_lock_count = 0x%x\n", ddr_prm_capture_lock_count);
	ddr_prm_lock_counter_width = (ddr_pll_reset_monitor_reg & PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH_MASK) >> PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH_OFST;
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("ddr_prm_lock_counter_width = 0x%x\n", ddr_prm_lock_counter_width);
	ddr_prm_unlock_count = (ddr_pll_reset_monitor_reg & PLL_RESET_MONITOR_UNLOCK_COUNT_MASK) >> PLL_RESET_MONITOR_UNLOCK_COUNT_OFST;
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("ddr_prm_unlock_count = 0x%x\n", ddr_prm_unlock_count);

	//
	// extract the pll pll reset monitor values
	//
	pll_pll_reset_monitor_reg = IORD_PLL_RESET_MONITOR(RESETS_PLL_PLL_RESET_MONITOR_BASE);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("\npll_pll_reset_monitor_reg = 0x%x\n", pll_pll_reset_monitor_reg);
	pll_prm_capture_lock_count = (pll_pll_reset_monitor_reg & PLL_RESET_MONITOR_CAPTURE_LOCK_COUNT_MASK) >> PLL_RESET_MONITOR_CAPTURE_LOCK_COUNT_OFST;
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("pll_prm_capture_lock_count = 0x%x\n", pll_prm_capture_lock_count);
	pll_prm_lock_counter_width = (pll_pll_reset_monitor_reg & PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH_MASK) >> PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH_OFST;
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("pll_prm_lock_counter_width = 0x%x\n", pll_prm_lock_counter_width);
	pll_prm_unlock_count = (pll_pll_reset_monitor_reg & PLL_RESET_MONITOR_UNLOCK_COUNT_MASK) >> PLL_RESET_MONITOR_UNLOCK_COUNT_OFST;
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("pll_prm_unlock_count = 0x%x\n", pll_prm_unlock_count);

	//
	// extract the reset event counter values
	//
	reset_event_counter_value = IORD_RESET_EVENT_COUNTER(RESETS_REC_CPU_RESET_N_BASE);
	rec_assertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_ASSERT_COUNT_OFST;
	rec_deassertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST;
	rec_assertion_value &= ((1 << RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1);
	rec_deassertion_value &= ((1 << RESETS_REC_CPU_RESET_N_COUNTER_WIDTH) -1);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\nCPU_RESET_N\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("    deassertion = 0x%x\n", rec_deassertion_value);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("      assertion = 0x%x\n", rec_assertion_value);

	reset_event_counter_value = IORD_RESET_EVENT_COUNTER(RESETS_REC_DDR_CAL_FAIL_BASE);
	rec_assertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_ASSERT_COUNT_OFST;
	rec_deassertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST;
	rec_assertion_value &= ((1 << RESETS_REC_DDR_CAL_FAIL_COUNTER_WIDTH) -1);
	rec_deassertion_value &= ((1 << RESETS_REC_DDR_CAL_FAIL_COUNTER_WIDTH) -1);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\nDDR_CAL_FAIL\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("    deassertion = 0x%x\n", rec_deassertion_value);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("      assertion = 0x%x\n", rec_assertion_value);

	reset_event_counter_value = IORD_RESET_EVENT_COUNTER(RESETS_REC_DDR_LOCK_FAILURE_BASE);
	rec_assertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_ASSERT_COUNT_OFST;
	rec_deassertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST;
	rec_assertion_value &= ((1 << RESETS_REC_DDR_LOCK_FAILURE_COUNTER_WIDTH) -1);
	rec_deassertion_value &= ((1 << RESETS_REC_DDR_LOCK_FAILURE_COUNTER_WIDTH) -1);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\nDDR_LOCK_FAILURE\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("    deassertion = 0x%x\n", rec_deassertion_value);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("      assertion = 0x%x\n", rec_assertion_value);

	reset_event_counter_value = IORD_RESET_EVENT_COUNTER(RESETS_REC_DDR_LOST_CAL_SUCCESS_BASE);
	rec_assertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_ASSERT_COUNT_OFST;
	rec_deassertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST;
	rec_assertion_value &= ((1 << RESETS_REC_DDR_LOST_CAL_SUCCESS_COUNTER_WIDTH) -1);
	rec_deassertion_value &= ((1 << RESETS_REC_DDR_LOST_CAL_SUCCESS_COUNTER_WIDTH) -1);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\nDDR_LOST_CAL_SUCCESS\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("    deassertion = 0x%x\n", rec_deassertion_value);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("      assertion = 0x%x\n", rec_assertion_value);

	reset_event_counter_value = IORD_RESET_EVENT_COUNTER(RESETS_REC_DDR_LOST_INIT_DONE_BASE);
	rec_assertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_ASSERT_COUNT_OFST;
	rec_deassertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST;
	rec_assertion_value &= ((1 << RESETS_REC_DDR_LOST_INIT_DONE_COUNTER_WIDTH) -1);
	rec_deassertion_value &= ((1 << RESETS_REC_DDR_LOST_INIT_DONE_COUNTER_WIDTH) -1);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\nDDR_LOST_INIT_DONE\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("    deassertion = 0x%x\n", rec_deassertion_value);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("      assertion = 0x%x\n", rec_assertion_value);

	reset_event_counter_value = IORD_RESET_EVENT_COUNTER(RESETS_REC_DDR_TIMEOUT_CAL_SUCCESS_BASE);
	rec_assertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_ASSERT_COUNT_OFST;
	rec_deassertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST;
	rec_assertion_value &= ((1 << RESETS_REC_DDR_TIMEOUT_CAL_SUCCESS_COUNTER_WIDTH) -1);
	rec_deassertion_value &= ((1 << RESETS_REC_DDR_TIMEOUT_CAL_SUCCESS_COUNTER_WIDTH) -1);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\nDDR_TIMEOUT_CAL_SUCCESS\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("    deassertion = 0x%x\n", rec_deassertion_value);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("      assertion = 0x%x\n", rec_assertion_value);

	reset_event_counter_value = IORD_RESET_EVENT_COUNTER(RESETS_REC_DDR_TIMEOUT_INIT_DONE_BASE);
	rec_assertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_ASSERT_COUNT_OFST;
	rec_deassertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST;
	rec_assertion_value &= ((1 << RESETS_REC_DDR_TIMEOUT_INIT_DONE_COUNTER_WIDTH) -1);
	rec_deassertion_value &= ((1 << RESETS_REC_DDR_TIMEOUT_INIT_DONE_COUNTER_WIDTH) -1);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\nDDR_TIMEOUT_INIT_DONE\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("    deassertion = 0x%x\n", rec_deassertion_value);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("      assertion = 0x%x\n", rec_assertion_value);

	reset_event_counter_value = IORD_RESET_EVENT_COUNTER(RESETS_REC_DEBUG_RESETS_BASE);
	rec_assertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_ASSERT_COUNT_OFST;
	rec_deassertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST;
	rec_assertion_value &= ((1 << RESETS_REC_DEBUG_RESETS_COUNTER_WIDTH) -1);
	rec_deassertion_value &= ((1 << RESETS_REC_DEBUG_RESETS_COUNTER_WIDTH) -1);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\nDEBUG_RESETS\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("    deassertion = 0x%x\n", rec_deassertion_value);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("      assertion = 0x%x\n", rec_assertion_value);

	reset_event_counter_value = IORD_RESET_EVENT_COUNTER(RESETS_REC_PLL_LOCK_FAILURE_BASE);
	rec_assertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_ASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_ASSERT_COUNT_OFST;
	rec_deassertion_value = (reset_event_counter_value & RESET_EVENT_COUNTER_DEASSERT_COUNT_MASK) >> RESET_EVENT_COUNTER_DEASSERT_COUNT_OFST;
	rec_assertion_value &= ((1 << RESETS_REC_PLL_LOCK_FAILURE_COUNTER_WIDTH) -1);
	rec_deassertion_value &= ((1 << RESETS_REC_PLL_LOCK_FAILURE_COUNTER_WIDTH) -1);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\nPLL_LOCK_FAILURE\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("    deassertion = 0x%x\n", rec_deassertion_value);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("      assertion = 0x%x\n", rec_assertion_value);

	//
	// print reset modules assignments
	//
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\nRESET MODULES ASSIGNMENTS\n\n");
	if(
			(RMA_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_CONDUIT != 0) ||
			(RMA_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_INTERRUPT != 0) ||
			(RMA_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_RESET != 0) ||
			(RMA_DEFAULT_SLAVE_ENABLE_CLEAR_EVENT != 0) ||
			(RMA_DEFAULT_SLAVE_ENABLE_READ_RESPONSE != 0) ||
			(RMA_DEFAULT_SLAVE_ENABLE_WRITE_RESPONSE != 0)
		) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DEFAULT_SLAVE has extra features enabled.\n");
	} else {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DEFAULT_SLAVE has NO extra features enabled.\n");
	}
	if(RMA_DEFAULT_SLAVE_NEVER_RESPOND != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DEFAULT_SLAVE asserts waitrequest never.\n");
	} else {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DEFAULT_SLAVE asserts waitrequest when accessed.\n");
	}
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("DEFAULT_SLAVE is 0x%x byte(s) wide.\n", RMA_DEFAULT_SLAVE_DATA_BYTES);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("DEFAULT_SLAVE read data pattern is 0x%x.\n", RMA_DEFAULT_SLAVE_READ_DATA_PATTERN);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("DEFAULT_SLAVE response pattern is 0x%x.\n", RMA_DEFAULT_SLAVE_RESPONSE_PATTERN);

	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\n");
	if(
			(RMA_RESETS_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_CONDUIT != 0) ||
			(RMA_RESETS_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_INTERRUPT != 0) ||
			(RMA_RESETS_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_RESET != 0) ||
			(RMA_RESETS_DEFAULT_SLAVE_ENABLE_CLEAR_EVENT != 0) ||
			(RMA_RESETS_DEFAULT_SLAVE_ENABLE_READ_RESPONSE != 0) ||
			(RMA_RESETS_DEFAULT_SLAVE_ENABLE_WRITE_RESPONSE != 0)
		) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("RESETS_DEFAULT_SLAVE has extra features enabled.\n");
	} else {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("RESETS_DEFAULT_SLAVE has NO extra features enabled.\n");
	}
	if(RMA_RESETS_DEFAULT_SLAVE_NEVER_RESPOND != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("RESETS_DEFAULT_SLAVE asserts waitrequest never.\n");
	} else {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("RESETS_DEFAULT_SLAVE asserts waitrequest when accessed.\n");
	}
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("RESETS_DEFAULT_SLAVE is 0x%x byte(s) wide.\n", RMA_RESETS_DEFAULT_SLAVE_DATA_BYTES);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("RESETS_DEFAULT_SLAVE read data pattern is 0x%x.\n", RMA_RESETS_DEFAULT_SLAVE_READ_DATA_PATTERN);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("RESETS_DEFAULT_SLAVE response pattern is 0x%x.\n", RMA_RESETS_DEFAULT_SLAVE_RESPONSE_PATTERN);

	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\n");
	if(
			(RMA_SLOW_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_CONDUIT != 0) ||
			(RMA_SLOW_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_INTERRUPT != 0) ||
			(RMA_SLOW_DEFAULT_SLAVE_ENABLE_ACCESS_EVENT_RESET != 0) ||
			(RMA_SLOW_DEFAULT_SLAVE_ENABLE_CLEAR_EVENT != 0) ||
			(RMA_SLOW_DEFAULT_SLAVE_ENABLE_READ_RESPONSE != 0) ||
			(RMA_SLOW_DEFAULT_SLAVE_ENABLE_WRITE_RESPONSE != 0)
		) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("SLOW_DEFAULT_SLAVE has extra features enabled.\n");
	} else {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("SLOW_DEFAULT_SLAVE has NO extra features enabled.\n");
	}
	if(RMA_SLOW_DEFAULT_SLAVE_NEVER_RESPOND != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("SLOW_DEFAULT_SLAVE asserts waitrequest never.\n");
	} else {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("SLOW_DEFAULT_SLAVE asserts waitrequest when accessed.\n");
	}
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("SLOW_DEFAULT_SLAVE is 0x%x byte(s) wide.\n", RMA_SLOW_DEFAULT_SLAVE_DATA_BYTES);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("SLOW_DEFAULT_SLAVE read data pattern is 0x%x.\n", RMA_SLOW_DEFAULT_SLAVE_READ_DATA_PATTERN);
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("SLOW_DEFAULT_SLAVE response pattern is 0x%x.\n", RMA_SLOW_DEFAULT_SLAVE_RESPONSE_PATTERN);

	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("Power on reset duration is 0x%x ns.\n",
			(1000000000 / RMA_RESETS_POWER_ON_RESET_0_CLOCK_FREQ) *
			(RMA_RESETS_POWER_ON_RESET_0_POR_COUNT));

	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("CPU_RESET_N debouncer duration is 0x%x ns.\n",
			(1000000000 / RMA_RESETS_CPU_RESET_N_RESET_DEBOUNCER_CLOCK_FREQ) *
			(1 << RMA_RESETS_CPU_RESET_N_RESET_DEBOUNCER_DEBOUNCE_COUNTER_WIDTH));

	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("Master Reset assertion delay duration is 0x%x ns.\n",
			(1000000000 / RMA_RESETS_MASTER_RESET_CLOCK_FREQ) *
			(1 << RMA_RESETS_MASTER_RESET_DELAY_COUNTER_WIDTH));

	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("PLL Reset Monitor reset duration is 0x%x ns.\n",
			(1000000000 / RMA_RESETS_PLL_PLL_RESET_MONITOR_CLOCK_FREQ) *
			(1 << RMA_RESETS_PLL_PLL_RESET_MONITOR_RESET_COUNTER_WIDTH));
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("PLL Reset Monitor lock duration is 0x%x ns.\n",
			(1000000000 / RMA_RESETS_PLL_PLL_RESET_MONITOR_CLOCK_FREQ) *
			(1 << RMA_RESETS_PLL_PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH));
	if(RMA_RESETS_PLL_PLL_RESET_MONITOR_ENABLE_LOCK_FAILURE_CONDUIT != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("PLL Reset Monitor lock failure conduit is enabled.\n");
	}
	if(RMA_RESETS_PLL_PLL_RESET_MONITOR_ENABLE_LOCK_FAILURE_RESET != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("PLL Reset Monitor lock failure reset is enabled.\n");
	}
	if(RMA_RESETS_PLL_PLL_RESET_MONITOR_ENABLE_LOCK_SUCCESS_CONDUIT != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("PLL Reset Monitor lock success conduit is enabled.\n");
	}
	if(RMA_RESETS_PLL_PLL_RESET_MONITOR_ENABLE_LOCK_SUCCESS_RESET != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("PLL Reset Monitor lock success reset is enabled.\n");
	}

	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("DDR PLL Reset Monitor reset duration is 0x%x ns.\n",
			(1000000000 / RMA_RESETS_DDR_PLL_RESET_MONITOR_CLOCK_FREQ) *
			(1 << RMA_RESETS_DDR_PLL_RESET_MONITOR_RESET_COUNTER_WIDTH));
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("DDR PLL Reset Monitor lock duration is 0x%x ns.\n",
			(1000000000 / RMA_RESETS_DDR_PLL_RESET_MONITOR_CLOCK_FREQ) *
			(1 << RMA_RESETS_DDR_PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH));
	if(RMA_RESETS_DDR_PLL_RESET_MONITOR_ENABLE_LOCK_FAILURE_CONDUIT != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR PLL Reset Monitor lock failure conduit is enabled.\n");
	}
	if(RMA_RESETS_DDR_PLL_RESET_MONITOR_ENABLE_LOCK_FAILURE_RESET != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR PLL Reset Monitor lock failure reset is enabled.\n");
	}
	if(RMA_RESETS_DDR_PLL_RESET_MONITOR_ENABLE_LOCK_SUCCESS_CONDUIT != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR PLL Reset Monitor lock success conduit is enabled.\n");
	}
	if(RMA_RESETS_DDR_PLL_RESET_MONITOR_ENABLE_LOCK_SUCCESS_RESET != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR PLL Reset Monitor lock success reset is enabled.\n");
	}

	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("DDR calibration success timeout duration is 0x%x ns.\n",
			(1000000000 / RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_CLOCK_FREQ) *
			(1 << RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_TIMEOUT_COUNTER_WIDTH));
	if(RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_ENABLE_ACQUIRED_CONDUIT != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR calibration success acquired conduit is enabled.\n");
	}
	if(RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_ENABLE_ACQUIRED_RESET != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR calibration success acquired reset is enabled.\n");
	}
	if(RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_ENABLE_LOST_CONDUIT != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR calibration success lost conduit is enabled.\n");
	}
	if(RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_ENABLE_LOST_RESET != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR calibration success lost reset is enabled.\n");
	}
	if(RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_ENABLE_TIMEOUT_CONDUIT != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR calibration success timeout conduit is enabled.\n");
	}
	if(RMA_RESETS_DDR_EVENT_TIMER_DDR_CAL_SUCCESS_ENABLE_TIMEOUT_RESET != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR calibration success timeout reset is enabled.\n");
	}

	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_putstr("\n");
	jtag_uart_wait_empty(timestamp_quarter_second);
	alt_printf("DDR init done timeout duration is 0x%x ns.\n",
			(1000000000 / RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_CLOCK_FREQ) *
			(1 << RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_TIMEOUT_COUNTER_WIDTH));
	if(RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_ENABLE_ACQUIRED_CONDUIT != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR init done acquired conduit is enabled.\n");
	}
	if(RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_ENABLE_ACQUIRED_RESET != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR init done acquired reset is enabled.\n");
	}
	if(RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_ENABLE_LOST_CONDUIT != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR init done lost conduit is enabled.\n");
	}
	if(RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_ENABLE_LOST_RESET != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR init done lost reset is enabled.\n");
	}
	if(RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_ENABLE_TIMEOUT_CONDUIT != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR init done timeout conduit is enabled.\n");
	}
	if(RMA_RESETS_DDR_EVENT_TIMER_DDR_INIT_DONE_ENABLE_TIMEOUT_RESET != 0) {
		jtag_uart_wait_empty(timestamp_quarter_second);
		alt_printf("DDR init done timeout reset is enabled.\n");
	}

	//
	// enter infinite loop
	//
	while (1)
		blink_led(timestamp_eigth_second);

	return 0;
}
