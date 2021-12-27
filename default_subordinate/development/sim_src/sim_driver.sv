/*
 * Copyright (c) 2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */

`timescale 1 ps / 1 ps

`define VERBOSITY VERBOSITY_INFO

`define TEST_SYS_INST	sim_top.tb.test_sys_inst
`define NIOSV_INST	`TEST_SYS_INST.intel_niosv_m_0.intel_niosv_m_0
`define DEFSUB_0_INST	`TEST_SYS_INST.default_subordinate_0.default_subordinate_0
`define RESET_BFM_INST	sim_top.tb.test_sys_inst_reset_bfm.test_sys_inst_reset_bfm

module sim_driver();

import verbosity_pkg::*;
//import avalon_mm_pkg::*;

string message;
reg [31:0] readdata;
reg [31:0] next_looper_span;

initial begin
	#(64'd223_990_001);
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

initial begin

	set_verbosity( `VERBOSITY );

	// ---------------------------------------------------------------------
	// TEST READ THEN WRITE TO DEFSUB_0
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_data_read_from (
		.address_in('h0002_1000),
		.timeout_count(2000)
	);

	for(int i = 0 ; i < 3 ; i++)
		@(posedge `NIOSV_INST.clk);

	verify_defsub_0_any_valid_bits_set();
	verify_defsub_0_arvalid_bits_set();
	verify_defsub_0_wvalid_bits_clr();
	verify_defsub_0_awvalid_bits_clr();

	wait_for_data_write_to (
		.address_in('h0002_1000),
		.timeout_count(2000)
	);

	for(int i = 0 ; i < 3 ; i++)
		@(posedge `NIOSV_INST.clk);

	verify_defsub_0_any_valid_bits_set();
	verify_defsub_0_arvalid_bits_set();
	verify_defsub_0_wvalid_bits_set();
	verify_defsub_0_awvalid_bits_set();

	wait_for_instruction_fetch_from (
		.address_in('h0000_0018),
		.timeout_count(2000)
	);

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// TEST WRITE THEN READ TO DEFSUB_0
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_data_write_to (
		.address_in('h0002_1000),
		.timeout_count(2000)
	);

	for(int i = 0 ; i < 3 ; i++)
		@(posedge `NIOSV_INST.clk);

	verify_defsub_0_any_valid_bits_set();
	verify_defsub_0_arvalid_bits_clr();
	verify_defsub_0_wvalid_bits_set();
	verify_defsub_0_awvalid_bits_set();

	wait_for_data_read_from (
		.address_in('h0002_1000),
		.timeout_count(2000)
	);

	for(int i = 0 ; i < 3 ; i++)
		@(posedge `NIOSV_INST.clk);

	verify_defsub_0_any_valid_bits_set();
	verify_defsub_0_arvalid_bits_set();
	verify_defsub_0_wvalid_bits_set();
	verify_defsub_0_awvalid_bits_set();

	wait_for_instruction_fetch_from (
		.address_in('h0000_0018),
		.timeout_count(2000)
	);

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// TEST JUMP TO DEFSUB_0
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_instruction_fetch_from (
		.address_in('h0002_1004),
		.timeout_count(2000)
	);
	@(posedge `NIOSV_INST.clk);

	for(int i = 0 ; i < 10 ; i++) begin
		wait_for_instruction_fetch_from (
			.address_in('h0002_1000),
			.timeout_count(5)
		);
		@(posedge `NIOSV_INST.clk);
		wait_for_instruction_fetch_from (
			.address_in('h0002_1004),
			.timeout_count(5)
		);
		@(posedge `NIOSV_INST.clk);
	end

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// READ DEFSUB_1 SLVERR
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_data_read_from (
		.address_in('h0002_2000),
		.timeout_count(2000)
	);

	wait_for_instruction_fetch_from (
		.address_in('h0000_0020),
		.timeout_count(6)
	);

	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(200)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0000_0005) begin
		$sformat(message,
			"unexpected cause value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0000_0005);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	@(posedge `NIOSV_INST.clk);
	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(20)
	);

	@(posedge `NIOSV_INST.clk);
	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(20)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0002_2000) begin
		$sformat(message,
			"unexpected tval value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0002_2000);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	wait_for_instruction_fetch_from (
		.address_in('h0000_0018),
		.timeout_count(20)
	);

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// WRITE DEFSUB_1 SLVERR
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_data_write_to (
		.address_in('h0002_2000),
		.timeout_count(2000)
	);

	wait_for_instruction_fetch_from (
		.address_in('h0000_0020),
		.timeout_count(6)
	);

	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(200)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0000_0007) begin
		$sformat(message,
			"unexpected cause value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0000_0007);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	@(posedge `NIOSV_INST.clk);
	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(20)
	);

	@(posedge `NIOSV_INST.clk);
	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(20)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0002_2000) begin
		$sformat(message,
			"unexpected tval value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0002_2000);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	wait_for_instruction_fetch_from (
		.address_in('h0000_0018),
		.timeout_count(20)
	);

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// JUMP DEFSUB_1 SLVERR
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_instruction_fetch_from (
		.address_in('h0002_2000),
		.timeout_count(2000)
	);

	wait_for_instruction_fetch_from (
		.address_in('h0000_0020),
		.timeout_count(12)
	);

	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(200)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0000_0001) begin
		$sformat(message,
			"unexpected cause value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0000_0001);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	@(posedge `NIOSV_INST.clk);
	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(20)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0002_2000) begin
		$sformat(message,
			"unexpected tval value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0002_2000);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	@(posedge `NIOSV_INST.clk);
	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(20)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0002_2000) begin
		$sformat(message,
			"unexpected tval value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0002_2000);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	wait_for_instruction_fetch_from (
		.address_in('h0000_0018),
		.timeout_count(20)
	);

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// READ DEFSUB_2 DECERR
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_data_read_from (
		.address_in('h0002_3000),
		.timeout_count(2000)
	);

	wait_for_instruction_fetch_from (
		.address_in('h0000_0020),
		.timeout_count(6)
	);

	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(200)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0000_0005) begin
		$sformat(message,
			"unexpected cause value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0000_0005);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	@(posedge `NIOSV_INST.clk);
	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(20)
	);

	@(posedge `NIOSV_INST.clk);
	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(20)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0002_3000) begin
		$sformat(message,
			"unexpected tval value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0002_3000);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	wait_for_instruction_fetch_from (
		.address_in('h0000_0018),
		.timeout_count(20)
	);

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// WRITE DEFSUB_2 DECERR
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_data_write_to (
		.address_in('h0002_3000),
		.timeout_count(2000)
	);

	wait_for_instruction_fetch_from (
		.address_in('h0000_0020),
		.timeout_count(6)
	);

	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(200)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0000_0007) begin
		$sformat(message,
			"unexpected cause value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0000_0007);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	@(posedge `NIOSV_INST.clk);
	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(20)
	);

	@(posedge `NIOSV_INST.clk);
	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(20)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0002_3000) begin
		$sformat(message,
			"unexpected tval value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0002_3000);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	wait_for_instruction_fetch_from (
		.address_in('h0000_0018),
		.timeout_count(20)
	);

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// JUMP DEFSUB_2 DECERR
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_instruction_fetch_from (
		.address_in('h0002_3000),
		.timeout_count(2000)
	);

	wait_for_instruction_fetch_from (
		.address_in('h0000_0020),
		.timeout_count(12)
	);

	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(200)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0000_0001) begin
		$sformat(message,
			"unexpected cause value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0000_0001);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	@(posedge `NIOSV_INST.clk);
	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(20)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0002_3000) begin
		$sformat(message,
			"unexpected tval value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0002_3000);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	@(posedge `NIOSV_INST.clk);
	wait_for_data_write_to (
		.address_in('h0000_0014),
		.timeout_count(20)
	);

	if(`NIOSV_INST.data_manager_wdata != 'h0002_3000) begin
		$sformat(message,
			"unexpected tval value: 0x%08X expected 0x%08X",
			`NIOSV_INST.data_manager_wdata,
			'h0002_3000);
		print(VERBOSITY_INFO, message);
		$stop;
	end

	wait_for_instruction_fetch_from (
		.address_in('h0000_0018),
		.timeout_count(20)
	);

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// READ DEFSUB_3 NO RESPONSE
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_data_read_from (
		.address_in('h0002_4000),
		.timeout_count(2000)
	);

	for(int i = 0 ; i < 20 ; i++) begin
		@(posedge `NIOSV_INST.clk);
		if(`NIOSV_INST.instruction_manager_arvalid == 1'b1) begin
			$sformat(message, "instruction fetch detected");
			print(VERBOSITY_INFO, message);
			$stop;
		end
	end

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// WRITE DEFSUB_3 NO RESPONSE
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_data_write_to (
		.address_in('h0002_4000),
		.timeout_count(2000)
	);

	for(int i = 0 ; i < 20 ; i++) begin
		@(posedge `NIOSV_INST.clk);
		if(`NIOSV_INST.instruction_manager_arvalid == 1'b1) begin
			$sformat(message, "instruction fetch detected");
			print(VERBOSITY_INFO, message);
			$stop;
		end
	end

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// JUMP DEFSUB_3 NO RESPONSE
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_instruction_fetch_from (
		.address_in('h0002_4000),
		.timeout_count(2000)
	);

	for(int i = 0 ; i < 20 ; i++) begin
		@(posedge `NIOSV_INST.clk);
		if(`NIOSV_INST.instruction_manager_arvalid == 1'b1) begin
			$sformat(message, "instruction fetch detected");
			print(VERBOSITY_INFO, message);
			$stop;
		end
	end

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// READ DEFSUB_4 NO RESPONSE
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_data_read_from (
		.address_in('h0002_5000),
		.timeout_count(2000)
	);

	for(int i = 0 ; i < 20 ; i++) begin
		@(posedge `NIOSV_INST.clk);
		if(`NIOSV_INST.instruction_manager_arvalid == 1'b1) begin
			$sformat(message, "instruction fetch detected");
			print(VERBOSITY_INFO, message);
			$stop;
		end
	end

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// WRITE DEFSUB_4 NO RESPONSE
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_data_write_to (
		.address_in('h0002_5000),
		.timeout_count(2000)
	);

	for(int i = 0 ; i < 20 ; i++) begin
		@(posedge `NIOSV_INST.clk);
		if(`NIOSV_INST.instruction_manager_arvalid == 1'b1) begin
			$sformat(message, "instruction fetch detected");
			print(VERBOSITY_INFO, message);
			$stop;
		end
	end

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// JUMP DEFSUB_4 NO RESPONSE
	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	wait_for_instruction_fetch_from (
		.address_in('h0002_5000),
		.timeout_count(2000)
	);

	for(int i = 0 ; i < 20 ; i++) begin
		@(posedge `NIOSV_INST.clk);
		if(`NIOSV_INST.instruction_manager_arvalid == 1'b1) begin
			$sformat(message, "instruction fetch detected");
			print(VERBOSITY_INFO, message);
			$stop;
		end
	end

	`RESET_BFM_INST.reset_assert();

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `NIOSV_INST.clk);

	`RESET_BFM_INST.reset_deassert();

	// ---------------------------------------------------------------------
	// wait for reset to de-assert at Nios V interface
	wait(`NIOSV_INST.reset_reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	// ---------------------------------------------------------------------
	// FINISH
	// ---------------------------------------------------------------------
	for(int i = 0 ; i < 10 ; i++)
		@(posedge `NIOSV_INST.clk);

	$sformat(message, "Test completed successfully...");
	print(VERBOSITY_INFO, message);

	$stop;
end // initial

task automatic wait_for_instruction_fetch_from (
	input  [31:0] address_in,
	int           timeout_count
);

string message;

if(`NIOSV_INST.instruction_manager_arvalid == 1'b1) begin
	if(`NIOSV_INST.instruction_manager_araddr == address_in) begin
		$sformat(message,
			"INSTRUCTION FETCHED FROM: addr = 0x%08X",
			address_in);
		print(VERBOSITY_INFO, message);
		return;
	end
end

for(int i = 0 ; i < timeout_count ; i++) begin
	@(posedge `NIOSV_INST.clk);
	if(`NIOSV_INST.instruction_manager_arvalid == 1'b1) begin
		if(`NIOSV_INST.instruction_manager_araddr == address_in) begin
			$sformat(message,
				"INSTRUCTION FETCHED FROM: addr = 0x%08X",
				address_in);
			print(VERBOSITY_INFO, message);
			return;
		end
	end
end

$sformat(message,
	"WAITING FOR INSTRUCTION FETCH FROM: addr = 0x%08X : count = %d",
	address_in, timeout_count);
print(VERBOSITY_ERROR, message);
$stop;

endtask

task automatic wait_for_infinite_loop (
	int           timeout_count
);

string message;

reg [31:0] addr_0;
reg [31:0] addr_1;
reg [31:0] addr_2;
reg [31:0] addr_3;

addr_0 = 0;
addr_1 = 1;
addr_2 = 2;
addr_3 = 3;

for(int i = 0 ; i < timeout_count ; i++) begin
	@(posedge `NIOSV_INST.clk);
	if(`NIOSV_INST.instruction_manager_arvalid == 1'b1) begin
		addr_0 = addr_1;
		addr_1 = addr_2;
		addr_2 = addr_3;
		addr_3 = `NIOSV_INST.instruction_manager_araddr;

		if((addr_0 == addr_2) && (addr_1 == addr_3)) begin
			$sformat(message, "infinite loop detected");
			print(VERBOSITY_INFO, message);
			return;
		end
	end
end

$sformat(message, "WAITING FOR INFINITE LOOP");
print(VERBOSITY_ERROR, message);
$stop;

endtask

task automatic wait_for_data_read_from (
	input  [31:0] address_in,
	int           timeout_count
);

string message;

if(`NIOSV_INST.data_manager_arvalid == 1'b1) begin
	if(`NIOSV_INST.data_manager_araddr == address_in) begin
		$sformat(message,
			"DATA READ FROM: addr = 0x%08X",
			address_in);
		print(VERBOSITY_INFO, message);
		return;
	end
end

for(int i = 0 ; i < timeout_count ; i++) begin
	@(posedge `NIOSV_INST.clk);
	if(`NIOSV_INST.data_manager_arvalid == 1'b1) begin
		if(`NIOSV_INST.data_manager_araddr == address_in) begin
			$sformat(message,
				"DATA READ FROM: addr = 0x%08X",
				address_in);
			print(VERBOSITY_INFO, message);
			return;
		end
	end
end

$sformat(message,
	"WAITING FOR DATA READ FROM: addr = 0x%08X : count = %d",
	address_in, timeout_count);
print(VERBOSITY_ERROR, message);
$stop;

endtask

task automatic wait_for_data_write_to (
	input  [31:0] address_in,
	int           timeout_count
);

string message;

if(`NIOSV_INST.data_manager_awvalid == 1'b1) begin
	if(`NIOSV_INST.data_manager_awaddr == address_in) begin
		$sformat(message,
			"DATA WRITE TO: addr = 0x%08X",
			address_in);
		print(VERBOSITY_INFO, message);
		return;
	end
end

for(int i = 0 ; i < timeout_count ; i++) begin
	@(posedge `NIOSV_INST.clk);
	if(`NIOSV_INST.data_manager_awvalid == 1'b1) begin
		if(`NIOSV_INST.data_manager_awaddr == address_in) begin
			$sformat(message,
				"DATA WRITE TO: addr = 0x%08X",
				address_in);
			print(VERBOSITY_INFO, message);
			return;
		end
	end
end

$sformat(message,
	"WAITING FOR DATA WRITE TO: addr = 0x%08X : count = %d",
	address_in, timeout_count);
print(VERBOSITY_ERROR, message);
$stop;

endtask

task automatic verify_defsub_0_any_valid_bits_set ();

string message;

if((`DEFSUB_0_INST.any_valid_reset) != 1'b1) begin
	$sformat(message, "any_valid_reset not set");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.any_valid_irq) != 1'b1) begin
	$sformat(message, "any_valid_irq not set");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.any_valid_conduit) != 1'b1) begin
	$sformat(message, "any_valid_conduit not set");
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message, "all any_valid_* are set");
print(VERBOSITY_INFO, message);

endtask

task automatic verify_defsub_0_any_valid_bits_clr ();

string message;

if((`DEFSUB_0_INST.any_valid_reset) != 1'b0) begin
	$sformat(message, "any_valid_reset not clr");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.any_valid_irq) != 1'b0) begin
	$sformat(message, "any_valid_irq not clr");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.any_valid_conduit) != 1'b0) begin
	$sformat(message, "any_valid_conduit not clr");
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message, "all any_valid_* are clr");
print(VERBOSITY_INFO, message);

endtask

task automatic verify_defsub_0_arvalid_bits_set ();

string message;

if((`DEFSUB_0_INST.arvalid_reset) != 1'b1) begin
	$sformat(message, "arvalid_reset not set");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.arvalid_irq) != 1'b1) begin
	$sformat(message, "arvalid_irq not set");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.arvalid_conduit) != 1'b1) begin
	$sformat(message, "arvalid_conduit not set");
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message, "all arvalid_* are set");
print(VERBOSITY_INFO, message);

endtask

task automatic verify_defsub_0_arvalid_bits_clr ();

string message;

if((`DEFSUB_0_INST.arvalid_reset) != 1'b0) begin
	$sformat(message, "arvalid_reset not clr");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.arvalid_irq) != 1'b0) begin
	$sformat(message, "arvalid_irq not clr");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.arvalid_conduit) != 1'b0) begin
	$sformat(message, "arvalid_conduit not clr");
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message, "all arvalid_* are clr");
print(VERBOSITY_INFO, message);

endtask

task automatic verify_defsub_0_wvalid_bits_set ();

string message;

if((`DEFSUB_0_INST.wvalid_reset) != 1'b1) begin
	$sformat(message, "wvalid_reset not set");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.wvalid_irq) != 1'b1) begin
	$sformat(message, "wvalid_irq not set");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.wvalid_conduit) != 1'b1) begin
	$sformat(message, "wvalid_conduit not set");
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message, "all wvalid_* are set");
print(VERBOSITY_INFO, message);

endtask

task automatic verify_defsub_0_wvalid_bits_clr ();

string message;

if((`DEFSUB_0_INST.wvalid_reset) != 1'b0) begin
	$sformat(message, "wvalid_reset not clr");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.wvalid_irq) != 1'b0) begin
	$sformat(message, "wvalid_irq not clr");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.wvalid_conduit) != 1'b0) begin
	$sformat(message, "wvalid_conduit not clr");
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message, "all wvalid_* are clr");
print(VERBOSITY_INFO, message);

endtask

task automatic verify_defsub_0_awvalid_bits_set ();

string message;

if((`DEFSUB_0_INST.awvalid_reset) != 1'b1) begin
	$sformat(message, "awvalid_reset not set");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.awvalid_irq) != 1'b1) begin
	$sformat(message, "awvalid_irq not set");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.awvalid_conduit) != 1'b1) begin
	$sformat(message, "awvalid_conduit not set");
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message, "all awvalid_* are set");
print(VERBOSITY_INFO, message);

endtask

task automatic verify_defsub_0_awvalid_bits_clr ();

string message;

if((`DEFSUB_0_INST.awvalid_reset) != 1'b0) begin
	$sformat(message, "awvalid_reset not clr");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.awvalid_irq) != 1'b0) begin
	$sformat(message, "awvalid_irq not clr");
	print(VERBOSITY_ERROR, message);
	$stop;
end

if((`DEFSUB_0_INST.awvalid_conduit) != 1'b0) begin
	$sformat(message, "awvalid_conduit not clr");
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message, "all awvalid_* are clr");
print(VERBOSITY_INFO, message);

endtask

endmodule

