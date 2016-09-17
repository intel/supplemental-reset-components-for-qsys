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

`timescale 1 ps / 1 ps

`define VERBOSITY VERBOSITY_INFO

`define TEST_SYS_INST		sim_top.tb.test_sys_inst
`define POWER_ON_RESET_BFM	sim_top.tb.test_sys_inst_reset_assertion_delay_0_power_on_reset_bfm
`define RESET_INPUT_BFM		sim_top.tb.test_sys_inst_reset_assertion_delay_0_reset_input_bfm

module sim_driver();

import verbosity_pkg::*;

string message;

initial begin
	#7_730_001;
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

reg test_success;
integer expected_time;
integer cur_time;

initial begin

	test_success <= 1'b1;

	set_verbosity( `VERBOSITY );

	// wait for reset to de-assert
	wait(`TEST_SYS_INST.reset_assertion_delay_0_power_on_reset_reset == 1'b0);
	`POWER_ON_RESET_BFM.reset_assert();
	wait(`TEST_SYS_INST.reset_assertion_delay_0_reset_input_reset == 1'b0);

        for(int i = 0 ; i < 64 ; i++)
                @(posedge `TEST_SYS_INST.reset_assertion_delay_0_clock_clk);

	`POWER_ON_RESET_BFM.reset_deassert();

	// test normal POR operation
	wait(`TEST_SYS_INST.reset_assertion_delay_0_reset_output_reset == 1'b0);
	
	expected_time = 'd2290000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Reset output deasserted at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Reset output deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
	end
	
	wait(`TEST_SYS_INST.reset_assertion_delay_0_reset_output_delayed_reset == 1'b0);
	
	expected_time = 'd2290000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Reset output delayed deasserted at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Reset output delayed deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
	end
	
	// test normal reset_input operation
        for(int i = 0 ; i < 64 ; i++)
                @(posedge `TEST_SYS_INST.reset_assertion_delay_0_clock_clk);

	#4000;
	`RESET_INPUT_BFM.reset_assert();
	#1000;
	`RESET_INPUT_BFM.reset_deassert();

	wait(`TEST_SYS_INST.reset_assertion_delay_0_reset_output_reset == 1'b1);
	
	expected_time = 'd3575000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Reset output asserted at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Reset output asserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
	end
	
	wait(`TEST_SYS_INST.reset_assertion_delay_0_reset_output_delayed_reset == 1'b1);
	
	expected_time = 'd4270000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Reset output delayed asserted at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Reset output delayed asserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
	end
	
	wait(`TEST_SYS_INST.reset_assertion_delay_0_reset_output_reset == 1'b0);

	expected_time = 'd4290000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Reset output deasserted at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Reset output deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
	end
	
	wait(`TEST_SYS_INST.reset_assertion_delay_0_reset_output_delayed_reset == 1'b0);

	expected_time = 'd4290000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Reset output delayed deasserted at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Reset output delayed deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
	end
	
	// test extended reset_input operation
        for(int i = 0 ; i < 64 ; i++)
                @(posedge `TEST_SYS_INST.reset_assertion_delay_0_clock_clk);

	`RESET_INPUT_BFM.reset_assert();

	wait(`TEST_SYS_INST.reset_assertion_delay_0_reset_output_reset == 1'b1);
	
	expected_time = 'd5570000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Reset output asserted at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Reset output asserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
	end
	
	wait(`TEST_SYS_INST.reset_assertion_delay_0_reset_output_delayed_reset == 1'b1);
	
	expected_time = 'd6270000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Reset output delayed asserted at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Reset output delayed asserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
	end
	
        for(int i = 0 ; i < 64 ; i++)
                @(posedge `TEST_SYS_INST.reset_assertion_delay_0_clock_clk);
	`RESET_INPUT_BFM.reset_deassert();

	wait(`TEST_SYS_INST.reset_assertion_delay_0_reset_output_reset == 1'b0);

	expected_time = 'd7710000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Reset output deasserted at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Reset output deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
	end
	
	wait(`TEST_SYS_INST.reset_assertion_delay_0_reset_output_delayed_reset == 1'b0);

	expected_time = 'd7710000;
	cur_time = $time;
	if(expected_time == cur_time) begin
	        $sformat(message, "Reset output delayed deasserted at expected time: %d : %d", cur_time, expected_time);
	        print(VERBOSITY_INFO, message);
	end else begin
	        $sformat(message, "Reset output delayed deasserted at UNEXPECTED time: %d : %d", cur_time, expected_time);
		        print(VERBOSITY_ERROR, message);
		        test_success <= 1'b0;
	end
	
	// finish
        @(posedge `TEST_SYS_INST.reset_assertion_delay_0_clock_clk);
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

