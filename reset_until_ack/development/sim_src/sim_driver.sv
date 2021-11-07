/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
`timescale 1 ps / 1 ps

`define VERBOSITY VERBOSITY_INFO

`define TEST_SYS_INST		sim_top.tb.test_sys_inst
`define ASSERT_RESET_BFM	sim_top.tb.test_sys_inst_rua_reset_assert_bfm
`define RELEASE_RESET_BFM	sim_top.tb.test_sys_inst_rua_reset_release_bfm
`define ASSERT_RESET_SIGNAL	`TEST_SYS_INST.rua_reset_assert_reset
`define RELEASE_RESET_SIGNAL	`TEST_SYS_INST.rua_reset_release_reset
`define RESET_OUT_SIGNAL	`TEST_SYS_INST.rua_reset_out_reset

module sim_driver();

import verbosity_pkg::*;

string message;

initial begin
	#1_310_001;
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

reg test_success;
integer expected_time;
integer cur_time;

initial begin

	set_verbosity( `VERBOSITY );

	test_success <= 1'b1;

	// wait for reset to de-assert
	wait(`ASSERT_RESET_SIGNAL == 1'b0);
	expected_time = 'd990_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
		$sformat(message, "Assert reset deasserted...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Assert reset deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	wait(`RESET_OUT_SIGNAL == 1'b0);
	expected_time = 'd1_010_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
		$sformat(message, "RESET OUT deasserted...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "RESET OUT deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	wait(`RELEASE_RESET_SIGNAL == 1'b0);
	expected_time = 'd1_050_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
		$sformat(message, "Release reset deasserted...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Release reset deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	@(posedge `TEST_SYS_INST.rua_clk_in_clk);
	@(posedge `TEST_SYS_INST.rua_clk_in_clk);

	`ASSERT_RESET_BFM.reset_assert();

	wait(`ASSERT_RESET_SIGNAL == 1'b1);
	expected_time = 'd1_090_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
		$sformat(message, "Assert reset asserted...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Assert reset asserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	wait(`RESET_OUT_SIGNAL == 1'b1);
	expected_time = 'd1_090_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
		$sformat(message, "RESET OUT asserted...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "RESET OUT asserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	@(posedge `TEST_SYS_INST.rua_clk_in_clk);
	`ASSERT_RESET_BFM.reset_deassert();

	wait(`ASSERT_RESET_SIGNAL == 1'b0);
	expected_time = 'd1_110_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
		$sformat(message, "Assert reset deasserted...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Assert reset deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	@(posedge `TEST_SYS_INST.rua_clk_in_clk);

	`RELEASE_RESET_BFM.reset_assert();
	@(posedge `TEST_SYS_INST.rua_clk_in_clk);
	`RELEASE_RESET_BFM.reset_deassert();
	@(posedge `TEST_SYS_INST.rua_clk_in_clk);

	wait(`RELEASE_RESET_SIGNAL == 1'b1);
	expected_time = 'd1_190_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
		$sformat(message, "Release reset asserted...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Release reset asserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	wait(`RESET_OUT_SIGNAL == 1'b0);
	expected_time = 'd1_210_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
		$sformat(message, "RESET OUT deasserted...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "RESET OUT deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	wait(`RELEASE_RESET_SIGNAL == 1'b0);
	expected_time = 'd1_210_000;
	cur_time = $time;
	if(expected_time == cur_time) begin
		$sformat(message, "Release reset deasserted...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Release reset deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		print(VERBOSITY_ERROR, message);
		test_success <= 1'b0;
	end

	@(posedge `TEST_SYS_INST.rua_clk_in_clk);
	@(posedge `TEST_SYS_INST.rua_clk_in_clk);
	@(posedge `TEST_SYS_INST.rua_clk_in_clk);
	@(posedge `TEST_SYS_INST.rua_clk_in_clk);
	@(posedge `TEST_SYS_INST.rua_clk_in_clk);

	if(test_success) begin
		$sformat(message, "Test completed successfully...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Test failed...");
		print(VERBOSITY_ERROR, message);
	end

	$stop;

end // initial

endmodule

