/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
/*
This component is used to debounce a noisy reset input source, such as that
provided by an external push button switch, which may produce noise glitches and
spikes as the button is mechanically pressed and released.

This component monitors the reset_input port for assertion glitches and
asynchronously captures them with an altera_reset_synchronizer core.  Once a
reset_input assertion is applied, this component asserts the reset_output signal
and then begins monitoring the reset_input signal for deassertion.  Once the
reset_input deasserts, the debounce_count counter begins counting to measure a
debounce period.  The reset_output signal is not released until the reset_input
is deasserted and the debounce_count has expired.  The DEBOUNCE_COUNTER_WIDTH
parameter allows you to specify how long the debounce duration should be.

There is an Avalon Slave interface on this component that provides access to
read the values of three counts that are captured in this component.  Both the
assertion and deassertion counts of the reset_input are counted and provided
through the slave interface.  Also at each deassertion of the reset_input signal
the debounce_count counter is captured and provided through the slave interface.
NOTE: only the each initial assertion edge is counted, but then each deassertion
edge is counted as the debounce counter runs and the value captured for the
debounce_count counter is the final occurance of deassertion that was captured.
Also, each counter will stop incrementing when it reaches it's maximal count, it
will not wrap.

The format of the 32-bits in the slave register are as follows:
	assertion_edge_count   [31:29] - 3-bit field
	deassertion_edge_count [28:24] - 5-bit field
	capture_debounce_count [23:0]  - 24-bit field

The SDC file that accompanies this component provides constraints that cut the
asynchronous input paths of the altera_reset_synchronizer instance.

To constrain the outputs of this component in your own SDC constraints, you can
locate the output registers of the component with something like this:
[get_registers {*reset_debouncer:*|reset_output_reg}]

*/
`timescale 1 ps / 1 ps
module reset_debouncer #(
	parameter DEBOUNCE_COUNTER_WIDTH = 16
) (
	input  wire        clk,
	input  wire        power_on_reset,

	input  wire        reset_input,
	output wire        reset_output,

	input  wire        s0_clk,
	input  wire        s0_reset,
	input  wire        s0_read,
	output wire [31:0] s0_readdata
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

// detect edges
reg [1:0] edge_detect;
always @ (posedge clk or posedge power_on_reset) begin
	if(power_on_reset) begin
		edge_detect <= 2'b00;
	end else begin
		edge_detect[0] <= reset_input_sync;
		edge_detect[1] <= edge_detect[0];
	end
end

wire assertion_edge_detected;
assign assertion_edge_detected = (edge_detect == 2'b01) ? (1'b1) : (1'b0);

wire deassertion_edge_detected;
assign deassertion_edge_detected = (edge_detect == 2'b10) ? (1'b1) : (1'b0);

// debounce count
reg saw_assertion;
reg saw_deassertion;
reg [2:0] assertion_edge_count;
reg [4:0] deassertion_edge_count;
reg debounce_count_expired;
reg [(DEBOUNCE_COUNTER_WIDTH - 1):0] debounce_count;
always @ (posedge clk or posedge power_on_reset) begin
	if(power_on_reset) begin
		saw_assertion          <= 1'b0;
		saw_deassertion        <= 1'b0;
		assertion_edge_count   <= 3'h0;
		deassertion_edge_count <= 5'h0;
		debounce_count_expired <= 1'b0;
		debounce_count         <= 'h0;
	end else begin
		if(saw_assertion) begin
			if(saw_deassertion) begin
				if(&debounce_count) begin
					debounce_count_expired <= 1'b1;
				end else begin
					debounce_count <= debounce_count + 1'b1;
				end

				if(deassertion_edge_detected & ~&deassertion_edge_count) begin
					deassertion_edge_count <= deassertion_edge_count + 1'b1;
				end
			end else begin
				if(deassertion_edge_detected) begin
					saw_deassertion <= 1'b1;
					if(~&deassertion_edge_count) begin
						deassertion_edge_count <= deassertion_edge_count + 1'b1;
					end
				end
			end

		end else begin
			if(assertion_edge_detected) begin
				saw_assertion <= 1'b1;
				deassertion_edge_count <= 5'h0;
				if(~&assertion_edge_count) begin
					assertion_edge_count <= assertion_edge_count + 1'b1;
				end
			end
		end

		if(debounce_count_expired) begin
			saw_assertion          <= 1'b0;
			saw_deassertion        <= 1'b0;
			debounce_count_expired <= 1'b0;
			debounce_count         <= 'h0;
			if(reset_input_sync & &edge_detect) begin
				saw_assertion <= 1'b1;
				deassertion_edge_count <= 5'h0;
				if(~&assertion_edge_count) begin
					assertion_edge_count <= assertion_edge_count + 1'b1;
				end
			end
		end
	end
end

// consolidate the reset output through one register
wire reset_condition;
assign reset_condition = reset_input_capture | reset_input_sync | saw_assertion;
reg reset_output_reg;
always @ (posedge clk or posedge reset_condition) begin
	if(reset_condition) begin
		reset_output_reg <= 1;
	end else begin
		reset_output_reg <= reset_condition;
	end
end

// capture debounce count
reg [(DEBOUNCE_COUNTER_WIDTH - 1):0]  capture_debounce_count;
always @ (posedge clk or posedge power_on_reset) begin
	if(power_on_reset) begin
		capture_debounce_count <= 'h0;
	end else begin
		if(deassertion_edge_detected) begin
			capture_debounce_count <= debounce_count;
		end
	end
end

// synchronize to Avalon Slave
wire [31:0] debounce_counts_sync;
altera_std_synchronizer_bundle #(
	.width (32),
	.depth (2)
) debounce_counts_sync_inst (
	.clk     (s0_clk),
	.reset_n (~s0_reset),
	.din     ({assertion_edge_count, deassertion_edge_count, {(24 - DEBOUNCE_COUNTER_WIDTH){1'b0}},capture_debounce_count}),
	.dout    (debounce_counts_sync)
);


assign s0_readdata = debounce_counts_sync;

assign reset_output = reset_output_reg;

endmodule

