/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
/*
This component is used to capture the occurance of an event, like the EMIF
calibration sequence completing successfully, or the EMIF initialization
sequence completing.  These events can take some time to complete and you may
wish to delay further system initialization until they do, and if they don't
complete in a timely fashion or if they fail, you may want to begin some sort of
system recovery in response to that.

This component starts the timeout_count counter which you can set with the
parameter TIMEOUT_COUNTER_WIDTH, and it monitors the event_input signal,
expecting it to assert before the timeout_count counter expires.  If the counter
expires before the event occurs, then the timeout signal is asserted.  If the
event occurs before the counter expires then the acquired signal is asserted.
And if the event is acquired but then deasserts at any time after that, the lost
signal will assert.

There  is an Avalon Slave interface on this component that provides access to
read the value of the timeout_count counter value that is captured at the
assertion of the event_input signal.

The format of the 32-bits in the slave register are as follows:
	capture_timeout_count_sync [31:0]  - 32-bit field

To constrain the outputs of this component in your own SDC constraints, you can
locate the output registers of the component with something like this:
[get_registers {*event_timer:*|timeout_count_expired}]
[get_registers {*event_timer:*|event_acquired}]
[get_registers {*event_timer:*|event_lost}]

*/
`timescale 1 ps / 1 ps
module event_timer #(
	parameter TIMEOUT_COUNTER_WIDTH = 16
) (
	input  wire        event_clk,
	input  wire        event_reset,
	input  wire        event_input,

	output wire        timeout,
	output wire        timeout_reset,
	output wire        acquired,
	output wire        acquired_reset,
	output wire        lost,
	output wire        lost_reset,

	input  wire        s0_clk,
	input  wire        s0_reset,
	input  wire        s0_read,
	output wire [31:0] s0_readdata
);

// synchronize the event input
wire event_input_sync;
altera_std_synchronizer #(
        .depth (3)
) event_input_sync_inst (
        .clk     (event_clk),
        .reset_n (~event_reset),
        .din     (event_input),
        .dout    (event_input_sync)
);

// event acquisition count
reg timeout_count_expired;
reg event_acquired_int;
reg event_acquired;
reg event_lost;
reg [(TIMEOUT_COUNTER_WIDTH - 1):0]  timeout_count;
always @ (posedge event_clk or posedge event_reset) begin
	if(event_reset) begin
		timeout_count         <= 'h0;
		event_acquired_int    <= 1'b0;
		event_acquired        <= 1'b0;
		event_lost            <= 1'b0;
		timeout_count_expired <= 1'b0;
	end else begin
		if(event_acquired_int) begin
			if(~event_input_sync) begin
				event_lost <= 1'b1;
			end
		end else begin
			if(event_input_sync) begin
				event_acquired_int <= 1'b1;
				event_acquired     <= 1'b1;
			end

			if(&timeout_count) begin
				timeout_count_expired <= 1'b1;
			end else begin
				timeout_count <= timeout_count + 1'h1;
			end
		end
	end
end

// capture event acquired count
reg [(TIMEOUT_COUNTER_WIDTH - 1):0]  capture_timeout_count;
always @ (posedge event_clk or posedge event_reset) begin
	if(event_reset) begin
		capture_timeout_count <= 'h0;
	end else begin
		if(event_input_sync & ~event_acquired_int) begin
			capture_timeout_count <= timeout_count;
		end
	end
end

wire [(TIMEOUT_COUNTER_WIDTH - 1):0] capture_timeout_count_sync;
altera_std_synchronizer_bundle #(
	.width (TIMEOUT_COUNTER_WIDTH),
	.depth (2)
) capture_timeout_count_sync_inst (
	.clk     (s0_clk),
	.reset_n (~s0_reset),
	.din     (capture_timeout_count),
	.dout    (capture_timeout_count_sync)
);


assign s0_readdata = {{(32 - TIMEOUT_COUNTER_WIDTH){1'b0}}, capture_timeout_count_sync};

assign timeout = timeout_count_expired;
assign timeout_reset = timeout_count_expired;

assign acquired = event_acquired;
assign acquired_reset = event_acquired;

assign lost = event_lost;
assign lost_reset = event_lost;

endmodule

