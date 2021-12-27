/*
 * Copyright (c) 2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */

`timescale 1 ps / 1 ps

`define VERBOSITY VERBOSITY_INFO

`define TEST_SYS_INST	sim_top.tb.test_sys_inst
`define NIOSV_INST	`TEST_SYS_INST.niosv_m.niosv_m
`define BFM_INST	`TEST_SYS_INST.master_bfm.master_bfm
`define LOOPER_0_INST	`TEST_SYS_INST.looper_0.looper_0
`define LOOPER_D_INST	`TEST_SYS_INST.looper_default.looper_0

`define L0_BASE          ('h0000_0000)
`define LD_BASE          ('h0000_1000)

`define STAT_REG_OFST    ('h0000_0000)
`define CNTL_REG_OFST    ('h0000_0004)
`define ADDR_REG_OFST    ('h0000_0008)

`define STAT_ADDR_MASK   ('h0000_0FFF)
`define STAT_JUMP_ENABLE ('h0000_1000)
`define STAT_JUMP_ABORT  ('h0000_2000)
`define STAT_LUI_EXEC    ('h0000_4000)
`define STAT_JALR_EXEC   ('h0000_8000)
`define STAT_ADDR_VALID  ('h0001_0000)

module sim_driver();

import verbosity_pkg::*;
import avalon_mm_pkg::*;

string message;
reg [31:0] readdata;
reg [31:0] next_looper_span;

initial begin
	#(64'd1_034_230_0001);
        $sformat(message, "SIMULATION TIMEOUT ERROR");
        print(VERBOSITY_FAILURE, message);
        abort_simulation();
end

initial begin

	set_verbosity( `VERBOSITY );

	//wait for reset to de-assert at BFM interface
	wait(`BFM_INST.reset == 1'b0);
	$sformat(message, "Reset released...");
	print(VERBOSITY_INFO, message);

	// ---------------------------------------------------------------------
	// VERIFY INSTRUCTION WORD STATE MACHINE SEQUENCING - NORMAL JUMP
	// ---------------------------------------------------------------------

	// wait for CPU to fetch first instruction
	for(int i = 0 ; i < 33 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// at this point the instruction word state machine should still be in
	// it's reset state, about to react to the first fetch, verify the
	// status register is still all cleared
	verify_L0_status_bits_clr (
		.data_mask_in('hffff_ffff)
	);

	// verify the status register updates in 3 clocks
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);

	verify_L0_status_bits_set (
		.data_mask_in(	`STAT_ADDR_VALID)
	);

	verify_L0_status_bits_clr (
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_JUMP_ABORT  |
				`STAT_LUI_EXEC    |
				`STAT_JALR_EXEC)
	);

	// set jump address to end of span - 4, the last instruction address
	bfm_write(
		.address_in(`L0_BASE + `ADDR_REG_OFST),
		.data_in('h0000_0FFC)
	);

	// wait for CPU to fetch from 'h0000
	for(int i = 0 ; i < 2 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// enable the jump
	bfm_write(
		.address_in(`L0_BASE + `CNTL_REG_OFST),
		.data_in(`STAT_JUMP_ENABLE)
	);

	// verify the status register updates in 2 clocks
	for(int i = 0 ; i < 2 ; i++)
		@(posedge `BFM_INST.clk);

	verify_L0_status_bits_set (
		.data_mask_in(	`STAT_JUMP_ENABLE)
	);

	verify_L0_status_bits_clr (
		.data_mask_in(	`STAT_JUMP_ABORT  |
				`STAT_LUI_EXEC    |
				`STAT_JALR_EXEC   |
				`STAT_ADDR_VALID)
	);

	// watch for the expected execution sequence of the Nios V

	// wait for CPU to fetch from 'h0000
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h0004
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0004),
		.timeout_count(0)
	);

	// verify the status register updates from fetch from 'h0000 now
	verify_L0_status_bits_set (
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_LUI_EXEC    |
				`STAT_ADDR_VALID)
	);

	verify_L0_status_bits_clr (
		.data_mask_in(	`STAT_JUMP_ABORT  |
				`STAT_JALR_EXEC)
	);

	// wait for CPU to fetch from 'h0008
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0008),
		.timeout_count(0)
	);

	// verify the status register updates from fetch from 'h0004 now
	verify_L0_status_bits_set (
		.data_mask_in(	`STAT_LUI_EXEC    |
				`STAT_JALR_EXEC   |
				`STAT_ADDR_VALID)
	);

	verify_L0_status_bits_clr (
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_JUMP_ABORT)
	);

	// wait for CPU to fetch from 'h0FFC
	for(int i = 0 ; i < 4 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0FFC),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h1000
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_1000),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h0000
	for(int i = 0 ; i < 4 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// verify the status register hasn't changed since last check
	verify_L0_status_bits_set (
		.data_mask_in(	`STAT_LUI_EXEC    |
				`STAT_JALR_EXEC   |
				`STAT_ADDR_VALID)
	);

	verify_L0_status_bits_clr (
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_JUMP_ABORT)
	);

	// verify that we can clear the sticky status register bits

	bfm_write(
		.address_in(`L0_BASE + `CNTL_REG_OFST),
		.data_in('h0000_0000)
	);

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `BFM_INST.clk);
	// verify all bits are cleared
	verify_L0_status_bits_clr (
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_JUMP_ABORT  |
				`STAT_LUI_EXEC    |
				`STAT_JALR_EXEC   |
				`STAT_ADDR_VALID)
	);

	// ---------------------------------------------------------------------
	// VERIFY INSTRUCTION WORD STATE MACHINE SEQUENCING - ABORTED JUMP
	// ---------------------------------------------------------------------

	// --------------------
	// first test a good initial access and a bad second access after
	// enabling the jump
	// --------------------

	// clear the LD status register
	bfm_write(
		.address_in(`LD_BASE + `CNTL_REG_OFST),
		.data_in('h0000_0000)
	);

	//  for CPU to fetch from 'h0000
	for(int i = 0 ; i < 1 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// at this point the LD instruction word state machine should still be
	// in it's reset state, verify the status register is still all cleared
	for(int i = 0 ; i < 1 ; i++)
		@(posedge `BFM_INST.clk);
	verify_LD_status_bits_clr (
		.data_mask_in('hffff_ffff)
	);

	// set LD jump address to end of span - 4, the last instruction address
	bfm_write(
		.address_in(`LD_BASE + `ADDR_REG_OFST),
		.data_in(`LD_BASE + 'h0000_0FFC)
	);

	// enable the LD jump
	bfm_write(
		.address_in(`LD_BASE + `CNTL_REG_OFST),
		.data_in(`STAT_JUMP_ENABLE)
	);

	// set jump address to end of span - 4, the last instruction address
	bfm_write(
		.address_in(`L0_BASE + `ADDR_REG_OFST),
		.data_in('h0000_0FFC)
	);

	// wait for CPU to fetch from 'h0000
	for(int i = 0 ; i < 5 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// enable the jump
	bfm_write(
		.address_in(`L0_BASE + `CNTL_REG_OFST),
		.data_in(`STAT_JUMP_ENABLE)
	);

	// watch for the expected execution sequence of the Nios V

	// wait for CPU to fetch from 'h0000
	for(int i = 0 ; i < 6 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h0004
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0004),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h0008
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0008),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h0FFC
	for(int i = 0 ; i < 4 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0FFC),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h1000
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_1000),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h0000
	for(int i = 0 ; i < 4 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// verify the LD status register
	verify_LD_status_bits_set (
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_LUI_EXEC    |
				`STAT_ADDR_VALID)
	);

	verify_LD_status_bits_clr (
		.data_mask_in(	`STAT_JALR_EXEC   |
				`STAT_JUMP_ABORT)
	);

	// wait for CPU to fetch from 'h0000
	for(int i = 0 ; i < 0 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// enable the jump
	bfm_write(
		.address_in(`L0_BASE + `CNTL_REG_OFST),
		.data_in(`STAT_JUMP_ENABLE)
	);

	// watch for the expected execution sequence of the Nios V

	// wait for CPU to fetch from 'h0000
	for(int i = 0 ; i < 6 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h0004
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0004),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h0008
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0008),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h0FFC
	for(int i = 0 ; i < 4 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0FFC),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h1000
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_1000),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h0000
	for(int i = 0 ; i < 4 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// verify the LD status register
	verify_LD_status_bits_set (
		.data_mask_in(	`STAT_JUMP_ABORT  |
				`STAT_LUI_EXEC    |
				`STAT_ADDR_VALID)
	);

	verify_LD_status_bits_clr (
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_JALR_EXEC)
	);

	// verify that we can clear the sticky status register bits in LD

	bfm_write(
		.address_in(`LD_BASE + `CNTL_REG_OFST),
		.data_in('h0000_0000)
	);

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `BFM_INST.clk);
	// verify all bits are cleared
	verify_LD_status_bits_clr (
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_JUMP_ABORT  |
				`STAT_LUI_EXEC    |
				`STAT_JALR_EXEC   |
				`STAT_ADDR_VALID)
	);

	// --------------------
	// now test a bad initial access after enabling the jump
	// --------------------

	// enable the LD jump
	bfm_write(
		.address_in(`LD_BASE + `CNTL_REG_OFST),
		.data_in(`STAT_JUMP_ENABLE)
	);

	// set jump address to LD_BASE + 4, the last instruction address
	bfm_write(
		.address_in(`L0_BASE + `ADDR_REG_OFST),
		.data_in(`LD_BASE + 'h0000_0004)
	);

	// wait for CPU to fetch from 'h0000
	for(int i = 0 ; i < 6 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// enable the jump
	bfm_write(
		.address_in(`L0_BASE + `CNTL_REG_OFST),
		.data_in(`STAT_JUMP_ENABLE)
	);

	// watch for the expected execution sequence of the Nios V

	// wait for CPU to fetch from 'h0000
	for(int i = 0 ; i < 5 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h0004
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0004),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h0008
	for(int i = 0 ; i < 3 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_0008),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h1004
	for(int i = 0 ; i < 4 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_1004),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h1008
	for(int i = 0 ; i < 4 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_1008),
		.timeout_count(0)
	);

	// wait for CPU to fetch from 'h1000
	for(int i = 0 ; i < 4 ; i++)
		@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in('h0000_1000),
		.timeout_count(0)
	);

	// verify the LD status register
	verify_LD_status_bits_set (
		.data_mask_in(	`STAT_JUMP_ABORT  |
				`STAT_ADDR_VALID)
	);

	verify_LD_status_bits_clr (
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_LUI_EXEC    |
				`STAT_JALR_EXEC)
	);

	// verify that we can clear the sticky status register bits in LD

	bfm_write(
		.address_in(`LD_BASE + `CNTL_REG_OFST),
		.data_in('h0000_0000)
	);

	for(int i = 0 ; i < 2 ; i++)
		@(posedge `BFM_INST.clk);
	// verify all bits are cleared
	verify_LD_status_bits_clr (
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_JUMP_ABORT  |
				`STAT_LUI_EXEC    |
				`STAT_JALR_EXEC   |
				`STAT_ADDR_VALID)
	);

	// --------------------
	// return the Nios V to the L0 span
	// --------------------

	// write the LD jump register to 'h0000_0000
	bfm_write(
		.address_in(`LD_BASE + `ADDR_REG_OFST),
		.data_in('h0000_0000)
	);

	// enable the LD jump
	bfm_write(
		.address_in(`LD_BASE + `CNTL_REG_OFST),
		.data_in(`STAT_JUMP_ENABLE)
	);

	// follow the expected sequence
	wait_for_instruction_fetch_from (
		.address_in('h0000_1000),
		.timeout_count(5)
	);

	wait_for_instruction_fetch_from (
		.address_in('h0000_1004),
		.timeout_count(5)
	);

	wait_for_instruction_fetch_from (
		.address_in('h0000_1008),
		.timeout_count(5)
	);

	wait_for_instruction_fetch_from (
		.address_in('h0000_0000),
		.timeout_count(5)
	);

	// check the status bits are as expected
	wait_for_all_bits_set (
		.address_in(`LD_BASE + `STAT_REG_OFST),
		.data_mask_in(	`STAT_LUI_EXEC    |
				`STAT_JALR_EXEC   |
				`STAT_ADDR_VALID),
		.timeout_count(1)
	);

	wait_for_all_bits_clr (
		.address_in(`LD_BASE + `STAT_REG_OFST),
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_JUMP_ABORT),
		.timeout_count(1)
	);

	// ---------------------------------------------------------------------
	// RUN LOOPER SPAN TESTS
	// ---------------------------------------------------------------------

	next_looper_span = 'h0000_0000;
	test_full_looper_span (
		.looper_base_addr_in(next_looper_span),
		.addr_incr_in('h0000_0004)
	);
	for(	next_looper_span = 'h0000_1000 ;
		next_looper_span != 'h0000_0000 ;
		next_looper_span = next_looper_span << 1) begin

		test_full_looper_span (
			.looper_base_addr_in(next_looper_span),
		.addr_incr_in('h0000_0400)
		);
	end

	// ---------------------------------------------------------------------
	// FINISH
	// ---------------------------------------------------------------------
	for(int i = 0 ; i < 10 ; i++)
		@(posedge `BFM_INST.clk);

	$sformat(message, "Test completed successfully...");
	print(VERBOSITY_INFO, message);

	$stop;
end // initial

task automatic bfm_write (
	input  [31:0] address_in,
	input  [31:0] data_in
);

string message;

`BFM_INST.set_command_address(address_in);
`BFM_INST.set_command_byte_enable('hF, 0);
`BFM_INST.set_command_burst_count('h1);
`BFM_INST.set_command_burst_size('h1);
`BFM_INST.set_command_data(data_in, 0);
`BFM_INST.set_command_idle(0, 0);
`BFM_INST.set_command_init_latency(0);
`BFM_INST.set_command_request(REQ_WRITE);
`BFM_INST.push_command();

while(`BFM_INST.get_response_queue_size() == 0)
	@(posedge `BFM_INST.clk);

`BFM_INST.pop_response();

if(`BFM_INST.get_response_request() == REQ_WRITE) begin
	$sformat(message, "WRITE RESPONSE: addr = 0x%08X : data = 0x%08X",
							address_in, data_in);
	print(VERBOSITY_INFO, message);
end else begin
	$sformat(message, "EXPECTED WRITE RESPONSE");
	print(VERBOSITY_ERROR, message);
	$stop;
end

endtask

task automatic bfm_read (
	input  [31:0] address_in,
	output [31:0] data_out
);

string message;

`BFM_INST.set_command_address(address_in);
`BFM_INST.set_command_byte_enable('hF, 0);
`BFM_INST.set_command_burst_count('h1);
`BFM_INST.set_command_burst_size('h1);
`BFM_INST.set_command_data('hA5A5A5A5, 0);
`BFM_INST.set_command_idle(0, 0);
`BFM_INST.set_command_init_latency(0);
`BFM_INST.set_command_request(REQ_READ);
`BFM_INST.push_command();

while(`BFM_INST.get_response_queue_size() == 0)
	@(posedge `BFM_INST.clk);

`BFM_INST.pop_response();

if(`BFM_INST.get_response_request() == REQ_READ) begin
	$sformat(message, "READ RESPONSE: addr = 0x%08X : data = 0x%08X",
							address_in, `BFM_INST.get_response_data(0));
	print(VERBOSITY_INFO, message);
end else begin
	$sformat(message, "EXPECTED READ RESPONSE");
	print(VERBOSITY_ERROR, message);
	$stop;
end

data_out = `BFM_INST.get_response_data(0);

endtask

task automatic wait_for_all_bits_clr (
	input  [31:0] address_in,
	input  [31:0] data_mask_in,
	int           timeout_count
);

string message;
reg [31:0] readdata;

for(int i = 0 ; i < timeout_count ; i++) begin
	bfm_read(.address_in(address_in), .data_out(readdata));
	readdata = readdata & data_mask_in;
	if(readdata == 0)
		return;
end

$sformat(message,
	"WAITING FOR ALL BITS CLR: addr = 0x%08X : mask = 0x%08X : count = %d",
	address_in, data_mask_in, timeout_count);
print(VERBOSITY_ERROR, message);
$stop;

endtask

task automatic wait_for_all_bits_set (
	input  [31:0] address_in,
	input  [31:0] data_mask_in,
	int           timeout_count
);

string message;
reg [31:0] readdata;

for(int i = 0 ; i < timeout_count ; i++) begin
	bfm_read(.address_in(address_in), .data_out(readdata));
	readdata = readdata & data_mask_in;
	if(readdata == data_mask_in)
		return;
end

$sformat(message,
	"WAITING FOR ALL BITS SET: addr = 0x%08X : mask = 0x%08X : count = %d",
	address_in, data_mask_in, timeout_count);
print(VERBOSITY_ERROR, message);
$stop;

endtask

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
	@(posedge `BFM_INST.clk);
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

task automatic verify_L0_status_bits_set (
	input  [31:0] data_mask_in
);

string message;

if((`LOOPER_0_INST.status_rd & data_mask_in) != data_mask_in) begin
	$sformat(message,
		"L0 status bits not set: current = 0x%08X : mask = 0x%08X",
		`LOOPER_0_INST.status_rd & data_mask_in, data_mask_in);
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message,
	"L0 status bits set: current = 0x%08X : mask = 0x%08X",
	`LOOPER_0_INST.status_rd & data_mask_in, data_mask_in);
print(VERBOSITY_INFO, message);

endtask

task automatic verify_L0_status_bits_clr (
	input  [31:0] data_mask_in
);

string message;

if((`LOOPER_0_INST.status_rd & data_mask_in) != 'h0000_0000) begin
	$sformat(message,
		"L0 status bits not clr: current = 0x%08X : mask = 0x%08X",
		`LOOPER_0_INST.status_rd & data_mask_in, data_mask_in);
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message,
	"L0 status bits clr: current = 0x%08X : mask = 0x%08X",
	`LOOPER_0_INST.status_rd & data_mask_in, data_mask_in);
print(VERBOSITY_INFO, message);

endtask

task automatic verify_LD_status_bits_set (
	input  [31:0] data_mask_in
);

string message;

if((`LOOPER_D_INST.status_rd & data_mask_in) != data_mask_in) begin
	$sformat(message,
		"LD status bits not set: current = 0x%08X : mask = 0x%08X",
		`LOOPER_D_INST.status_rd & data_mask_in, data_mask_in);
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message,
	"LD status bits set: current = 0x%08X : mask = 0x%08X",
	`LOOPER_D_INST.status_rd & data_mask_in, data_mask_in);
print(VERBOSITY_INFO, message);

endtask

task automatic verify_LD_status_bits_clr (
	input  [31:0] data_mask_in
);

string message;

if((`LOOPER_D_INST.status_rd & data_mask_in) != 'h0000_0000) begin
	$sformat(message,
		"LD status bits not clr: current = 0x%08X : mask = 0x%08X",
		`LOOPER_D_INST.status_rd & data_mask_in, data_mask_in);
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message,
	"LD status bits clr: current = 0x%08X : mask = 0x%08X",
	`LOOPER_D_INST.status_rd & data_mask_in, data_mask_in);
print(VERBOSITY_INFO, message);

endtask

task automatic test_full_looper_span (
	input  [31:0] looper_base_addr_in,
	input  [31:0] addr_incr_in
);

string message;

// test the looper_base_addr_in input argument for 4KB alignment
if(|looper_base_addr_in[11:0]) begin
	$sformat(message, "input address must be 4KB aligned: addr = 0x%08X",
							looper_base_addr_in);
	print(VERBOSITY_ERROR, message);
	$stop;
end

// test the addr_incr_in input argument for multiple of 4 and non-zero
if((|addr_incr_in[1:0]) || (addr_incr_in == 0)) begin
	$sformat(message, "input increment must be a multiple of 4 and non-zero: incr = 0x%08X",
							addr_incr_in);
	print(VERBOSITY_ERROR, message);
	$stop;
end

$sformat(message, "--------------------------------------------------------------------------------");
print(VERBOSITY_INFO, message);

$sformat(message, "testing looper span at 0x%08X with increment 0x%08X",
					looper_base_addr_in, addr_incr_in);
print(VERBOSITY_INFO, message);

$sformat(message, "--------------------------------------------------------------------------------");
print(VERBOSITY_INFO, message);

// ensure the L0 and LD loopers are jump disabled
bfm_write(
	.address_in(`L0_BASE + `CNTL_REG_OFST),
	.data_in('h0000_0000)
);

bfm_write(
	.address_in(`LD_BASE + `CNTL_REG_OFST),
	.data_in('h0000_0000)
);

// verify the status register of L0 indicates Nios V is accessing it
wait_for_all_bits_set (
	.address_in(`L0_BASE + `STAT_REG_OFST),
	.data_mask_in(	`STAT_ADDR_VALID),
	.timeout_count(1)
);

wait_for_all_bits_clr (
	.address_in(`L0_BASE + `STAT_REG_OFST),
	.data_mask_in(	`STAT_JUMP_ENABLE |
			`STAT_JUMP_ABORT  |
			`STAT_LUI_EXEC    |
			`STAT_JALR_EXEC),
	.timeout_count(1)
);

// verify the status register of LD indicates no activity
wait_for_all_bits_clr (
	.address_in(`LD_BASE + `STAT_REG_OFST),
	.data_mask_in(	`STAT_JUMP_ENABLE |
			`STAT_JUMP_ABORT  |
			`STAT_LUI_EXEC    |
			`STAT_JALR_EXEC   |
			`STAT_ADDR_VALID),
	.timeout_count(1)
);

// set the L0 jump address to looper_base_addr_in
bfm_write(
	.address_in(`L0_BASE + `ADDR_REG_OFST),
	.data_in(looper_base_addr_in)
);

// enable L0 jump
bfm_write(
	.address_in(`L0_BASE + `CNTL_REG_OFST),
	.data_in(`STAT_JUMP_ENABLE)
);


// follow the expected sequence

// expecting fetch from 'h0000_0000
wait_for_instruction_fetch_from (
	.address_in('h0000_0000),
	.timeout_count(5)
);

// expecting fetch from 'h0000_0004
@(posedge `BFM_INST.clk);
wait_for_instruction_fetch_from (
	.address_in('h0000_0004),
	.timeout_count(5)
);

// expecting fetch from 'h0000_0008
@(posedge `BFM_INST.clk);
wait_for_instruction_fetch_from (
	.address_in('h0000_0008),
	.timeout_count(5)
);

// expecting fetch from looper_base_addr_in + 0
@(posedge `BFM_INST.clk);
wait_for_instruction_fetch_from (
	.address_in(looper_base_addr_in + 0),
	.timeout_count(5)
);

// verify the status register of L0 indicates Nios V took the jump
wait_for_all_bits_set (
	.address_in(`L0_BASE + `STAT_REG_OFST),
	.data_mask_in(	`STAT_LUI_EXEC    |
			`STAT_JALR_EXEC   |
			`STAT_ADDR_VALID),
	.timeout_count(1)
);

wait_for_all_bits_clr (
	.address_in(`L0_BASE + `STAT_REG_OFST),
	.data_mask_in(	`STAT_JUMP_ENABLE |
			`STAT_JUMP_ABORT),
	.timeout_count(1)
);

for(int i = 0 ; i < 'h1000 ; i = i + addr_incr_in) begin

	// make sure this looper is jump disabled
	bfm_write(
		.address_in(looper_base_addr_in + `CNTL_REG_OFST),
		.data_in('h0000_0000)
	);

	// verify the status register indicates Nios V is accessing it
	wait_for_all_bits_set (
		.address_in(looper_base_addr_in + `STAT_REG_OFST),
		.data_mask_in(	`STAT_ADDR_VALID),
		.timeout_count(1)
	);

	wait_for_all_bits_clr (
		.address_in(looper_base_addr_in + `STAT_REG_OFST),
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_JUMP_ABORT  |
				`STAT_LUI_EXEC    |
				`STAT_JALR_EXEC),
		.timeout_count(1)
	);

	// set the jump address to looper_base_addr_in + i
	bfm_write(
		.address_in(looper_base_addr_in + `ADDR_REG_OFST),
		.data_in(looper_base_addr_in + i)
	);

	// enable jump
	bfm_write(
		.address_in(looper_base_addr_in + `CNTL_REG_OFST),
		.data_in(`STAT_JUMP_ENABLE)
	);


	// follow the expected sequence

	// expecting fetch from looper_base_addr_in
	wait_for_instruction_fetch_from (
		.address_in(looper_base_addr_in),
		.timeout_count(5)
	);

	// expecting fetch from looper_base_addr_in + 4
	@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in(looper_base_addr_in + 4),
		.timeout_count(5)
	);

	// expecting fetch from looper_base_addr_in + 8
	@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in(looper_base_addr_in + 8),
		.timeout_count(5)
	);

	// expecting fetch from looper_base_addr_in + i
	@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in(looper_base_addr_in + i),
		.timeout_count(5)
	);

	// expecting fetch from looper_base_addr_in + i + 4
	@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in(looper_base_addr_in + i + 4),
		.timeout_count(5)
	);

	// expecting fetch from looper_base_addr_in
	@(posedge `BFM_INST.clk);
	wait_for_instruction_fetch_from (
		.address_in(looper_base_addr_in),
		.timeout_count(5)
	);

	// verify the status register indicates Nios V took the jump
	wait_for_all_bits_set (
		.address_in(looper_base_addr_in + `STAT_REG_OFST),
		.data_mask_in(	`STAT_LUI_EXEC    |
				`STAT_JALR_EXEC   |
				`STAT_ADDR_VALID),
		.timeout_count(1)
	);

	wait_for_all_bits_clr (
		.address_in(looper_base_addr_in + `STAT_REG_OFST),
		.data_mask_in(	`STAT_JUMP_ENABLE |
				`STAT_JUMP_ABORT),
		.timeout_count(1)
	);
end

// make sure this looper is jump disabled
bfm_write(
	.address_in(looper_base_addr_in + `CNTL_REG_OFST),
	.data_in('h0000_0000)
);

// verify the status register indicates Nios V is accessing it
wait_for_all_bits_set (
	.address_in(looper_base_addr_in + `STAT_REG_OFST),
	.data_mask_in(	`STAT_ADDR_VALID),
	.timeout_count(1)
);

wait_for_all_bits_clr (
	.address_in(looper_base_addr_in + `STAT_REG_OFST),
	.data_mask_in(	`STAT_JUMP_ENABLE |
			`STAT_JUMP_ABORT  |
			`STAT_LUI_EXEC    |
			`STAT_JALR_EXEC),
	.timeout_count(1)
);

// set the jump address to L0
bfm_write(
	.address_in(looper_base_addr_in + `ADDR_REG_OFST),
	.data_in(`L0_BASE)
);

// enable jump
bfm_write(
	.address_in(looper_base_addr_in + `CNTL_REG_OFST),
	.data_in(`STAT_JUMP_ENABLE)
);


// follow the expected sequence

// expecting fetch from looper_base_addr_in
wait_for_instruction_fetch_from (
	.address_in(looper_base_addr_in),
	.timeout_count(5)
);

// expecting fetch from looper_base_addr_in + 4
@(posedge `BFM_INST.clk);
wait_for_instruction_fetch_from (
	.address_in(looper_base_addr_in + 4),
	.timeout_count(5)
);

// expecting fetch from looper_base_addr_in + 8
@(posedge `BFM_INST.clk);
wait_for_instruction_fetch_from (
	.address_in(looper_base_addr_in + 8),
	.timeout_count(5)
);

// expecting fetch from 'h0000_0000
@(posedge `BFM_INST.clk);
wait_for_instruction_fetch_from (
	.address_in('h0000_0000),
	.timeout_count(5)
);

// expecting fetch from 'h0000_0004
@(posedge `BFM_INST.clk);
wait_for_instruction_fetch_from (
	.address_in('h0000_0004),
	.timeout_count(5)
);

// expecting fetch from 'h0000_0000
@(posedge `BFM_INST.clk);
wait_for_instruction_fetch_from (
	.address_in('h0000_0000),
	.timeout_count(5)
);

// verify the status register indicates Nios V took the jump
wait_for_all_bits_set (
	.address_in(looper_base_addr_in + `STAT_REG_OFST),
	.data_mask_in(	`STAT_LUI_EXEC    |
			`STAT_JALR_EXEC   |
			`STAT_ADDR_VALID),
	.timeout_count(1)
);

wait_for_all_bits_clr (
	.address_in(looper_base_addr_in + `STAT_REG_OFST),
	.data_mask_in(	`STAT_JUMP_ENABLE |
			`STAT_JUMP_ABORT),
	.timeout_count(1)
);
endtask

endmodule

