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
`define STATUS_CONDUIT_BFM	sim_top.tb.test_sys_inst_emif_status_breakout_0_status_bfm

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

