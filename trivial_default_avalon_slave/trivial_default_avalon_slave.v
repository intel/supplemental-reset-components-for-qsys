/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
/*
This component is used as a default slave in a Qsys system.  The functionality
is trivial however it can serve many use cases.

The slave interface width is defined by the DATA_BYTES parameter and can be
between 1 and 512 bytes in width.  This allows you to optimize the size for your
system as you can align this width to the width of the masters that you connect
it to.  You set the value returned by read accesses with the parameter
READ_DATA_PATTERN.  This pattern is returned in every byte lane based on the
byte width of the slave.

The slave will assert the response port and you can set the value of the
response with the parameter RESPONSE_PATTERN.  The valid patterns are as follow:
	00: OKAY
	01: RESERVED
	10: SLAVEERROR
	11: DECODEERROR

The response ports can be suppressed by setting the NO_RESPONSE_PORT parameter
provided in the hw.tcl script.

The slave can be set to always respond, or never respond by using the parameter
NEVER_RESPOND.

There is an access_event indication that is provided on three different outputs,
an interrupt, a reset and a conduit interface.  Each of these interfaces can be
suppressed or enabled with an hw.tcl parameter.  The access_event will be
cleared with a reset or the assertion of the clear_event input.

The clear_event input is an optional conduit input that can be used to clear the
access_event indicators and release the waitrequest port in NEVER_RESPOND mode.
The rising edge of the clear_event input is the trigger for clearing the event.
This input is asynchronously captured and synchronized internally so it must be
asserted for a minimum of 2 clock cycles.  There is an hw.tcl parameter that can
be used to suppress this interface.

*/
`timescale 1 ps / 1 ps
module trivial_default_avalon_slave #(
	parameter DATA_BYTES = 1,
	parameter READ_DATA_PATTERN = 0,
	parameter RESPONSE_PATTERN = 0,
	parameter NEVER_RESPOND = 0
) (
	input  wire                            clock_clk,
	input  wire                            reset_reset,

	input  wire                            slave_read,
	output wire [((DATA_BYTES * 8) - 1):0] slave_readdata,
	output wire                            slave_readdatavalid,
	output wire [1:0]                      slave_response,
	output wire                            slave_writeresponsevalid,
	input  wire                            slave_write,
	input  wire [((DATA_BYTES * 8) - 1):0] slave_writedata,
	input  wire [(DATA_BYTES - 1):0]       slave_byteenable,
	output wire                            slave_waitrequest,

	input  wire                            clear_event,

	output wire                            access_event_conduit,
	output wire                            access_event_reset,
	output wire                            access_event_interrupt
);

// synchronize the clear_event input
wire clear_event_sync;
altera_std_synchronizer #(
        .depth (3)
) pll_locked_sync_sync_inst (
        .clk     (clock_clk),
        .reset_n (~reset_reset),
        .din     (clear_event),
        .dout    (clear_event_sync)
);

// detect edges
reg [1:0] edge_detect;
always @ (posedge clock_clk or posedge reset_reset) begin
	if(reset_reset) begin
		edge_detect <= 2'b00;
	end else begin
		edge_detect[0] <= clear_event_sync;
		edge_detect[1] <= edge_detect[0];
	end
end

wire assertion_edge_detected;
assign assertion_edge_detected = (edge_detect == 2'b01) ? (1'b1) : (1'b0);

//wire deassertion_edge_detected;
//assign deassertion_edge_detected = (edge_detect == 2'b10) ? (1'b1) : (1'b0);

// set the readdata output to the parameter value
assign slave_readdata = {DATA_BYTES{READ_DATA_PATTERN[7:0]}};

// calculate an internal waitrequest
reg internal_waitrequest;
always @ (posedge clock_clk or posedge reset_reset) begin
	if(reset_reset) begin
		internal_waitrequest <= 1'b1;
	end else begin
		if(~internal_waitrequest) begin
			internal_waitrequest <= 1'b1;
		end else begin
			internal_waitrequest <= ~(slave_read | slave_write);
		end
	end
end

// output waitrequest based on parameter
generate
if(NEVER_RESPOND == 0)
	assign slave_waitrequest = internal_waitrequest;
else
	assign slave_waitrequest = ~assertion_edge_detected;
endgenerate

// set the response output to the parameter value
assign slave_response = RESPONSE_PATTERN[1:0];

// calculate an internal writeresponsevalid
reg internal_writeresponsevalid;
always @ (posedge clock_clk or posedge reset_reset) begin
	if(reset_reset) begin
		internal_writeresponsevalid <= 1'b0;
	end else begin
		internal_writeresponsevalid <= slave_write & ~slave_waitrequest;
	end
end

assign slave_writeresponsevalid = internal_writeresponsevalid;

// calculate an internal readdatavalid
reg internal_readdatavalid;
always @ (posedge clock_clk or posedge reset_reset) begin
	if(reset_reset) begin
		internal_readdatavalid <= 1'b0;
	end else begin
		internal_readdatavalid <= slave_read & ~slave_waitrequest;
	end
end

assign slave_readdatavalid = internal_readdatavalid;

// calculate an internal access event
reg internal_access_event;
always @ (posedge clock_clk or posedge reset_reset) begin
	if(reset_reset) begin
		internal_access_event <= 1'b0;
	end else begin
		if(assertion_edge_detected) begin
			internal_access_event <= 1'b0;
		end else begin
			if(slave_read | slave_write) begin
				internal_access_event <= 1'b1;
			end
		end
	end
end

assign access_event_conduit = internal_access_event;

assign access_event_reset = internal_access_event;

assign access_event_interrupt = internal_access_event;

endmodule

