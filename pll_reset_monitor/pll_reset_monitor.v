/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
/*
This component is used to generate reset for a PLL and monitor the acquisition
of lock for the PLL, and then monitor for PLL lock failures.

This component asserts the pll_reset output asynchronously with the assertion
of the pll_reset_request input.  Then the pll_reset output is asserted for a
minimum of the terminal count of the reset_count counter.  This allows you to
specify the minimum duration of the pll_reset output by setting the
RESET_COUNTER_WIDTH parameter.  Most Altera PLLs require a minimum of 10ns
assertion of their reset, however I would suggest that you allow this reset to
assert for 100ns to 1us just to be certain that other system reset effects are
allowed time to propogate throughout the system.

Once the pll_reset output is released, the pll_locked input is masked for the
duration of the lock_count counter which you can specify with the
LOCK_COUNTER_WIDTH parameter.  Altera typically recommends that you allow 1ms
for PLL lock acquisition, so you should select the value of LOCK_COUNTER_WIDTH
to produce a period near that timeframe.  At the expiration of the lock_count
the state of the pll_locked input is evaluated to produce a lock_success or
lock_failure output, and from that point on if the pll_locked glitches or drops
for any amount of time the lock_failure output should be asserted.  This circuit
allows the PLL lock to stutter into the locked state and then monitor for even a
small asynchronous glitch that indicates the loss of lock.

To achieve this behavior the pll_locked input is passed through the
altera_reset_synchronizer core to asynchronously detect glitches and synchronize
the pll_locked input into the proper clock domain.

There is an Avalon Slave interface on this component that provides access to
read the values of two counts that are captured in this component.  First, each
time the pll_locked input is asserted, the lock_count value is captured into a
register which can be read through the slave.  Second, each time the pll_locked
input is deasserted, a unlock_count counter is incremented and provided thru the
slave interface as well.  The lock_counter_width field contains the value of 19
minus the LOCK_COUNTER_WIDTH parameter.

The format of the 32-bits in the slave register are as follows:
	unlock_count_sync       [31:24] - 8-bit field
	lock_counter_width      [23:20] - 4-bit field
	capture_lock_count_sync [19:0]  - 20-bit field

The SDC file that accompanies this component provides constraints that cut the
asynchronous input paths of the altera_reset_synchronizer instance.

To constrain the outputs of this component in your own SDC constraints, you can
locate the output registers of the component with something like this:
[get_registers {*pll_reset_monitor:*|delayed_pll_reset}]
[get_registers {*pll_reset_monitor:*|lock_success_reg}]
[get_registers {*pll_reset_monitor:*|lock_failure_reg}]

*/
`timescale 1 ps / 1 ps
module pll_reset_monitor #(
	parameter RESET_COUNTER_WIDTH = 10,
	parameter LOCK_COUNTER_WIDTH  = 16
) (
	input  wire        pll_ref_clk,
	input  wire        pll_reset_request,
	input  wire        pll_locked,

	output wire        pll_reset,
	output wire        lock_success,
	output wire        lock_success_reset,
	output wire        lock_failure,
	output wire        lock_failure_reset,

	input  wire        s0_clk,
	input  wire        s0_reset,
	input  wire        s0_read,
	output wire [31:0] s0_readdata
);

// asynchronously capture and synchronize the pll_reset_request
wire pll_reset_request_sync;
altera_reset_synchronizer #(
	.ASYNC_RESET (1),
	.DEPTH       (3)
) pll_reset_request_sync_inst (
	.reset_in  (pll_reset_request),
	.clk       (pll_ref_clk),
	.reset_out (pll_reset_request_sync)
);

reg delayed_pll_reset;
reg [(RESET_COUNTER_WIDTH - 1):0] reset_count;
always @ (posedge pll_ref_clk or posedge pll_reset_request_sync) begin
	if(pll_reset_request_sync) begin
		reset_count <= 'h0;
		delayed_pll_reset <= 1'b1;
	end else begin
		if(&reset_count) begin
			delayed_pll_reset <= 1'b0;
		end else begin
			reset_count <= reset_count + 1'h1;
		end
	end
end

// use an altera_reset_synchronizer to capture potential lock failure glitches
wire not_pll_locked;
assign not_pll_locked = ~pll_locked;
wire not_pll_locked_sync;
altera_reset_synchronizer #(
	.ASYNC_RESET (1),
	.DEPTH       (3)
) pll_locked_sync_inst (
	.reset_in  (not_pll_locked),
	.clk       (pll_ref_clk),
	.reset_out (not_pll_locked_sync)
);

wire not_pll_locked_sync_sync;
altera_std_synchronizer #(
        .depth (3)
) pll_locked_sync_sync_inst (
        .clk     (pll_ref_clk),
        .reset_n (1'b1),
        .din     (not_pll_locked_sync),
        .dout    (not_pll_locked_sync_sync)
);

reg [1:0] edge_detect;
always @ (posedge pll_ref_clk or posedge pll_reset) begin
	if(pll_reset) begin
		edge_detect <= 2'b11;
	end else begin
		edge_detect[0] <= not_pll_locked_sync_sync;
		edge_detect[1] <= edge_detect[0];
	end
end

wire locked_edge_detected;
assign locked_edge_detected = (edge_detect == 2'b10) ? (1'b1) : (1'b0);

wire not_locked_edge_detected;
assign not_locked_edge_detected = (edge_detect == 2'b01) ? (1'b1) : (1'b0);

// pll lock acquisition count
reg lock_count_expired;
reg [(LOCK_COUNTER_WIDTH - 1):0]  lock_count;
always @ (posedge pll_ref_clk or posedge pll_reset) begin
	if(pll_reset) begin
		lock_count <= 'h0;
		lock_count_expired <= 1'b0;
	end else begin
		if(&lock_count) begin
			lock_count_expired <= 1'b1;
		end else begin
			lock_count <= lock_count + 1'h1;
		end
	end
end

// count unlock events
reg [7:0]  unlock_count;
always @ (posedge pll_ref_clk or posedge pll_reset) begin
	if(pll_reset) begin
		unlock_count <= 8'h00;
	end else begin
		if(~(&unlock_count)) begin
			if(not_locked_edge_detected) begin
				unlock_count <= unlock_count + 8'h01;
			end
		end
	end
end

wire [7:0] unlock_count_sync;
altera_std_synchronizer_bundle #(
	.width (LOCK_COUNTER_WIDTH),
	.depth (2)
) unlock_count_sync_inst (
	.clk     (s0_clk),
	.reset_n (~s0_reset),
	.din     (unlock_count),
	.dout    (unlock_count_sync)
);

// capture lock counter
reg [(LOCK_COUNTER_WIDTH - 1):0]  capture_lock_count;
always @ (posedge pll_ref_clk or posedge pll_reset) begin
	if(pll_reset) begin
		capture_lock_count <= 'h0;
	end else begin
		if(locked_edge_detected) begin
			capture_lock_count <= lock_count;
		end
	end
end

wire [(LOCK_COUNTER_WIDTH - 1):0] capture_lock_count_sync;
altera_std_synchronizer_bundle #(
	.width (LOCK_COUNTER_WIDTH),
	.depth (2)
) capture_lock_count_sync_inst (
	.clk     (s0_clk),
	.reset_n (~s0_reset),
	.din     (capture_lock_count),
	.dout    (capture_lock_count_sync)
);

wire [4:0] pre_lock_counter_width;
assign pre_lock_counter_width = LOCK_COUNTER_WIDTH[4:0] - 3'h4;
wire [3:0] lock_counter_width;
assign lock_counter_width = pre_lock_counter_width[3:0];

// register the success or failure indication so there is a single register that
// produces the output.  This will make constraining these outputs easier to
// manage.
reg lock_success_reg;
reg lock_failure_reg;
always @ (posedge pll_ref_clk or posedge pll_reset) begin
	if(pll_reset) begin
		lock_success_reg <= 1'b0;
		lock_failure_reg <= 1'b0;
	end else begin
		lock_success_reg <= lock_count_expired & ~not_pll_locked_sync_sync;
		lock_failure_reg <= lock_count_expired & not_pll_locked_sync_sync;
	end
end

assign s0_readdata = {unlock_count_sync, lock_counter_width, {(20 - LOCK_COUNTER_WIDTH){1'b0}}, capture_lock_count_sync};

assign pll_reset = delayed_pll_reset;

assign lock_success = lock_success_reg;
assign lock_success_reset = lock_success_reg;

assign lock_failure = lock_failure_reg;
assign lock_failure_reset = lock_failure_reg;

endmodule

