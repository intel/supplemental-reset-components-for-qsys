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

`define INPUT_CONDUIT_BFM	sim_top.tb.test_sys_inst_conduit_remap_0_input_conduit_bfm
`define OUTPUT_CONDUIT_BFM	sim_top.tb.test_sys_inst_conduit_remap_0_output_conduit_bfm

`define C2I_CONDUIT_BFM		sim_top.tb.test_sys_inst_conduit_to_interrupt_0_input_conduit_bfm
`define C2I_INTERRUPT_BFM	sim_top.tb.test_sys_inst_conduit_to_interrupt_0_output_interrupt_bfm

`define C2R_CONDUIT_BFM		sim_top.tb.test_sys_inst_conduit_to_reset_0_input_conduit_bfm
`define C2R_RESET		`TEST_SYS_INST.conduit_to_reset_0_output_reset_reset

`define I2C_INTERRUPT_BFM	sim_top.tb.test_sys_inst_interrupt_to_conduit_0_input_interrupt_bfm
`define I2C_CONDUIT_BFM		sim_top.tb.test_sys_inst_interrupt_to_conduit_0_output_conduit_bfm

`define R2C_RESET_BFM		sim_top.tb.test_sys_inst_reset_to_conduit_0_input_reset_bfm
`define R2C_CONDUIT_BFM		sim_top.tb.test_sys_inst_reset_to_conduit_0_output_conduit_bfm

`define CLOCK_BFM_CLK		sim_top.tb.test_sys_inst_reset_to_conduit_0_input_reset_bfm_clk_bfm.clk
`define RESET_BFM_RESET		sim_top.tb.test_sys_inst_reset_to_conduit_0_input_reset_bfm.reset

module sim_driver();

import verbosity_pkg::*;

string message;

initial begin
	#4_230_001;
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

reg test_success;
reg expected_value;

initial begin

	test_success = 1'b1;

	set_verbosity( `VERBOSITY );

	`INPUT_CONDUIT_BFM.set_input(1'b0);
	`C2I_CONDUIT_BFM.set_input(1'b0);
	`C2R_CONDUIT_BFM.set_input(1'b0);

	wait(`RESET_BFM_RESET == 1'b0);
	@(posedge `CLOCK_BFM_CLK);
	@(posedge `CLOCK_BFM_CLK);
	
	// conduit to conduit
	expected_value = 1'b0;
	for(int i = 0 ; i < 16 ; i++) begin
		`INPUT_CONDUIT_BFM.set_input(expected_value);
		@(posedge `CLOCK_BFM_CLK);
		if(`OUTPUT_CONDUIT_BFM.get_output() == expected_value) begin
			$sformat(message, "Conduit output at expected value - %d - %d", expected_value, `OUTPUT_CONDUIT_BFM.get_output());
			print(VERBOSITY_INFO, message);
		end else begin
			$sformat(message, "Conduit output at UNEXPECTED value - %d - %d", expected_value, `OUTPUT_CONDUIT_BFM.get_output());
			print(VERBOSITY_ERROR, message);
			test_success = 1'b0;
		end
	
		expected_value = expected_value ^ 1'b1;
	end
	
	// conduit to interrupt
	expected_value = 1'b0;
	for(int i = 0 ; i < 16 ; i++) begin
		`C2I_CONDUIT_BFM.set_input(expected_value);
		@(posedge `CLOCK_BFM_CLK);
		@(posedge `CLOCK_BFM_CLK);
		@(posedge `CLOCK_BFM_CLK);
		@(posedge `CLOCK_BFM_CLK);
		@(posedge `CLOCK_BFM_CLK);
		if(`C2I_INTERRUPT_BFM.get_irq() == expected_value) begin
			$sformat(message, "Interrupt output at expected value - %d - %d", expected_value, `C2I_INTERRUPT_BFM.get_irq());
			print(VERBOSITY_INFO, message);
		end else begin
			$sformat(message, "Interrupt output at UNEXPECTED value - %d - %d", expected_value, `C2I_INTERRUPT_BFM.get_irq());
			print(VERBOSITY_ERROR, message);
			test_success = 1'b0;
		end
	
		expected_value = expected_value ^ 1'b1;
	end
	
	// conduit to reset
	expected_value = 1'b0;
	for(int i = 0 ; i < 16 ; i++) begin
		`C2R_CONDUIT_BFM.set_input(expected_value);
		@(posedge `CLOCK_BFM_CLK);
		if(`C2R_RESET == expected_value) begin
			$sformat(message, "Reset output at expected value - %d - %d", expected_value, `C2R_RESET);
			print(VERBOSITY_INFO, message);
		end else begin
			$sformat(message, "Reset output at UNEXPECTED value - %d - %d", expected_value, `C2R_RESET);
			print(VERBOSITY_ERROR, message);
			test_success = 1'b0;
		end
	
		expected_value = expected_value ^ 1'b1;
	end
	
	// interrupt to conduit
	expected_value = 1'b0;
	for(int i = 0 ; i < 16 ; i++) begin
		if(expected_value) begin
			`I2C_INTERRUPT_BFM.set_irq();
		end else begin
			`I2C_INTERRUPT_BFM.clear_irq();
		end
		@(posedge `CLOCK_BFM_CLK);
		@(posedge `CLOCK_BFM_CLK);
		if(`I2C_CONDUIT_BFM.get_output() == expected_value) begin
			$sformat(message, "Conduit output at expected value - %d - %d", expected_value, `I2C_CONDUIT_BFM.get_output());
			print(VERBOSITY_INFO, message);
		end else begin
			$sformat(message, "Conduit output at UNEXPECTED value - %d - %d", expected_value, `I2C_CONDUIT_BFM.get_output());
			print(VERBOSITY_ERROR, message);
			test_success = 1'b0;
		end
	
		expected_value = expected_value ^ 1'b1;
	end
	
	// reset to conduit
	expected_value = 1'b0;
	for(int i = 0 ; i < 16 ; i++) begin
		if(expected_value) begin
			`R2C_RESET_BFM.reset_assert();
		end else begin
			`R2C_RESET_BFM.reset_deassert();
		end
		@(posedge `CLOCK_BFM_CLK);
		if(`R2C_CONDUIT_BFM.get_output() == expected_value) begin
			$sformat(message, "Conduit output at expected value - %d - %d", expected_value, `R2C_CONDUIT_BFM.get_output());
			print(VERBOSITY_INFO, message);
		end else begin
			$sformat(message, "Conduit output at UNEXPECTED value - %d - %d", expected_value, `R2C_CONDUIT_BFM.get_output());
			print(VERBOSITY_ERROR, message);
			test_success = 1'b0;
		end
	
		expected_value = expected_value ^ 1'b1;
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

endmodule

