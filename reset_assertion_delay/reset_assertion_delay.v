/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
/*
This component is used to generate a delayed reset following an initial reset.
This is most useful in situations where you have a system that is clocked by a
PLL and you need to reset the PLL, however your system may contain synchronous
reset domains which you wish to reset prior to the PLL, since the PLL clock
output will stop running once you assert reset to the PLL.

This component asserts the reset_output asynchronously when it detects any
assertion glitch on the reset_input.  Then it starts the delay_count counter and
waits for it to expire before asserting the reset_output_delayed signal.  The
period of the delay_count counter can be set by the DELAY_COUNTER_WIDTH
parameter.

The SDC file that accompanies this component provides constraints that cut the
asynchronous input paths of the altera_reset_synchronizer instance.

To constrain the outputs of this component in your own SDC constraints, you can
locate the output registers of the component with something like this:
[get_registers {*reset_assertion_delay:*|reset_output_reg}]
[get_registers {*reset_assertion_delay:*|delay_count_expired}]

*/
`timescale 1 ps / 1 ps
module reset_assertion_delay #(
	parameter DELAY_COUNTER_WIDTH = 5
) (
	input  wire        clk,
	input  wire        power_on_reset,

	input  wire        reset_input,
	output wire        reset_output,
	output wire        reset_output_delayed
);

// capture glitches and synchronize the input
wire reset_input_capture;
altera_reset_synchronizer #(
	.ASYNC_RESET (1),
	.DEPTH       (3)
) reset_input_capture_inst (
	.reset_in  (reset_input),
	.clk       (clk),
	.reset_out (reset_input_capture)
);

wire reset_input_sync;
altera_std_synchronizer #(
        .depth (3)
) reset_input_sync_inst (
        .clk     (clk),
        .reset_n (~power_on_reset),
        .din     (reset_input_capture),
        .dout    (reset_input_sync)
);

// delay counter
reg delay_count_expired_int;
reg delay_count_expired;
reg [(DELAY_COUNTER_WIDTH - 1):0] delay_count;
always @ (posedge clk or posedge power_on_reset) begin
	if(power_on_reset) begin
		delay_count_expired_int <= 1'b1;
		delay_count_expired     <= 1'b1;
		delay_count         <= {DELAY_COUNTER_WIDTH{1'b1}};
	end else begin
		if(reset_input_sync | ((|delay_count) & ~delay_count_expired_int)) begin
			if(&delay_count) begin
				delay_count_expired_int <= 1'b1;
				delay_count_expired     <= 1'b1;
			end else begin
				delay_count <= delay_count + 1'b1;
			end
		end else begin
			delay_count_expired_int <= 1'b0;
			delay_count_expired     <= 1'b0;
			delay_count             <= 'h0;
		end
	end
end

// consolidate the reset output through one register
wire reset_condition;
assign reset_condition = power_on_reset | reset_input_capture | reset_input_sync;
reg reset_output_reg;
always @ (posedge clk or posedge reset_condition) begin
	if(reset_condition) begin
		reset_output_reg <= 1;
	end else begin
		reset_output_reg <= ((|delay_count) & ~delay_count_expired_int);
	end
end

assign reset_output = reset_output_reg;

assign reset_output_delayed = delay_count_expired;

endmodule

