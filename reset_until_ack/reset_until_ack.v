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

