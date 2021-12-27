/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
/*
This component is used to count reset events.  This can be useful for system
health monitoring and system failure diagnosis.

After power_on_reset is released, this component will count the assertion and
deassertion events that it witnesses on its reset_event input.  There is an
asynchronous glitch capture circuit that synchronizes asynchronous glitches into
the component's clock domain, so this component will not capture multiple
glitches that occur within a 3 clock period window of each other.  In other
words glitches that occur within less than 3 clock periods will effectively
stretch the original glitch detection, and therefore cannot be counted as a new
glitch event.

The width of the counters is parameterized by the COUNTER_WIDTH parameter and
should not be set greater than 16.  Each counter is the same width.

There is an Avalon Slave interface on this component that provides access to
read the values of the two counts that are captured in this component.

The format of the 32-bits in the slave register are as follows:
	deassertion_count_sync  [31:16] - 16-bit field
	assertion_count_sync    [15:0]  - 16-bit field

The SDC file that accompanies this component provides constraints that cut the
asynchronous input paths of the altera_reset_synchronizer instance.

*/
`timescale 1 ps / 1 ps
module reset_event_counter #(
	parameter COUNTER_WIDTH  = 16
) (
	input  wire        clk,
	input  wire        power_on_reset,
	input  wire        reset_event,

	input  wire        s0_clk,
	input  wire        s0_reset,
	input  wire        s0_read,
	output wire [31:0] s0_readdata
);

// asynchronously capture and synchronize the power_on_reset
wire power_on_reset_sync;
altera_reset_synchronizer #(
	.ASYNC_RESET (1),
	.DEPTH       (3)
) power_on_reset_sync_inst (
	.reset_in  (power_on_reset),
	.clk       (clk),
	.reset_out (power_on_reset_sync)
);

// use an altera_reset_synchronizer to capture reset_event glitches
wire reset_event_sync;
altera_reset_synchronizer #(
	.ASYNC_RESET (1),
	.DEPTH       (3)
) reset_event_sync_inst (
	.reset_in  (reset_event),
	.clk       (clk),
	.reset_out (reset_event_sync)
);

wire reset_event_sync_sync;
altera_std_synchronizer #(
        .depth (3)
) reset_event_sync_sync_inst (
        .clk     (clk),
        .reset_n (1'b1),
        .din     (reset_event_sync),
        .dout    (reset_event_sync_sync)
);

// edge detection
reg [1:0] edge_detect;
always @ (posedge clk) begin
	edge_detect[0] <= reset_event_sync_sync;
	edge_detect[1] <= edge_detect[0];
end

wire deassertion_edge_detected;
assign deassertion_edge_detected = (edge_detect == 2'b10) ? (1'b1) : (1'b0);

wire assertion_edge_detected;
assign assertion_edge_detected = (edge_detect == 2'b01) ? (1'b1) : (1'b0);

// count assertion events
reg [(COUNTER_WIDTH - 1):0]  assertion_count;
always @ (posedge clk or posedge power_on_reset_sync) begin
	if(power_on_reset_sync) begin
		assertion_count <= 'h00;
	end else begin
		if(~(&assertion_count)) begin
			if(assertion_edge_detected) begin
				assertion_count <= assertion_count + 1'b1;
			end
		end
	end
end

wire [(COUNTER_WIDTH - 1):0] assertion_count_sync;
altera_std_synchronizer_bundle #(
	.width (COUNTER_WIDTH),
	.depth (2)
) assertion_count_sync_inst (
	.clk     (s0_clk),
	.reset_n (~s0_reset),
	.din     (assertion_count),
	.dout    (assertion_count_sync)
);

// count deassertion events
reg [(COUNTER_WIDTH - 1):0]  deassertion_count;
always @ (posedge clk or posedge power_on_reset_sync) begin
	if(power_on_reset_sync) begin
		deassertion_count <= 'h00;
	end else begin
		if(~(&deassertion_count)) begin
			if(deassertion_edge_detected) begin
				deassertion_count <= deassertion_count + 1'b1;
			end
		end
	end
end

wire [(COUNTER_WIDTH - 1):0] deassertion_count_sync;
altera_std_synchronizer_bundle #(
	.width (COUNTER_WIDTH),
	.depth (2)
) deassertion_count_sync_inst (
	.clk     (s0_clk),
	.reset_n (~s0_reset),
	.din     (deassertion_count),
	.dout    (deassertion_count_sync)
);

assign s0_readdata = {{(16 - COUNTER_WIDTH){1'b0}}, deassertion_count_sync, {(16 - COUNTER_WIDTH){1'b0}}, assertion_count_sync};

endmodule

