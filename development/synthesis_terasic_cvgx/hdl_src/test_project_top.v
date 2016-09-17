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
module test_project_top
(
	///////// CLOCK /////////
	input              CLOCK_50_B5B,
	input              CLOCK_50_B6A,

	///////// CPU /////////
	input              CPU_RESET_n,

	///////// DDR2LP /////////
	output      [9:0]  DDR2LP_CA,
	output      [1:0]  DDR2LP_CKE,
	output             DDR2LP_CK_n,
	output             DDR2LP_CK_p,
	output      [1:0]  DDR2LP_CS_n,
	output      [3:0]  DDR2LP_DM,
	inout       [31:0] DDR2LP_DQ,
	inout       [3:0]  DDR2LP_DQS_n,
	inout       [3:0]  DDR2LP_DQS_p,
	input              DDR2LP_OCT_RZQ,

	///////// LEDG /////////
	output      [7:0]  LEDG,

	///////// LEDR /////////
	output      [9:0]  LEDR
);

test_sys u0 (
	.system_pll_ref_clk_50m_in_clk_clk      (CLOCK_50_B6A),

	.ddr_emif_pll_ref_clk_50m_in_clk_clk    (CLOCK_50_B5B),

	.resets_cpu_reset_n_in_reset_reset_n    (CPU_RESET_n),

	.memory_mem_ca                          (DDR2LP_CA),
	.memory_mem_ck                          (DDR2LP_CK_p),
	.memory_mem_ck_n                        (DDR2LP_CK_n),
	.memory_mem_cke                         (DDR2LP_CKE),
	.memory_mem_cs_n                        (DDR2LP_CS_n),
	.memory_mem_dm                          (DDR2LP_DM),
	.memory_mem_dq                          (DDR2LP_DQ),
	.memory_mem_dqs                         (DDR2LP_DQS_p),
	.memory_mem_dqs_n                       (DDR2LP_DQS_n),
	.oct_rzqin                              (DDR2LP_OCT_RZQ),

	.led_pio_out_external_connection_export ({LEDR, LEDG})
);

endmodule

