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
`timescale 1 ps / 1 ps

`define VERBOSITY VERBOSITY_INFO

`define TEST_SYS_INST		sim_top.tb.test_sys_inst
`define LOCK_FAIURE_BFM		sim_top.tb.test_sys_inst_prm_lock_failure_bfm
`define LOCK_SUCCESS_BFM	sim_top.tb.test_sys_inst_prm_lock_success_bfm
`define PLL_LOCKED_BFM		sim_top.tb.test_sys_inst_prm_pll_locked_bfm
`define PLL_RESET_REQUEST_BFM	sim_top.tb.test_sys_inst_prm_pll_reset_request_bfm
`define SLAVE_S0_BFM		sim_top.tb.test_sys_inst_prm_s0_bfm
`define SLAVE_S0_RESET_BFM	sim_top.tb.test_sys_inst_prm_s0_reset_bfm

module sim_driver();

import verbosity_pkg::*;
import avalon_mm_pkg::*;

string message;

initial begin
	#18_150_001;
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

reg test_success;
reg [31:0] next_expected_value;

initial begin

	test_success <= 1'b1;

	set_verbosity( `VERBOSITY );

	`SLAVE_S0_BFM.set_response_timeout(5);
	`SLAVE_S0_BFM.set_command_timeout(5);
	`SLAVE_S0_BFM.init();

	`PLL_LOCKED_BFM.set_pll_locked(1'b0);

	//wait for reset to de-assert
	wait(`TEST_SYS_INST.prm_pll_reset_reset == 1'b0);

	// detect a lock success with stutter
	for(int i = 0 ; i < 128 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`PLL_LOCKED_BFM.set_pll_locked(1'b1);

	@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);
	`PLL_LOCKED_BFM.set_pll_locked(1'b0);
	@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);
	`PLL_LOCKED_BFM.set_pll_locked(1'b1);
	for(int i = 0 ; i < 5 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`PLL_LOCKED_BFM.set_pll_locked(1'b0);
	@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);
	`PLL_LOCKED_BFM.set_pll_locked(1'b1);
	for(int i = 0 ; i < 5 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`PLL_LOCKED_BFM.set_pll_locked(1'b0);
	@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);
	`PLL_LOCKED_BFM.set_pll_locked(1'b1);
	for(int i = 0 ; i < 5 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`PLL_LOCKED_BFM.set_pll_locked(1'b0);
	@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);
	`PLL_LOCKED_BFM.set_pll_locked(1'b1);
	for(int i = 0 ; i < 5 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	wait(	(`TEST_SYS_INST.prm_lock_failure_lock_failure &&
		`TEST_SYS_INST.prm_lock_failure_reset_reset_n) ||
		(`TEST_SYS_INST.prm_lock_success_lock_success &&
		`TEST_SYS_INST.prm_lock_success_reset_reset_n));

	for(int i = 0 ; i < 4 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`SLAVE_S0_BFM.set_command_address(0);
	`SLAVE_S0_BFM.set_command_byte_enable('hF, 0);
	`SLAVE_S0_BFM.set_command_burst_count('h1);
	`SLAVE_S0_BFM.set_command_burst_size('h1);
	`SLAVE_S0_BFM.set_command_data('h0, 0);
	`SLAVE_S0_BFM.set_command_idle(0, 0);
	`SLAVE_S0_BFM.set_command_init_latency(0);
	`SLAVE_S0_BFM.set_command_request(REQ_READ);
	`SLAVE_S0_BFM.push_command();

	while(`SLAVE_S0_BFM.get_response_queue_size() == 0)
		@(posedge `TEST_SYS_INST.prm_s0_clk_clk);

	`SLAVE_S0_BFM.pop_response();

	next_expected_value = 32'h0340009C;
	if(`SLAVE_S0_BFM.get_response_data(0) == next_expected_value) begin
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `SLAVE_S0_BFM.get_response_data(0));
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "EXPECTED READ RESPONSE DATA = 0x%08X", next_expected_value);
		print(VERBOSITY_ERROR, message);
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `SLAVE_S0_BFM.get_response_data(0));
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	if(`TEST_SYS_INST.prm_lock_success_lock_success) begin
		$sformat(message, "Lock Success detected successfully...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Errant Lock Failure detected...");
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	// detect a lock failure with stutter
	@(posedge `TEST_SYS_INST.prm_s0_clk_clk);

	`PLL_RESET_REQUEST_BFM.reset_assert();

	@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`PLL_LOCKED_BFM.set_pll_locked(1'b0);
	`PLL_RESET_REQUEST_BFM.reset_deassert();

	for(int i = 0 ; i < 128 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`PLL_LOCKED_BFM.set_pll_locked(1'b1);

	@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);
	`PLL_LOCKED_BFM.set_pll_locked(1'b0);
	@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);
	`PLL_LOCKED_BFM.set_pll_locked(1'b1);
	for(int i = 0 ; i < 5 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`PLL_LOCKED_BFM.set_pll_locked(1'b0);
	@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);
	`PLL_LOCKED_BFM.set_pll_locked(1'b1);
	for(int i = 0 ; i < 5 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`PLL_LOCKED_BFM.set_pll_locked(1'b0);
	@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);
	`PLL_LOCKED_BFM.set_pll_locked(1'b1);
	for(int i = 0 ; i < 5 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`PLL_LOCKED_BFM.set_pll_locked(1'b0);
	@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);
	`PLL_LOCKED_BFM.set_pll_locked(1'b1);
	for(int i = 0 ; i < 5 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`PLL_LOCKED_BFM.set_pll_locked(1'b0);

	wait(	(`TEST_SYS_INST.prm_lock_failure_lock_failure &&
		`TEST_SYS_INST.prm_lock_failure_reset_reset_n) ||
		(`TEST_SYS_INST.prm_lock_success_lock_success &&
		`TEST_SYS_INST.prm_lock_success_reset_reset_n));

	for(int i = 0 ; i < 4 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`SLAVE_S0_BFM.set_command_address(0);
	`SLAVE_S0_BFM.set_command_byte_enable('hF, 0);
	`SLAVE_S0_BFM.set_command_burst_count('h1);
	`SLAVE_S0_BFM.set_command_burst_size('h1);
	`SLAVE_S0_BFM.set_command_data('h0, 0);
	`SLAVE_S0_BFM.set_command_idle(0, 0);
	`SLAVE_S0_BFM.set_command_init_latency(0);
	`SLAVE_S0_BFM.set_command_request(REQ_READ);
	`SLAVE_S0_BFM.push_command();

	while(`SLAVE_S0_BFM.get_response_queue_size() == 0)
		@(posedge `TEST_SYS_INST.prm_s0_clk_clk);

	`SLAVE_S0_BFM.pop_response();

	next_expected_value = 32'h04400088;
	if(`SLAVE_S0_BFM.get_response_data(0) == next_expected_value) begin
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `SLAVE_S0_BFM.get_response_data(0));
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "EXPECTED READ RESPONSE DATA = 0x%08X", next_expected_value);
		print(VERBOSITY_ERROR, message);
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `SLAVE_S0_BFM.get_response_data(0));
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	if(`TEST_SYS_INST.prm_lock_success_lock_success) begin
		$sformat(message, "Errant Lock Success detected...");
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end else begin
		$sformat(message, "Lock Failure detected successfully...");
		print(VERBOSITY_INFO, message);
	end

	// detect a lock success followed by a lock failure
	@(posedge `TEST_SYS_INST.prm_s0_clk_clk);

	`PLL_RESET_REQUEST_BFM.reset_assert();

	@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`PLL_LOCKED_BFM.set_pll_locked(1'b0);
	`PLL_RESET_REQUEST_BFM.reset_deassert();

	for(int i = 0 ; i < 128 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`PLL_LOCKED_BFM.set_pll_locked(1'b1);

	wait(	(`TEST_SYS_INST.prm_lock_failure_lock_failure &&
		`TEST_SYS_INST.prm_lock_failure_reset_reset_n) ||
		(`TEST_SYS_INST.prm_lock_success_lock_success &&
		`TEST_SYS_INST.prm_lock_success_reset_reset_n));

	for(int i = 0 ; i < 4 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	if(`TEST_SYS_INST.prm_lock_success_lock_success) begin
		$sformat(message, "Lock Success detected successfully...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Errant Lock Failure detected...");
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	`PLL_LOCKED_BFM.set_pll_locked(1'b0);

	for(int i = 0 ; i < 4 ; i++)
		@(posedge `TEST_SYS_INST.prm_pll_ref_clk_clk);

	`SLAVE_S0_BFM.set_command_address(0);
	`SLAVE_S0_BFM.set_command_byte_enable('hF, 0);
	`SLAVE_S0_BFM.set_command_burst_count('h1);
	`SLAVE_S0_BFM.set_command_burst_size('h1);
	`SLAVE_S0_BFM.set_command_data('h0, 0);
	`SLAVE_S0_BFM.set_command_idle(0, 0);
	`SLAVE_S0_BFM.set_command_init_latency(0);
	`SLAVE_S0_BFM.set_command_request(REQ_READ);
	`SLAVE_S0_BFM.push_command();

	while(`SLAVE_S0_BFM.get_response_queue_size() == 0)
		@(posedge `TEST_SYS_INST.prm_s0_clk_clk);

	`SLAVE_S0_BFM.pop_response();

	next_expected_value = 32'h00400074;
	if(`SLAVE_S0_BFM.get_response_data(0) == next_expected_value) begin
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `SLAVE_S0_BFM.get_response_data(0));
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "EXPECTED READ RESPONSE DATA = 0x%08X", next_expected_value);
		print(VERBOSITY_ERROR, message);
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `SLAVE_S0_BFM.get_response_data(0));
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	if(`TEST_SYS_INST.prm_lock_success_lock_success) begin
		$sformat(message, "Errant Lock Success detected...");
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end else begin
		$sformat(message, "Lock Failure detected successfully...");
		print(VERBOSITY_INFO, message);
	end

	@(posedge `TEST_SYS_INST.prm_s0_clk_clk);
	if(test_success == 1'b1) begin
		$sformat(message, "Test completed successfully...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Test failed...");
		print(VERBOSITY_ERROR, message);
	end

	$stop;

end // initial

always @ (*) begin
	if(	`TEST_SYS_INST.prm_s0_reset_reset == 1'b0 &&
		`TEST_SYS_INST.prm_pll_reset_reset == 1'b1 )
			`SLAVE_S0_RESET_BFM.reset_assert();

	if(	`TEST_SYS_INST.prm_s0_reset_reset == 1'b1 &&
		`TEST_SYS_INST.prm_pll_reset_reset == 1'b0 )
			`SLAVE_S0_RESET_BFM.reset_deassert();
end

endmodule

