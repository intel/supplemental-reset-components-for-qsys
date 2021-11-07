/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
`timescale 1 ps / 1 ps

`define VERBOSITY VERBOSITY_INFO

`define TEST_SYS_INST		sim_top.tb.test_sys_inst
`define PLL_LOCKED_CONDUIT_BFM	sim_top.tb.test_sys_inst_pll_sharing_to_pll_locked_0_pll_locked_bfm
`define SHARING_CONDUIT_BFM	sim_top.tb.test_sys_inst_pll_sharing_to_pll_locked_0_pll_sharing_bfm

module sim_driver();

import verbosity_pkg::*;

string message;

initial begin
	#321;
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

reg test_success;
reg expected_value;

initial begin

	test_success = 1'b1;

	set_verbosity( `VERBOSITY );

	expected_value = 1'b0;
	`SHARING_CONDUIT_BFM.set_afi_phy_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_addr_cmd_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_avl_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_avl_phy_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_config_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_mem_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_mem_phy_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_write_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_write_clk_pre_phy_clk(expected_value);
	for(int i = 0 ; i < 16 ; i++) begin
		`SHARING_CONDUIT_BFM.set_pll_locked(expected_value);
		#10;
		if(`PLL_LOCKED_CONDUIT_BFM.get_pll_locked() == expected_value) begin
			$sformat(message, "Conduit output at expected value - %d - %d", expected_value, `PLL_LOCKED_CONDUIT_BFM.get_pll_locked());
			print(VERBOSITY_INFO, message);
		end else begin
			$sformat(message, "Conduit output at UNEXPECTED value - %d - %d", expected_value, `PLL_LOCKED_CONDUIT_BFM.get_pll_locked());
			print(VERBOSITY_ERROR, message);
			test_success = 1'b0;
		end

		expected_value = expected_value ^ 1'b1;
	end

	expected_value = 1'b1;
	`SHARING_CONDUIT_BFM.set_afi_phy_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_addr_cmd_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_avl_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_avl_phy_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_config_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_mem_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_mem_phy_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_write_clk(expected_value);
	`SHARING_CONDUIT_BFM.set_pll_write_clk_pre_phy_clk(expected_value);
	for(int i = 0 ; i < 16 ; i++) begin
		`SHARING_CONDUIT_BFM.set_pll_locked(expected_value);
		#10;
		if(`PLL_LOCKED_CONDUIT_BFM.get_pll_locked() == expected_value) begin
			$sformat(message, "Conduit output at expected value - %d - %d", expected_value, `PLL_LOCKED_CONDUIT_BFM.get_pll_locked());
			print(VERBOSITY_INFO, message);
		end else begin
			$sformat(message, "Conduit output at UNEXPECTED value - %d - %d", expected_value, `PLL_LOCKED_CONDUIT_BFM.get_pll_locked());
			print(VERBOSITY_ERROR, message);
			test_success = 1'b0;
		end

		expected_value = expected_value ^ 1'b1;
	end

	if(test_success == 1'b1) begin
		$sformat(message, "Test completed successfully...");
		print(VERBOSITY_INFO, message);
	end else begin
		$sformat(message, "Test failed...");
		print(VERBOSITY_ERROR, message);
	end

	$stop;

end // initial

endmodule

