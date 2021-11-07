/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
`timescale 1 ps / 1 ps

`define VERBOSITY VERBOSITY_INFO

`define TEST_SYS_INST		sim_top.tb.test_sys_inst
`define EVENT_INPUT_BFM		sim_top.tb.test_sys_inst_event_timer_0_event_input_bfm
`define EVENT_RESET_BFM		sim_top.tb.test_sys_inst_event_timer_0_event_reset_bfm
`define S0_BFM			sim_top.tb.test_sys_inst_event_timer_0_s0_bfm
`define S0_RESET_BFM		sim_top.tb.test_sys_inst_event_timer_0_s0_reset_bfm
`define TIMEOUT_BFM		sim_top.tb.test_sys_inst_event_timer_0_timeout_bfm
`define ACQUIRED_BFM		sim_top.tb.test_sys_inst_event_timer_0_acquired_bfm
`define LOST_BFM		sim_top.tb.test_sys_inst_event_timer_0_lost_bfm

module sim_driver();

import verbosity_pkg::*;
import avalon_mm_pkg::*;

string message;

initial begin
	#10_650_001;
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

reg test_success;
reg [31:0] next_expected_value;

initial begin

	`EVENT_INPUT_BFM.set_event_input(1'b0);

	test_success <= 1'b1;

	set_verbosity( `VERBOSITY );

	`S0_BFM.set_response_timeout(5);
	`S0_BFM.set_command_timeout(5);
	`S0_BFM.init();


	// wait for reset to de-assert
	wait(`TEST_SYS_INST.event_timer_0_event_reset_reset == 1'b0);

	// test a timeout condition
	wait(	`TEST_SYS_INST.event_timer_0_acquired_acquired ||
		`TEST_SYS_INST.event_timer_0_acquired_reset_reset_n ||
		`TEST_SYS_INST.event_timer_0_timeout_timeout ||
		`TEST_SYS_INST.event_timer_0_timeout_reset_reset_n);

        for(int i = 0 ; i < 4 ; i++)
                @(posedge `TEST_SYS_INST.event_timer_0_event_clk_clk);

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
                @(posedge `TEST_SYS_INST.event_timer_0_s0_clk_clk);

        `S0_BFM.pop_response();

	next_expected_value = 32'h00000000;
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

        if(	`TEST_SYS_INST.event_timer_0_timeout_timeout &&
	        `TEST_SYS_INST.event_timer_0_timeout_reset_reset_n) begin
                $sformat(message, "Timeout detected successfully...");
                print(VERBOSITY_INFO, message);
        end else begin
                $sformat(message, "Timeout detection failure...");
                print(VERBOSITY_ERROR, message);
                test_success <= 1'b0;
        end

        if(	`TEST_SYS_INST.event_timer_0_acquired_acquired ||
		`TEST_SYS_INST.event_timer_0_acquired_reset_reset_n) begin
                $sformat(message, "Acquisition detection failure...");
                print(VERBOSITY_ERROR, message);
                test_success <= 1'b0;
        end

        if(	`TEST_SYS_INST.event_timer_0_lost_lost ||
        	`TEST_SYS_INST.event_timer_0_lost_reset_reset_n) begin
                $sformat(message, "Lost detection failure...");
                print(VERBOSITY_ERROR, message);
                test_success <= 1'b0;
        end

	// test a acquisition condition
        @(posedge `TEST_SYS_INST.event_timer_0_event_clk_clk);
        `EVENT_RESET_BFM.reset_assert();
	`S0_RESET_BFM.reset_assert();
	`EVENT_INPUT_BFM.set_event_input(1'b0);
        @(posedge `TEST_SYS_INST.event_timer_0_event_clk_clk);
        `EVENT_RESET_BFM.reset_deassert();
	`S0_RESET_BFM.reset_deassert();

        for(int i = 0 ; i < 90 ; i++)
                @(posedge `TEST_SYS_INST.event_timer_0_event_clk_clk);

	`EVENT_INPUT_BFM.set_event_input(1'b1);

	wait(	`TEST_SYS_INST.event_timer_0_acquired_acquired ||
		`TEST_SYS_INST.event_timer_0_acquired_reset_reset_n ||
		`TEST_SYS_INST.event_timer_0_timeout_timeout ||
		`TEST_SYS_INST.event_timer_0_timeout_reset_reset_n);

        for(int i = 0 ; i < 4 ; i++)
                @(posedge `TEST_SYS_INST.event_timer_0_event_clk_clk);

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
                @(posedge `TEST_SYS_INST.event_timer_0_s0_clk_clk);

        `S0_BFM.pop_response();

	next_expected_value = 32'h0000005d;
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

        if(	`TEST_SYS_INST.event_timer_0_acquired_acquired &&
		`TEST_SYS_INST.event_timer_0_acquired_reset_reset_n) begin
                $sformat(message, "Acquisition detected successfully...");
                print(VERBOSITY_INFO, message);
        end else begin
                $sformat(message, "Acquisition detection failure...");
                print(VERBOSITY_ERROR, message);
                test_success <= 1'b0;
        end

        if(	`TEST_SYS_INST.event_timer_0_timeout_timeout ||
	        `TEST_SYS_INST.event_timer_0_timeout_reset_reset_n) begin
                $sformat(message, "Timeout detection failure...");
                print(VERBOSITY_ERROR, message);
                test_success <= 1'b0;
        end

        if(	`TEST_SYS_INST.event_timer_0_lost_lost ||
        	`TEST_SYS_INST.event_timer_0_lost_reset_reset_n) begin
                $sformat(message, "Lost detection failure...");
                print(VERBOSITY_ERROR, message);
                test_success <= 1'b0;
        end

	// test a lost condition
        @(posedge `TEST_SYS_INST.event_timer_0_event_clk_clk);
        `EVENT_RESET_BFM.reset_assert();
	`S0_RESET_BFM.reset_assert();
	`EVENT_INPUT_BFM.set_event_input(1'b0);
        @(posedge `TEST_SYS_INST.event_timer_0_event_clk_clk);
        `EVENT_RESET_BFM.reset_deassert();
	`S0_RESET_BFM.reset_deassert();

        for(int i = 0 ; i < 100 ; i++)
                @(posedge `TEST_SYS_INST.event_timer_0_event_clk_clk);

	`EVENT_INPUT_BFM.set_event_input(1'b1);

	wait(	`TEST_SYS_INST.event_timer_0_acquired_acquired ||
		`TEST_SYS_INST.event_timer_0_acquired_reset_reset_n ||
		`TEST_SYS_INST.event_timer_0_timeout_timeout ||
		`TEST_SYS_INST.event_timer_0_timeout_reset_reset_n);

        for(int i = 0 ; i < 4 ; i++)
                @(posedge `TEST_SYS_INST.event_timer_0_event_clk_clk);

	`EVENT_INPUT_BFM.set_event_input(1'b0);

        for(int i = 0 ; i < 4 ; i++)
                @(posedge `TEST_SYS_INST.event_timer_0_event_clk_clk);

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
                @(posedge `TEST_SYS_INST.event_timer_0_s0_clk_clk);

        `S0_BFM.pop_response();

	next_expected_value = 32'h00000067;
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

        if(	`TEST_SYS_INST.event_timer_0_lost_lost &&
        	`TEST_SYS_INST.event_timer_0_lost_reset_reset_n) begin
                $sformat(message, "Lost detected successfully...");
                print(VERBOSITY_INFO, message);
        end else begin
                $sformat(message, "Lost detection failure...");
                print(VERBOSITY_ERROR, message);
                test_success <= 1'b0;
        end

        if(	`TEST_SYS_INST.event_timer_0_timeout_timeout ||
	        `TEST_SYS_INST.event_timer_0_timeout_reset_reset_n) begin
                $sformat(message, "Timeout detection failure...");
                print(VERBOSITY_ERROR, message);
                test_success <= 1'b0;
        end

        if(	~(`TEST_SYS_INST.event_timer_0_acquired_acquired) ||
		~(`TEST_SYS_INST.event_timer_0_acquired_reset_reset_n)) begin
                $sformat(message, "Acquisition detection failure...");
                print(VERBOSITY_ERROR, message);
                test_success <= 1'b0;
        end

	// finish
        @(posedge `TEST_SYS_INST.event_timer_0_s0_clk_clk);
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

