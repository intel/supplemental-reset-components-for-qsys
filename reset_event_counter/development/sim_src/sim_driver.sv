/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
`timescale 1 ps / 1 ps

`define VERBOSITY VERBOSITY_INFO

`define TEST_SYS_INST		sim_top.tb.test_sys_inst
`define POWER_ON_RESET_BFM	sim_top.tb.test_sys_inst_reset_event_counter_0_power_on_reset_bfm.test_sys_inst_reset_event_counter_0_power_on_reset_bfm
`define RESET_EVENT_BFM		sim_top.tb.test_sys_inst_reset_event_counter_0_reset_event_bfm.test_sys_inst_reset_event_counter_0_reset_event_bfm
`define SLAVE_S0_BFM		sim_top.tb.test_sys_inst_reset_event_counter_0_s0_bfm.test_sys_inst_reset_event_counter_0_s0_bfm

module sim_driver();

import verbosity_pkg::*;
import avalon_mm_pkg::*;

string message;

initial begin
	#(64'd23_604_470_001);
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

reg test_success;
reg [31:0] next_expected_value;
reg [63:0] expected_time;
reg [63:0] cur_time;

initial begin

	test_success <= 1'b1;

	set_verbosity( `VERBOSITY );

	`SLAVE_S0_BFM.set_response_timeout(5);
	`SLAVE_S0_BFM.set_command_timeout(5);
	`SLAVE_S0_BFM.init();

	//wait for reset to de-assert
	wait(`TEST_SYS_INST.reset_event_counter_0_power_on_reset_reset == 1'b0);

	// measure the expected early behavior of the counters
	next_expected_value = 32'h0000_0000;

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
		@(posedge `TEST_SYS_INST.reset_event_counter_0_s0_clk_clk);

	`SLAVE_S0_BFM.pop_response();

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

	for(int i = 0 ; i < 4 ; i++) begin
		next_expected_value = next_expected_value + 32'h0001_0000;
		wait(`TEST_SYS_INST.reset_event_counter_0_s0_readdata == next_expected_value);

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
			@(posedge `TEST_SYS_INST.reset_event_counter_0_s0_clk_clk);

		`SLAVE_S0_BFM.pop_response();

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

		`RESET_EVENT_BFM.reset_assert();

		next_expected_value = next_expected_value + 32'h0000_0001;
		wait(`TEST_SYS_INST.reset_event_counter_0_s0_readdata == next_expected_value);

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
			@(posedge `TEST_SYS_INST.reset_event_counter_0_s0_clk_clk);

		`SLAVE_S0_BFM.pop_response();

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

		`RESET_EVENT_BFM.reset_deassert();
	end

	// now try the opposite startup sequence
	`POWER_ON_RESET_BFM.reset_assert();
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	`POWER_ON_RESET_BFM.reset_deassert();

	`RESET_EVENT_BFM.reset_assert();

	next_expected_value = 32'h0000_0000;

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
		@(posedge `TEST_SYS_INST.reset_event_counter_0_s0_clk_clk);

	`SLAVE_S0_BFM.pop_response();

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

	for(int i = 0 ; i < 4 ; i++) begin
		next_expected_value = next_expected_value + 32'h0000_0001;
		wait(`TEST_SYS_INST.reset_event_counter_0_s0_readdata == next_expected_value);

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
			@(posedge `TEST_SYS_INST.reset_event_counter_0_s0_clk_clk);

		`SLAVE_S0_BFM.pop_response();

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

		`RESET_EVENT_BFM.reset_deassert();

		next_expected_value = next_expected_value + 32'h0001_0000;
		wait(`TEST_SYS_INST.reset_event_counter_0_s0_readdata == next_expected_value);

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
			@(posedge `TEST_SYS_INST.reset_event_counter_0_s0_clk_clk);

		`SLAVE_S0_BFM.pop_response();

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

		`RESET_EVENT_BFM.reset_assert();
	end

	// now try the maximal count condition
	`POWER_ON_RESET_BFM.reset_assert();
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	`POWER_ON_RESET_BFM.reset_deassert();
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);

        expected_time = 64'd5190000;
        cur_time = $time;
        if(expected_time == cur_time) begin
                $sformat(message, "Final test beginning at expected time: %d : %d", cur_time, expected_time);
                print(VERBOSITY_INFO, message);
        end else begin
                $sformat(message, "Final test beginning at UNEXPECTED time: %d : %d", cur_time, expected_time);
                        print(VERBOSITY_ERROR, message);
                        test_success <= 1'b0;
        end

	set_verbosity( VERBOSITY_WARNING );

	next_expected_value = 32'h0000_0000;
	for(int i = 0 ; i < 'h0000_FFFF ; i++) begin
		wait(`TEST_SYS_INST.reset_event_counter_0_s0_readdata == next_expected_value);
		`RESET_EVENT_BFM.reset_deassert();
		next_expected_value = next_expected_value + 32'h0001_0000;
		wait(`TEST_SYS_INST.reset_event_counter_0_s0_readdata == next_expected_value);
		`RESET_EVENT_BFM.reset_assert();
		next_expected_value = next_expected_value + 32'h0000_0001;
	end

	set_verbosity( `VERBOSITY );

        expected_time = 64'd23597650000;
        cur_time = $time;
        if(expected_time == cur_time) begin
                $sformat(message, "Final test ended at expected time: %d : %d", cur_time, expected_time);
                print(VERBOSITY_INFO, message);
        end else begin
                $sformat(message, "Final test ended at UNEXPECTED time: %d : %d", cur_time, expected_time);
                        print(VERBOSITY_ERROR, message);
                        test_success <= 1'b0;
        end


	for(int i = 0 ; i < 10 ; i++) begin
		for(int j = 0 ; j < 16 ; j++)
			@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
		wait(`TEST_SYS_INST.reset_event_counter_0_s0_readdata == next_expected_value);
		`RESET_EVENT_BFM.reset_deassert();

		for(int j = 0 ; j < 16 ; j++)
			@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
		wait(`TEST_SYS_INST.reset_event_counter_0_s0_readdata == next_expected_value);
		`RESET_EVENT_BFM.reset_assert();
	end

	for(int j = 0 ; j < 16 ; j++)
		@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
	wait(`TEST_SYS_INST.reset_event_counter_0_s0_readdata == next_expected_value);

	// finish
	for(int i = 0 ; i < 4 ; i++)
		@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);

	@(posedge `TEST_SYS_INST.reset_event_counter_0_clock_clk);
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

