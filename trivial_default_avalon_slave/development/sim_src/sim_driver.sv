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
`define RESET_BFM		sim_top.tb.test_sys_inst_reset_bfm
`define TDAS_0_BFM		sim_top.tb.test_sys_inst_tdas_0_none_slave_bfm
`define TDAS_1_BFM		sim_top.tb.test_sys_inst_tdas_1_slave_response_slave_bfm
`define TDAS_2_BFM		sim_top.tb.test_sys_inst_tdas_2_never_respond_slave_bfm
`define TDAS_3_BFM		sim_top.tb.test_sys_inst_tdas_3_access_events_slave_bfm
`define TDAS_3_CE_CONDUIT_BFM	sim_top.tb.test_sys_inst_tdas_3_access_events_clear_event_bfm
`define TDAS_4_BFM		sim_top.tb.test_sys_inst_tdas_4_32_bit_wide_slave_bfm
`define TDAS_5_BFM		sim_top.tb.test_sys_inst_tdas_5_never_respond_access_event_slave_bfm
`define TDAS_5_CE_CONDUIT_BFM	sim_top.tb.test_sys_inst_tdas_5_never_respond_access_event_clear_event_bfm
module sim_driver();

import verbosity_pkg::*;
import avalon_mm_pkg::*;

string message;

initial begin
	#5_650_001;
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

reg test_success;
reg [31:0] next_expected_readdata_32_value;
reg [7:0] next_expected_readdata_value;
reg [1:0] next_expected_response_value;
integer expected_time;
integer cur_time;

initial begin

	test_success <= 1'b1;

	set_verbosity( `VERBOSITY );

	`TDAS_0_BFM.set_response_timeout(5);
	`TDAS_0_BFM.set_command_timeout(5);
	`TDAS_0_BFM.init();

	`TDAS_1_BFM.set_response_timeout(5);
	`TDAS_1_BFM.set_command_timeout(5);
	`TDAS_1_BFM.init();

	`TDAS_2_BFM.set_response_timeout(0);
	`TDAS_2_BFM.set_command_timeout(0);
	`TDAS_2_BFM.init();

	`TDAS_3_BFM.set_response_timeout(5);
	`TDAS_3_BFM.set_command_timeout(5);
	`TDAS_3_BFM.init();

	`TDAS_3_CE_CONDUIT_BFM.set_clear_event(1'b0);
	`TDAS_5_CE_CONDUIT_BFM.set_clear_event(1'b0);

	//wait for reset to de-assert
	wait(`TEST_SYS_INST.reset_reset_n == 1'b1);
	for(int i = 0 ; i < 8 ; i++)
		@(posedge `TEST_SYS_INST.clk_clk);
	
	// TDAS_0 read
	`TDAS_0_BFM.set_command_address(0);
	`TDAS_0_BFM.set_command_byte_enable('hF, 0);
	`TDAS_0_BFM.set_command_burst_count('h1);
	`TDAS_0_BFM.set_command_burst_size('h1);
	`TDAS_0_BFM.set_command_data('h0, 0);
	`TDAS_0_BFM.set_command_idle(0, 0);
	`TDAS_0_BFM.set_command_init_latency(0);
	`TDAS_0_BFM.set_command_request(REQ_READ);
	`TDAS_0_BFM.push_command();

	while(`TDAS_0_BFM.get_response_queue_size() == 0)
		@(posedge `TEST_SYS_INST.clk_clk);

	`TDAS_0_BFM.pop_response();

	next_expected_readdata_value = 8'hE0;
	if(`TDAS_0_BFM.get_response_data(0) == next_expected_readdata_value) begin
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `TDAS_0_BFM.get_response_data(0));
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "EXPECTED READ RESPONSE DATA = 0x%08X", next_expected_readdata_value);
		print(VERBOSITY_ERROR, message);
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `TDAS_0_BFM.get_response_data(0));
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	expected_time = 'd1_230_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Response received at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Response received at UNEXPECTED time: %d : %d", cur_time, expected_time);
	                print(VERBOSITY_ERROR, message);
	                test_success <= 1'b0;
	end

	// TDAS_0 write
	`TDAS_0_BFM.set_command_address(0);
	`TDAS_0_BFM.set_command_byte_enable('hF, 0);
	`TDAS_0_BFM.set_command_burst_count('h1);
	`TDAS_0_BFM.set_command_burst_size('h1);
	`TDAS_0_BFM.set_command_data('hAA, 0);
	`TDAS_0_BFM.set_command_idle(0, 0);
	`TDAS_0_BFM.set_command_init_latency(0);
	`TDAS_0_BFM.set_command_request(REQ_WRITE);
	`TDAS_0_BFM.push_command();

	while(`TDAS_0_BFM.get_response_queue_size() == 0)
		@(posedge `TEST_SYS_INST.clk_clk);

	`TDAS_0_BFM.pop_response();

	expected_time = 'd1_290_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Response received at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Response received at UNEXPECTED time: %d : %d", cur_time, expected_time);
	                print(VERBOSITY_ERROR, message);
	                test_success <= 1'b0;
	end

	// TDAS_0 read 4, write 4, read-write 4
	`TDAS_0_BFM.set_command_address(0);
	`TDAS_0_BFM.set_command_byte_enable('hF, 0);
	`TDAS_0_BFM.set_command_burst_count('h1);
	`TDAS_0_BFM.set_command_burst_size('h1);
	`TDAS_0_BFM.set_command_data('h0, 0);
	`TDAS_0_BFM.set_command_idle(0, 0);
	`TDAS_0_BFM.set_command_init_latency(0);
	`TDAS_0_BFM.set_command_request(REQ_READ);
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.push_command();

	`TDAS_0_BFM.set_command_request(REQ_WRITE);
	`TDAS_0_BFM.set_command_data('hA1, 0);
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.set_command_data('hA2, 0);
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.set_command_data('hA3, 0);
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.set_command_data('hA4, 0);
	`TDAS_0_BFM.push_command();

	`TDAS_0_BFM.set_command_request(REQ_READ);
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.set_command_request(REQ_WRITE);
	`TDAS_0_BFM.set_command_data('hA5, 0);
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.set_command_request(REQ_READ);
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.set_command_request(REQ_WRITE);
	`TDAS_0_BFM.set_command_data('hA6, 0);
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.set_command_request(REQ_READ);
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.set_command_request(REQ_WRITE);
	`TDAS_0_BFM.set_command_data('hA7, 0);
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.set_command_request(REQ_READ);
	`TDAS_0_BFM.push_command();
	`TDAS_0_BFM.set_command_request(REQ_WRITE);
	`TDAS_0_BFM.set_command_data('hA8, 0);
	`TDAS_0_BFM.push_command();

	for(int i = 0 ; i < 16 ; i++) begin
		while(`TDAS_0_BFM.get_response_queue_size() == 0)
			@(posedge `TEST_SYS_INST.clk_clk);

		`TDAS_0_BFM.pop_response();
		
		case(i)
			 0 : expected_time = 'd1_370_000;
			 1 : expected_time = 'd1_450_000;
			 2 : expected_time = 'd1_530_000;
			 3 : expected_time = 'd1_610_000;
			 4 : expected_time = 'd1_670_000;
			 5 : expected_time = 'd1_710_000;
			 6 : expected_time = 'd1_750_000;
			 7 : expected_time = 'd1_790_000;
		 	 8 : expected_time = 'd1_850_000;
			 9 : expected_time = 'd1_910_000;
			10 : expected_time = 'd1_970_000;
			11 : expected_time = 'd2_030_000;
			12 : expected_time = 'd2_090_000;
			13 : expected_time = 'd2_150_000;
			14 : expected_time = 'd2_210_000;
			15 : expected_time = 'd2_270_000;
			default : expected_time = 'd0;
		endcase

		cur_time = $time;
		if(expected_time == cur_time) begin
		        $sformat(message, "Response received at expected time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_INFO, message);
		end else begin
		        $sformat(message, "Response received at UNEXPECTED time: %d : %d", cur_time, expected_time);
		                print(VERBOSITY_ERROR, message);
		                test_success <= 1'b0;
		end
	end

	// TDAS_1 read
	`TDAS_1_BFM.set_command_address(0);
	`TDAS_1_BFM.set_command_byte_enable('hF, 0);
	`TDAS_1_BFM.set_command_burst_count('h1);
	`TDAS_1_BFM.set_command_burst_size('h1);
	`TDAS_1_BFM.set_command_data('h0, 0);
	`TDAS_1_BFM.set_command_idle(0, 0);
	`TDAS_1_BFM.set_command_init_latency(0);
	`TDAS_1_BFM.set_command_request(REQ_READ);
	`TDAS_1_BFM.push_command();

	while(`TDAS_1_BFM.get_response_queue_size() == 0)
		@(posedge `TEST_SYS_INST.clk_clk);

	`TDAS_1_BFM.pop_response();

	next_expected_readdata_value = 8'hE1;
	if(`TDAS_1_BFM.get_response_data(0) == next_expected_readdata_value) begin
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `TDAS_1_BFM.get_response_data(0));
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "EXPECTED READ RESPONSE DATA = 0x%08X", next_expected_readdata_value);
		print(VERBOSITY_ERROR, message);
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `TDAS_1_BFM.get_response_data(0));
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	next_expected_response_value = 2'b10;
	if(`TDAS_1_BFM.get_read_response_status(0) == next_expected_response_value) begin
		$sformat(message, "READ RESPONSE = 0x%08X", `TDAS_1_BFM.get_read_response_status(0));
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "EXPECTED READ RESPONSE = 0x%08X", next_expected_response_value);
		print(VERBOSITY_ERROR, message);
		$sformat(message, "READ RESPONSE = 0x%08X", `TDAS_1_BFM.get_read_response_status(0));
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	expected_time = 'd2_350_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Response received at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Response received at UNEXPECTED time: %d : %d", cur_time, expected_time);
	                print(VERBOSITY_ERROR, message);
	                test_success <= 1'b0;
	end

	// TDAS_1 write
	`TDAS_1_BFM.set_command_address(0);
	`TDAS_1_BFM.set_command_byte_enable('hF, 0);
	`TDAS_1_BFM.set_command_burst_count('h1);
	`TDAS_1_BFM.set_command_burst_size('h1);
	`TDAS_1_BFM.set_command_data('hAA, 0);
	`TDAS_1_BFM.set_command_idle(0, 0);
	`TDAS_1_BFM.set_command_init_latency(0);
	`TDAS_1_BFM.set_command_request(REQ_WRITE);
	`TDAS_1_BFM.push_command();

	while(`TDAS_1_BFM.get_response_queue_size() == 0)
		@(posedge `TEST_SYS_INST.clk_clk);

	`TDAS_1_BFM.pop_response();

	next_expected_response_value = 2'b10;
	if(`TDAS_1_BFM.get_write_response_status == next_expected_response_value) begin
		$sformat(message, "WRITE RESPONSE = 0x%08X", `TDAS_1_BFM.get_write_response_status);
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "EXPECTED WRITE RESPONSE = 0x%08X", next_expected_response_value);
		print(VERBOSITY_ERROR, message);
		$sformat(message, "WRITE RESPONSE = 0x%08X", `TDAS_1_BFM.get_write_response_status);
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	expected_time = 'd2_430_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Response received at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Response received at UNEXPECTED time: %d : %d", cur_time, expected_time);
	                print(VERBOSITY_ERROR, message);
	                test_success <= 1'b0;
	end

	// TDAS_1 read 4, write 4, read-write 4
	`TDAS_1_BFM.set_command_address(0);
	`TDAS_1_BFM.set_command_byte_enable('hF, 0);
	`TDAS_1_BFM.set_command_burst_count('h1);
	`TDAS_1_BFM.set_command_burst_size('h1);
	`TDAS_1_BFM.set_command_data('h0, 0);
	`TDAS_1_BFM.set_command_idle(0, 0);
	`TDAS_1_BFM.set_command_init_latency(0);
	`TDAS_1_BFM.set_command_request(REQ_READ);
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.push_command();

	`TDAS_1_BFM.set_command_request(REQ_WRITE);
	`TDAS_1_BFM.set_command_data('hA1, 0);
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.set_command_data('hA2, 0);
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.set_command_data('hA3, 0);
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.set_command_data('hA4, 0);
	`TDAS_1_BFM.push_command();

	`TDAS_1_BFM.set_command_request(REQ_READ);
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.set_command_request(REQ_WRITE);
	`TDAS_1_BFM.set_command_data('hA5, 0);
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.set_command_request(REQ_READ);
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.set_command_request(REQ_WRITE);
	`TDAS_1_BFM.set_command_data('hA6, 0);
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.set_command_request(REQ_READ);
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.set_command_request(REQ_WRITE);
	`TDAS_1_BFM.set_command_data('hA7, 0);
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.set_command_request(REQ_READ);
	`TDAS_1_BFM.push_command();
	`TDAS_1_BFM.set_command_request(REQ_WRITE);
	`TDAS_1_BFM.set_command_data('hA8, 0);
	`TDAS_1_BFM.push_command();

	for(int i = 0 ; i < 16 ; i++) begin
		while(`TDAS_1_BFM.get_response_queue_size() == 0)
			@(posedge `TEST_SYS_INST.clk_clk);

		`TDAS_1_BFM.pop_response();
		
		case(i)
			 0 : expected_time = 'd2_510_000;
			 1 : expected_time = 'd2_590_000;
			 2 : expected_time = 'd2_670_000;
			 3 : expected_time = 'd2_750_000;
			 4 : expected_time = 'd2_830_000;
			 5 : expected_time = 'd2_910_000;
			 6 : expected_time = 'd2_990_000;
			 7 : expected_time = 'd3_070_000;
		 	 8 : expected_time = 'd3_150_000;
			 9 : expected_time = 'd3_230_000;
			10 : expected_time = 'd3_310_000;
			11 : expected_time = 'd3_390_000;
			12 : expected_time = 'd3_470_000;
			13 : expected_time = 'd3_550_000;
			14 : expected_time = 'd3_630_000;
			15 : expected_time = 'd3_710_000;
			default : expected_time = 'd0;
		endcase

		cur_time = $time;
		if(expected_time == cur_time) begin
		        $sformat(message, "Response received at expected time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_INFO, message);
		end else begin
		        $sformat(message, "Response received at UNEXPECTED time: %d : %d", cur_time, expected_time);
		                print(VERBOSITY_ERROR, message);
		                test_success <= 1'b0;
		end
	end

	// TDAS_2 read
	`TDAS_2_BFM.set_command_address(0);
	`TDAS_2_BFM.set_command_byte_enable('hF, 0);
	`TDAS_2_BFM.set_command_burst_count('h1);
	`TDAS_2_BFM.set_command_burst_size('h1);
	`TDAS_2_BFM.set_command_data('h0, 0);
	`TDAS_2_BFM.set_command_idle(0, 0);
	`TDAS_2_BFM.set_command_init_latency(0);
	`TDAS_2_BFM.set_command_request(REQ_READ);
	`TDAS_2_BFM.push_command();

	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);

	if(`TDAS_2_BFM.get_response_queue_size() == 0) begin
	        $sformat(message, "No response from TDAS_2 read as expected.");
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Unexpected response received from TDAS_2 read.");
	        print(VERBOSITY_ERROR, message);
	        test_success <= 1'b0;
	end

        force `TEST_SYS_INST.tdas_2_never_respond_slave_waitrequest = 0;
	@(posedge `TEST_SYS_INST.clk_clk);
        release `TEST_SYS_INST.tdas_2_never_respond_slave_waitrequest;
	@(posedge `TEST_SYS_INST.clk_clk);
        
	if(`TDAS_2_BFM.get_response_queue_size() == 0) begin
	        $sformat(message, "Unable to force TDAS_2 read cycle termination.");
	        print(VERBOSITY_FAILURE, message);
	        abort_simulation();
	end

	`TDAS_2_BFM.pop_response();

	// TDAS_2 write
	`TDAS_2_BFM.set_command_address(0);
	`TDAS_2_BFM.set_command_byte_enable('hF, 0);
	`TDAS_2_BFM.set_command_burst_count('h1);
	`TDAS_2_BFM.set_command_burst_size('h1);
	`TDAS_2_BFM.set_command_data('hAA, 0);
	`TDAS_2_BFM.set_command_idle(0, 0);
	`TDAS_2_BFM.set_command_init_latency(0);
	`TDAS_2_BFM.set_command_request(REQ_WRITE);
	`TDAS_2_BFM.push_command();

	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);

	if(`TDAS_2_BFM.get_response_queue_size() == 0) begin
	        $sformat(message, "No response from TDAS_2 write as expected.");
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Unexpected response received from TDAS_2 write.");
	        print(VERBOSITY_ERROR, message);
	        test_success <= 1'b0;
	end

        force `TEST_SYS_INST.tdas_2_never_respond_slave_waitrequest = 0;
	@(posedge `TEST_SYS_INST.clk_clk);
        release `TEST_SYS_INST.tdas_2_never_respond_slave_waitrequest;
	@(posedge `TEST_SYS_INST.clk_clk);
        
	if(`TDAS_2_BFM.get_response_queue_size() == 0) begin
	        $sformat(message, "Unable to force TDAS_2 write cycle termination.");
	        print(VERBOSITY_FAILURE, message);
	        abort_simulation();
	end

	`TDAS_2_BFM.pop_response();

	// TDAS_3 read trigger access event
	if(	(`TEST_SYS_INST.tdas_3_access_events_access_event_reset_reset == 1'b1) |
		(`TEST_SYS_INST.tdas_3_access_events_access_event_interrupt_irq == 1'b1) |
		(`TEST_SYS_INST.tdas_3_access_events_access_event_conduit_access_event_conduit == 1'b1)
	) begin
	        $sformat(message, "Access events already appear to be asserted.");
	        print(VERBOSITY_FAILURE, message);
	        abort_simulation();
	end
	
	`TDAS_3_BFM.set_command_address(0);
	`TDAS_3_BFM.set_command_byte_enable('hF, 0);
	`TDAS_3_BFM.set_command_burst_count('h1);
	`TDAS_3_BFM.set_command_burst_size('h1);
	`TDAS_3_BFM.set_command_data('h0, 0);
	`TDAS_3_BFM.set_command_idle(0, 0);
	`TDAS_3_BFM.set_command_init_latency(0);
	`TDAS_3_BFM.set_command_request(REQ_READ);
	`TDAS_3_BFM.push_command();

	while(`TDAS_3_BFM.get_response_queue_size() == 0)
		@(posedge `TEST_SYS_INST.clk_clk);

	`TDAS_3_BFM.pop_response();

	next_expected_readdata_value = 8'hE3;
	if(`TDAS_3_BFM.get_response_data(0) == next_expected_readdata_value) begin
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `TDAS_3_BFM.get_response_data(0));
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "EXPECTED READ RESPONSE DATA = 0x%08X", next_expected_readdata_value);
		print(VERBOSITY_ERROR, message);
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `TDAS_3_BFM.get_response_data(0));
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	if(	(`TEST_SYS_INST.tdas_3_access_events_access_event_reset_reset == 1'b0) |
		(`TEST_SYS_INST.tdas_3_access_events_access_event_interrupt_irq == 1'b0) |
		(`TEST_SYS_INST.tdas_3_access_events_access_event_conduit_access_event_conduit == 1'b0)
	) begin
	        $sformat(message, "Access events do not appear to be asserted.");
	        print(VERBOSITY_FAILURE, message);
	        abort_simulation();
	end
	
	// reset the system to clear the access event
	#5000;
	`RESET_BFM.reset_assert();
	#5000;
	`RESET_BFM.reset_deassert();
	for(int i = 0 ; i < 8 ; i++)
		@(posedge `TEST_SYS_INST.clk_clk);

	// TDAS_3 write trigger access event
	if(	(`TEST_SYS_INST.tdas_3_access_events_access_event_reset_reset == 1'b1) |
		(`TEST_SYS_INST.tdas_3_access_events_access_event_interrupt_irq == 1'b1) |
		(`TEST_SYS_INST.tdas_3_access_events_access_event_conduit_access_event_conduit == 1'b1)
	) begin
	        $sformat(message, "Access events already appear to be asserted.");
	        print(VERBOSITY_FAILURE, message);
	        abort_simulation();
	end
	
	`TDAS_3_BFM.set_command_address(0);
	`TDAS_3_BFM.set_command_byte_enable('hF, 0);
	`TDAS_3_BFM.set_command_burst_count('h1);
	`TDAS_3_BFM.set_command_burst_size('h1);
	`TDAS_3_BFM.set_command_data('hAA, 0);
	`TDAS_3_BFM.set_command_idle(0, 0);
	`TDAS_3_BFM.set_command_init_latency(0);
	`TDAS_3_BFM.set_command_request(REQ_WRITE);
	`TDAS_3_BFM.push_command();

	while(`TDAS_3_BFM.get_response_queue_size() == 0)
		@(posedge `TEST_SYS_INST.clk_clk);

	`TDAS_3_BFM.pop_response();

	if(	(`TEST_SYS_INST.tdas_3_access_events_access_event_reset_reset == 1'b0) |
		(`TEST_SYS_INST.tdas_3_access_events_access_event_interrupt_irq == 1'b0) |
		(`TEST_SYS_INST.tdas_3_access_events_access_event_conduit_access_event_conduit == 1'b0)
	) begin
	        $sformat(message, "Access events do not appear to be asserted.");
	        print(VERBOSITY_FAILURE, message);
	        abort_simulation();
	end
	
	// clear the access event with clear_event conduit
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);

	if(	(`TEST_SYS_INST.tdas_3_access_events_access_event_reset_reset == 1'b0) |
		(`TEST_SYS_INST.tdas_3_access_events_access_event_interrupt_irq == 1'b0) |
		(`TEST_SYS_INST.tdas_3_access_events_access_event_conduit_access_event_conduit == 1'b0)
	) begin
	        $sformat(message, "Access events do not appear to be asserted.");
	        print(VERBOSITY_FAILURE, message);
	        abort_simulation();
	end
	
	`TDAS_3_CE_CONDUIT_BFM.set_clear_event(1'b1);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	`TDAS_3_CE_CONDUIT_BFM.set_clear_event(1'b0);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	
	if(	(`TEST_SYS_INST.tdas_3_access_events_access_event_reset_reset == 1'b1) |
		(`TEST_SYS_INST.tdas_3_access_events_access_event_interrupt_irq == 1'b1) |
		(`TEST_SYS_INST.tdas_3_access_events_access_event_conduit_access_event_conduit == 1'b1)
	) begin
	        $sformat(message, "Access events appear to remain asserted.");
	        print(VERBOSITY_FAILURE, message);
	        abort_simulation();
	end
	
	// TDAS_4 read
	`TDAS_4_BFM.set_command_address(0);
	`TDAS_4_BFM.set_command_byte_enable('hF, 0);
	`TDAS_4_BFM.set_command_burst_count('h1);
	`TDAS_4_BFM.set_command_burst_size('h1);
	`TDAS_4_BFM.set_command_data('h0, 0);
	`TDAS_4_BFM.set_command_idle(0, 0);
	`TDAS_4_BFM.set_command_init_latency(0);
	`TDAS_4_BFM.set_command_request(REQ_READ);
	`TDAS_4_BFM.push_command();

	while(`TDAS_4_BFM.get_response_queue_size() == 0)
		@(posedge `TEST_SYS_INST.clk_clk);

	`TDAS_4_BFM.pop_response();

	next_expected_readdata_32_value = 32'hE4E4E4E4;
	if(`TDAS_4_BFM.get_response_data(0) == next_expected_readdata_32_value) begin
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `TDAS_4_BFM.get_response_data(0));
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "EXPECTED READ RESPONSE DATA = 0x%08X", next_expected_readdata_32_value);
		print(VERBOSITY_ERROR, message);
		$sformat(message, "READ RESPONSE DATA = 0x%08X", `TDAS_4_BFM.get_response_data(0));
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	expected_time = 'd4_510_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Response received at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Response received at UNEXPECTED time: %d : %d", cur_time, expected_time);
	                print(VERBOSITY_ERROR, message);
	                test_success <= 1'b0;
	end

	// TDAS_4 write
	`TDAS_4_BFM.set_command_address(0);
	`TDAS_4_BFM.set_command_byte_enable('hF, 0);
	`TDAS_4_BFM.set_command_burst_count('h1);
	`TDAS_4_BFM.set_command_burst_size('h1);
	`TDAS_4_BFM.set_command_data('hAA55AA55, 0);
	`TDAS_4_BFM.set_command_idle(0, 0);
	`TDAS_4_BFM.set_command_init_latency(0);
	`TDAS_4_BFM.set_command_request(REQ_WRITE);
	`TDAS_4_BFM.push_command();

	while(`TDAS_4_BFM.get_response_queue_size() == 0)
		@(posedge `TEST_SYS_INST.clk_clk);

	`TDAS_4_BFM.pop_response();

	expected_time = 'd4_570_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Response received at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Response received at UNEXPECTED time: %d : %d", cur_time, expected_time);
	                print(VERBOSITY_ERROR, message);
	                test_success <= 1'b0;
	end
	
	// TDAS_5 read
	`TDAS_5_BFM.set_command_address(0);
	`TDAS_5_BFM.set_command_byte_enable('hF, 0);
	`TDAS_5_BFM.set_command_burst_count('h1);
	`TDAS_5_BFM.set_command_burst_size('h1);
	`TDAS_5_BFM.set_command_data('h0, 0);
	`TDAS_5_BFM.set_command_idle(0, 0);
	`TDAS_5_BFM.set_command_init_latency(0);
	`TDAS_5_BFM.set_command_request(REQ_READ);
	`TDAS_5_BFM.push_command();

	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);

	if(`TDAS_5_BFM.get_response_queue_size() == 0) begin
	        $sformat(message, "No response from TDAS_5 read as expected.");
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Unexpected response received from TDAS_5 read.");
	        print(VERBOSITY_ERROR, message);
	        test_success <= 1'b0;
	end

	`TDAS_5_CE_CONDUIT_BFM.set_clear_event(1'b1);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	`TDAS_5_CE_CONDUIT_BFM.set_clear_event(1'b0);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
        
	if(`TDAS_5_BFM.get_response_queue_size() == 0) begin
	        $sformat(message, "Unable to force TDAS_5 read cycle termination.");
	        print(VERBOSITY_FAILURE, message);
	        abort_simulation();
	end

	`TDAS_5_BFM.pop_response();

	// TDAS_5 write
	`TDAS_5_BFM.set_command_address(0);
	`TDAS_5_BFM.set_command_byte_enable('hF, 0);
	`TDAS_5_BFM.set_command_burst_count('h1);
	`TDAS_5_BFM.set_command_burst_size('h1);
	`TDAS_5_BFM.set_command_data('hAA, 0);
	`TDAS_5_BFM.set_command_idle(0, 0);
	`TDAS_5_BFM.set_command_init_latency(0);
	`TDAS_5_BFM.set_command_request(REQ_WRITE);
	`TDAS_5_BFM.push_command();

	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);

	if(`TDAS_5_BFM.get_response_queue_size() == 0) begin
	        $sformat(message, "No response from TDAS_5 write as expected.");
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Unexpected response received from TDAS_5 write.");
	        print(VERBOSITY_ERROR, message);
	        test_success <= 1'b0;
	end

	`TDAS_5_CE_CONDUIT_BFM.set_clear_event(1'b1);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	`TDAS_5_CE_CONDUIT_BFM.set_clear_event(1'b0);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
	@(posedge `TEST_SYS_INST.clk_clk);
        
	if(`TDAS_5_BFM.get_response_queue_size() == 0) begin
	        $sformat(message, "Unable to force TDAS_5 write cycle termination.");
	        print(VERBOSITY_FAILURE, message);
	        abort_simulation();
	end

	`TDAS_5_BFM.pop_response();

	// finish
	for(int i = 0 ; i < 4 ; i++)
		@(posedge `TEST_SYS_INST.clk_clk);

	if(test_success == 1'b1) begin
		$sformat(message, "Test completed successfully...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Test failed...");
		print(VERBOSITY_ERROR, message);
	end

	$stop;

end // initial

endmodule

