/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
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

