/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
/*
This component provides two reset inputs, one that will assert the reset output
and the second which will release the reset output.

This is intended to be used in trivial use cases where a reset must be asserted
only until some other event or acknoledgement of the reset is detected.  These
situations can arrise in certain Nios II reset request, HPS reset request, PCIe
reset request, and other more generic scenarios.

*/
`timescale 1 ps / 1 ps
module reset_until_ack (
	input  wire  clk_in_clk,
	input  wire  reset_assert_reset,

	input  wire  reset_release_reset,

	output wire  reset_out_reset
);

reg reset_out;

assign reset_out_reset = reset_out;

always @ (posedge clk_in_clk or posedge reset_assert_reset) begin
	if(reset_assert_reset) begin
		reset_out <= 1'b1;
	end else begin
		if(reset_release_reset) begin
			reset_out <= 1'b0;
		end
	end
end

endmodule

