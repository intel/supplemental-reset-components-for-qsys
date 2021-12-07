/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
`timescale 1 ps / 1 ps

`define VERBOSITY VERBOSITY_INFO

`define TEST_SYS_INST		sim_top.tb.test_sys_inst
`define STATUS_CONDUIT_BFM	sim_top.tb.test_sys_inst_emif_status_breakout_0_status_bfm.test_sys_inst_emif_status_breakout_0_status_bfm

module sim_driver();

import verbosity_pkg::*;

string message;

initial begin
	#161;
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

reg test_success;
reg [2:0] expected_value;
reg [2:0] output_value;

initial begin

	test_success = 1'b1;

	set_verbosity( `VERBOSITY );

	expected_value = 3'b000;
	for(int i = 0 ; i < 16 ; i++) begin
		`STATUS_CONDUIT_BFM.set_local_cal_success(expected_value[2]);
		`STATUS_CONDUIT_BFM.set_local_cal_fail(expected_value[1]);
		`STATUS_CONDUIT_BFM.set_local_init_done(expected_value[0]);
		#10;
		if(output_value == expected_value) begin
			$sformat(message, "Conduit outputs at expected values - 0x%h - 0x%h", expected_value, output_value);
			print(VERBOSITY_INFO, message);
		end else begin
			$sformat(message, "Conduit outputs at UNEXPECTED values - 0x%h - 0x%h", expected_value, output_value);
			print(VERBOSITY_ERROR, message);
			test_success = 1'b0;
		end

		expected_value = expected_value + 1'b1;
	end

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

	output_value = {`TEST_SYS_INST.emif_status_breakout_0_cal_success_event_input,
			`TEST_SYS_INST.emif_status_breakout_0_cal_fail_reset,
			`TEST_SYS_INST.emif_status_breakout_0_init_done_event_input};
end

endmodule

