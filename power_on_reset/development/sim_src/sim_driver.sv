/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
`timescale 1 ps / 1 ps

`define VERBOSITY VERBOSITY_INFO

`define TEST_SYS_INST	sim_top.tb.test_sys_inst
`define POR_INST 	sim_top.tb.test_sys_inst.por.por
`define STD_SYNC_INST	sim_top.tb.test_sys_inst.por.por.power_on_reset_std_sync_inst

module sim_driver();

import verbosity_pkg::*;

string message;

initial begin
	#490_001;
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

reg [9:0] clock_count;
reg last_reset_state;
reg test_success;
reg test_fail;

initial begin

	set_verbosity( `VERBOSITY );

	// force the registers in the Altera standard synchronizer to ZERO, just
	// like they would be in the FPGA device as they enter user mode.
	force `STD_SYNC_INST.din_s1 = 0;
	force `STD_SYNC_INST.dreg = 0;

	release `STD_SYNC_INST.din_s1;
	release `STD_SYNC_INST.dreg;

	//wait for reset to de-assert
	wait(test_success || test_fail);

	for(int i = 0 ; i < 8 ; i++)
		@(posedge `TEST_SYS_INST.por_clock_clk);

	if(test_success) begin
		$sformat(message, "Test completed successfully...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Test failed...");
		print(VERBOSITY_ERROR, message);
	end

	$stop;

end // initial

initial begin
	clock_count <= 0;
	last_reset_state <= 0;
	test_success <= 0;
	test_fail <= 0;
end
always @ (posedge `TEST_SYS_INST.por_clock_clk) begin
	clock_count <= clock_count + 1;
	last_reset_state <= `TEST_SYS_INST.por_reset_reset;

	if(clock_count == (`POR_INST.POR_COUNT + 1)) begin
		if(
			(last_reset_state == 1'b1) &&
			(`TEST_SYS_INST.por_reset_reset == 1'b0)
		) begin
			test_success <= 1'b1;
		end else begin
			test_fail <= 1'b1;
		end
	end

	if(&clock_count) begin
		test_fail <= 1'b1;
	end
end

endmodule

