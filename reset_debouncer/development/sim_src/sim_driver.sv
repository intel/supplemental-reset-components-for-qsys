/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
`timescale 1 ps / 1 ps

`define VERBOSITY VERBOSITY_INFO

`define TEST_SYS_INST		sim_top.tb.test_sys_inst
`define POWER_ON_RESET_BFM	sim_top.tb.test_sys_inst_reset_debouncer_0_power_on_reset_bfm.test_sys_inst_reset_debouncer_0_power_on_reset_bfm
`define RESET_INPUT_BFM		sim_top.tb.test_sys_inst_reset_debouncer_0_reset_input_bfm.test_sys_inst_reset_debouncer_0_reset_input_bfm
`define S0_BFM			sim_top.tb.test_sys_inst_reset_debouncer_0_s0_bfm.test_sys_inst_reset_debouncer_0_s0_bfm
`define S0_RESET_BFM		sim_top.tb.test_sys_inst_reset_debouncer_0_s0_reset_bfm.test_sys_inst_reset_debouncer_0_s0_reset_bfm

module sim_driver();

import verbosity_pkg::*;
import avalon_mm_pkg::*;

string message;

initial begin
	#3_936_930_001;
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

reg test_success;
reg [31:0] next_expected_value;
integer expected_time;
integer cur_time;

initial begin

	test_success <= 1'b1;

	set_verbosity( `VERBOSITY );

	`S0_BFM.set_response_timeout(5);
	`S0_BFM.set_command_timeout(5);
	`S0_BFM.init();


	// wait for reset to de-assert
	wait(`TEST_SYS_INST.reset_debouncer_0_power_on_reset_reset == 1'b0);
	`POWER_ON_RESET_BFM.reset_assert();
	wait(`TEST_SYS_INST.reset_debouncer_0_reset_input_reset == 1'b0);

        for(int i = 0 ; i < 16 ; i++)
                @(posedge `TEST_SYS_INST.reset_debouncer_0_debounce_clock_clk);

	`POWER_ON_RESET_BFM.reset_deassert();

	// test normal POR operation
	next_expected_value <= 32'h21000000;

	for(int j = 0 ; j < 34 ; j++) begin
		for(int i = 0 ; i < 64 ; i++)
		        @(posedge `TEST_SYS_INST.reset_debouncer_0_debounce_clock_clk);

		#5000;
		`RESET_INPUT_BFM.reset_assert();
		#1000;
		`RESET_INPUT_BFM.reset_deassert();

		for(int i = 0 ; i < 64 ; i++)
		        @(posedge `TEST_SYS_INST.reset_debouncer_0_debounce_clock_clk);

		`S0_BFM.set_command_address(0);
		`S0_BFM.set_command_byte_enable('hF, 0);
		`S0_BFM.set_command_burst_count('h1);
		`S0_BFM.set_command_burst_size('h1);
		`S0_BFM.set_command_data('h0, 0);
		`S0_BFM.set_command_idle(0, 0);
		`S0_BFM.set_command_init_latency(0);
		`S0_BFM.set_command_request(REQ_READ);
		`S0_BFM.push_command();

		while(`S0_BFM.get_response_queue_size() == 0)
		        @(posedge `TEST_SYS_INST.reset_debouncer_0_s0_clk_clk);

		`S0_BFM.pop_response();

		if(`S0_BFM.get_response_data(0) == next_expected_value) begin
		        $sformat(message, "READ RESPONSE DATA = 0x%08X", `S0_BFM.get_response_data(0));
		        print(VERBOSITY_INFO, message);
		end else begin
		        $sformat(message, "EXPECTED READ RESPONSE DATA = 0x%08X", next_expected_value);
		        print(VERBOSITY_ERROR, message);
		        $sformat(message, "READ RESPONSE DATA = 0x%08X", `S0_BFM.get_response_data(0));
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
		end

		if(j == 0) begin
			next_expected_value <= 32'h22000081;
		end else begin
			if(&next_expected_value[28:24]) begin
				next_expected_value <= next_expected_value + 32'h00000082;
			end else begin
				next_expected_value <= next_expected_value + 32'h01000082;
			end
		end

	end // for(int j = 0 ; j < 34 ; j++)

	wait(`TEST_SYS_INST.reset_debouncer_0_reset_output_reset == 1'b0);

	expected_time = 'd1313530000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Reset output deasserted at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Reset output deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
	end

	// test additional reset input and extended holdover operation
        for(int i = 0 ; i < 16 ; i++)
                @(posedge `TEST_SYS_INST.reset_debouncer_0_debounce_clock_clk);

	#5000;
	`RESET_INPUT_BFM.reset_assert();
	#1000;
	`RESET_INPUT_BFM.reset_deassert();

        for(int i = 0 ; i < 64 ; i++)
                @(posedge `TEST_SYS_INST.reset_debouncer_0_debounce_clock_clk);

	next_expected_value <= 32'h41000000;

	`S0_BFM.set_command_address(0);
	`S0_BFM.set_command_byte_enable('hF, 0);
	`S0_BFM.set_command_burst_count('h1);
	`S0_BFM.set_command_burst_size('h1);
	`S0_BFM.set_command_data('h0, 0);
	`S0_BFM.set_command_idle(0, 0);
	`S0_BFM.set_command_init_latency(0);
	`S0_BFM.set_command_request(REQ_READ);
	`S0_BFM.push_command();

	while(`S0_BFM.get_response_queue_size() == 0)
	        @(posedge `TEST_SYS_INST.reset_debouncer_0_s0_clk_clk);

	`S0_BFM.pop_response();

	if(`S0_BFM.get_response_data(0) == next_expected_value) begin
	        $sformat(message, "READ RESPONSE DATA = 0x%08X", `S0_BFM.get_response_data(0));
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "EXPECTED READ RESPONSE DATA = 0x%08X", next_expected_value);
	        print(VERBOSITY_ERROR, message);
	        $sformat(message, "READ RESPONSE DATA = 0x%08X", `S0_BFM.get_response_data(0));
	        print(VERBOSITY_ERROR, message);
	        test_success <= 1'b0;
	end

	`RESET_INPUT_BFM.reset_assert();

        for(int i = 0 ; i < 'hFFFF ; i++)
                @(posedge `TEST_SYS_INST.reset_debouncer_0_debounce_clock_clk);

	next_expected_value <= 32'h60000000;

	`S0_BFM.set_command_address(0);
	`S0_BFM.set_command_byte_enable('hF, 0);
	`S0_BFM.set_command_burst_count('h1);
	`S0_BFM.set_command_burst_size('h1);
	`S0_BFM.set_command_data('h0, 0);
	`S0_BFM.set_command_idle(0, 0);
	`S0_BFM.set_command_init_latency(0);
	`S0_BFM.set_command_request(REQ_READ);
	`S0_BFM.push_command();

	while(`S0_BFM.get_response_queue_size() == 0)
	        @(posedge `TEST_SYS_INST.reset_debouncer_0_s0_clk_clk);

	`S0_BFM.pop_response();

	if(`S0_BFM.get_response_data(0) == next_expected_value) begin
	        $sformat(message, "READ RESPONSE DATA = 0x%08X", `S0_BFM.get_response_data(0));
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "EXPECTED READ RESPONSE DATA = 0x%08X", next_expected_value);
	        print(VERBOSITY_ERROR, message);
	        $sformat(message, "READ RESPONSE DATA = 0x%08X", `S0_BFM.get_response_data(0));
	        print(VERBOSITY_ERROR, message);
	        test_success <= 1'b0;
	end

	`RESET_INPUT_BFM.reset_deassert();

	wait(`TEST_SYS_INST.reset_debouncer_0_reset_output_reset == 1'b0);

	expected_time = 'd3936850000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Reset output deasserted at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Reset output deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
	end

	next_expected_value <= 32'h61000000;

	`S0_BFM.set_command_address(0);
	`S0_BFM.set_command_byte_enable('hF, 0);
	`S0_BFM.set_command_burst_count('h1);
	`S0_BFM.set_command_burst_size('h1);
	`S0_BFM.set_command_data('h0, 0);
	`S0_BFM.set_command_idle(0, 0);
	`S0_BFM.set_command_init_latency(0);
	`S0_BFM.set_command_request(REQ_READ);
	`S0_BFM.push_command();

	while(`S0_BFM.get_response_queue_size() == 0)
	        @(posedge `TEST_SYS_INST.reset_debouncer_0_s0_clk_clk);

	`S0_BFM.pop_response();

	if(`S0_BFM.get_response_data(0) == next_expected_value) begin
	        $sformat(message, "READ RESPONSE DATA = 0x%08X", `S0_BFM.get_response_data(0));
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "EXPECTED READ RESPONSE DATA = 0x%08X", next_expected_value);
	        print(VERBOSITY_ERROR, message);
	        $sformat(message, "READ RESPONSE DATA = 0x%08X", `S0_BFM.get_response_data(0));
	        print(VERBOSITY_ERROR, message);
	        test_success <= 1'b0;
	end

	// finish
        @(posedge `TEST_SYS_INST.reset_debouncer_0_s0_clk_clk);
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

