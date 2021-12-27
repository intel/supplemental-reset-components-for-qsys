/*
 * Copyright (c) 2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */

/*
 * -----------------------------------------------------------------------------
 * Overview
 *
 * This component provides two AXI4-lite subordinate interfaces, one CSR that is
 * intended for control and status monitoring and a second LOOPER that is
 * intended to be connected to the instruction master of the Nios V CPU.  When
 * this component exits reset any accesses to the LOOPER subordinate will
 * provide a valid Nios V instruction that jumps to the address 12'h000 in the
 * LOOPER subordinates address span.  It's intended to provide the Nios V with a
 * safe subordinate to mark as it's reset vector address so that the Nios V can
 * safely exit reset and enter a benign infinite loop.  The user can then
 * connect with an external debugger to take control of the Nios V or something
 * like that.  Optionally any manager in the system, like a JTAG Master, that is
 * connected to the CSR subordinate may write a jump address into this core and
 * enable a jump to that address.  When the jump address is enabled, this core
 * will feed an lui and jalr instruction to the Nios V that cause it to jump to
 * the jump address programmed into this core.  Once a jump is executed the core
 * disables the jump facility, so if the Nios V ever executes from the LOOPER
 * subordinate again, it will be captured in another infinite loop until a
 * manager in the system enables it to jump again.
 *
 * This core performs some mild error checking to ensure that the sequence of
 * events appears right.  If the proper read sequence is not observed after the
 * jump address is enabled, then the core will disable the jump and report a
 * jump abort fault in the status register.
 *
 * -----------------------------------------------------------------------------
 * Register Map
 *
 * This core has a trivial CSR layout with three registers:
 *
 * csr_sub_axaddr = 12'h000 - status register
 * csr_sub_axaddr = 12'h004 - control register
 * csr_sub_axaddr = 12'h008 - jump address register
 *
 * -----------------------------------------------------------------------------
 * status register bit map:
 * [31:17][16][15][14][13][12][11:0]
 *    |     |   |   |   |   |    |
 *    |     |   |   |   |   |    +--- RO last_addr_field
 *    |     |   |   |   |   +-------- RO jump_enable
 *    |     |   |   |   +------------ RO jump_abort
 *    |     |   |   +---------------- RO lui_exec
 *    |     |   +-------------------- RO jalr_exec
 *    |     +------------------------ RO addr_field_valid
 *    +------------------------------ RO unused
 *
 * last_addr_field   - indicates last address accessed on LOOPER subordinate
 * jump_enable       - indicates jump is enabled
 * jump_abort        - indicates error was detected while jump was enabled
 * lui_exec          - indicates lui instruction for the jump executed
 * jalr_exec         - indicates jalr instruction for the jump executed
 * addr_field_valid  - indicates the last_addr_field is valid
 * unused            - returns all zeros
 *
 * -----------------------------------------------------------------------------
 * control register bit map:
 * [31:13][12][11:0]
 *    |     |    |
 *    |     |    +--- RO unused
 *    |     +-------- RW jump_enable
 *    +-------------- RO unused
 *
 * jump_enable - 1 = enable jump address, 0 = disable jump address
 * unused      - returns all zeros, writes have no impact
 *
 * -----------------------------------------------------------------------------
 * jump address register bit map:
 * [31:0]
 *    |
 *    +--- RW jump_addr 32-bit jump address to feed Nios V
 *
 * -----------------------------------------------------------------------------
 */

`timescale 1 ps / 1 ps
module niosv_reset_looper (

	// clock and reset
	input  wire        clk,
	input  wire        reset,

	// CSR AXI4-lite subordinate
	input  wire [11:0] csr_sub_araddr,
	input  wire [2:0]  csr_sub_arprot,
	output wire        csr_sub_arready,
	input  wire        csr_sub_arvalid,
	input  wire [11:0] csr_sub_awaddr,
	input  wire [2:0]  csr_sub_awprot,
	output wire        csr_sub_awready,
	input  wire        csr_sub_awvalid,
	input  wire        csr_sub_bready,
	output wire [1:0]  csr_sub_bresp,
	output wire        csr_sub_bvalid,
	output wire [31:0] csr_sub_rdata,
	input  wire        csr_sub_rready,
	output wire [1:0]  csr_sub_rresp,
	output wire        csr_sub_rvalid,
	input  wire [31:0] csr_sub_wdata,
	output wire        csr_sub_wready,
	input  wire [3:0]  csr_sub_wstrb,
	input  wire        csr_sub_wvalid,

	// LOOPER AXI4-lite subordinate
	input  wire [11:0] looper_sub_araddr,
	input  wire [2:0]  looper_sub_arprot,
	output wire        looper_sub_arready,
	input  wire        looper_sub_arvalid,
	input  wire [11:0] looper_sub_awaddr,
	input  wire [2:0]  looper_sub_awprot,
	output wire        looper_sub_awready,
	input  wire        looper_sub_awvalid,
	input  wire        looper_sub_bready,
	output wire [1:0]  looper_sub_bresp,
	output wire        looper_sub_bvalid,
	output wire [31:0] looper_sub_rdata,
	input  wire        looper_sub_rready,
	output wire [1:0]  looper_sub_rresp,
	output wire        looper_sub_rvalid,
	input  wire [31:0] looper_sub_wdata,
	output wire        looper_sub_wready,
	input  wire [3:0]  looper_sub_wstrb,
	input  wire        looper_sub_wvalid
);

reg         looper_awvalid_reg;
reg         looper_wvalid_reg;
reg  [31:0] csr_wdata_reg;
reg  [ 3:0] csr_wstrb_reg;
reg         looper_bvalid_reg;
reg  [11:0] looper_araddr_reg;
reg         looper_arvalid_reg;
reg         looper_rvalid_reg;
reg  [31:0] looper_rdata_reg;

reg         csr_awvalid_reg;
reg  [11:0] csr_awaddr_reg;
reg         csr_wvalid_reg;
reg         csr_bvalid_reg;
reg  [11:0] csr_araddr_reg;
reg         csr_arvalid_reg;
reg         csr_rvalid_reg;
reg  [31:0] csr_rdata_reg;

reg         jump_enable;
reg         jump_abort;
reg         lui_exec;
reg         jalr_exec;
reg         addr_field_valid;
reg  [11:0] last_addr_field;
reg  [31:0] jump_addr_reg;
wire [31:0] status_rd;
wire [31:0] control_rd;
wire [31:0] read_regs;
wire [31:0] instruction_word;
wire [ 6:0] opcode_lui;
wire [ 6:0] opcode_jal;
wire [ 6:0] opcode_jalr;
wire [ 4:0] opcode_rd_x0;
wire [ 4:0] opcode_rd_x1;
wire [ 4:0] opcode_rs1_x1;
wire [20:0] opcode_imm21;
wire [19:0] opcode_jal_imm20;
wire [31:0] inst_jal;
wire [31:0] inst_jalr;
wire [31:0] inst_lui;

// -----------------------------------------------------------------------------
// instruction word state machine
// -----------------------------------------------------------------------------

// opcode patterns
assign opcode_lui    = 7'b0110111;
assign opcode_jal    = 7'b1101111;
assign opcode_jalr   = 7'b1100111;
assign opcode_rd_x0  = 5'b00000;
assign opcode_rd_x1  = 5'b00001;
assign opcode_rs1_x1 = 5'b00001;
assign opcode_imm21  = -{{9{1'b0}},looper_araddr_reg};
assign opcode_jal_imm20 = {opcode_imm21[20],opcode_imm21[10:1],opcode_imm21[11],opcode_imm21[19:12]};

// instruction patterns
assign inst_jal = {opcode_jal_imm20,opcode_rd_x0,opcode_jal};

assign inst_jalr = {jump_addr_reg[11:0],opcode_rs1_x1,3'b000,opcode_rd_x0,opcode_jalr};

assign inst_lui =
		(jump_addr_reg[11] == 1'b1) ?
		{jump_addr_reg[31:12] + 1,opcode_rd_x1,opcode_lui} :
		{jump_addr_reg[31:12],opcode_rd_x1,opcode_lui};

// instruction word muxing
assign instruction_word =
		((looper_araddr_reg == 12'h000) & jump_enable & ~lui_exec & ~jalr_exec) ?
		inst_lui :
		((looper_araddr_reg == 12'h004) & jump_enable & lui_exec & ~jalr_exec) ?
		inst_jalr :
		inst_jal;

// status and control register bitmap patterns
assign status_rd = {{15{1'b0}},addr_field_valid,jalr_exec,lui_exec,jump_abort,jump_enable,last_addr_field};
assign control_rd = {{19{1'b0}},jump_enable,{12{1'b0}}};

// CSR read data muxing
assign read_regs =
		(csr_araddr_reg == 12'h000) ?
		status_rd :
		(csr_araddr_reg == 12'h004) ?
		control_rd :
		jump_addr_reg;

always @ (posedge clk or posedge reset) begin
if(reset) begin
	jump_enable <= 1'b0;
	jump_abort <= 1'b0;
	lui_exec <= 1'b0;
	jalr_exec <= 1'b0;
	addr_field_valid <= 1'b0;
	last_addr_field <= 12'h000;
	jump_addr_reg <= 32'h00000000;
end else begin
	// CSR write transaction
	if(csr_awvalid_reg & csr_wvalid_reg & ~csr_bvalid_reg) begin
		// we cannot write to the status register at 12'h000

		// control register write
		if(csr_awaddr_reg == 12'h004) begin
			// qualify this bit with it's wstrb
			if(csr_wstrb_reg[1]) begin
				jump_enable <= csr_wdata_reg[12];
			end

			// any write operation will clear all these bits
			jump_abort <= 1'b0;
			lui_exec <= 1'b0;
			jalr_exec <= 1'b0;
			addr_field_valid <= 1'b0;
		end

		// jump address register write
		if(csr_awaddr_reg == 12'h008) begin
			// qualify each byte with wstrb
			if(csr_wstrb_reg[0]) begin
				jump_addr_reg[ 7: 0] <= csr_wdata_reg[ 7: 0];
			end
			if(csr_wstrb_reg[1]) begin
				jump_addr_reg[15: 8] <= csr_wdata_reg[15: 8];
			end
			if(csr_wstrb_reg[2]) begin
				jump_addr_reg[23:16] <= csr_wdata_reg[23:16];
			end
			if(csr_wstrb_reg[3]) begin
				jump_addr_reg[31:24] <= csr_wdata_reg[31:24];
			end
		end
	end

	// LOOPER subordinate is read
	if(looper_arvalid_reg & ~looper_rvalid_reg) begin
		// if jump is enabled but we haven't issued lui yet
		if(jump_enable & ~lui_exec) begin
			if(looper_araddr_reg == 12'h000) begin
				// this should be the lui cycle
				lui_exec <= 1'b1;
			end else if(looper_araddr_reg == 12'h004) begin
				// this state may occur when the Nios V pipeline
				// is prefetching after fetching from 12'h000
			end else begin
				// if any other address occurs abort
				jump_enable <= 1'b0;
				jump_abort <= 1'b1;
			end
		end

		// if jump is enabled and we have issued lui already
		if(jump_enable & lui_exec) begin
			// we will always disable jump here
			jump_enable <= 1'b0;
			if(looper_araddr_reg == 12'h004) begin
				// this should be the jalr cycle
				jalr_exec <= 1'b1;
			end else begin
				// if any other address occurs abort
				jump_abort <= 1'b1;
			end
		end

		// always capture the address and mark the valid bit
		addr_field_valid <= 1'b1;
		last_addr_field <= looper_araddr_reg;
	end
end
end

// -----------------------------------------------------------------------------
// LOOPER subordinate control - write channels
// -----------------------------------------------------------------------------

assign looper_sub_bresp = 2'b00;
assign looper_sub_wready = ~looper_wvalid_reg;
assign looper_sub_awready = ~looper_awvalid_reg;
assign looper_sub_bvalid = looper_bvalid_reg;

always @ (posedge clk or posedge reset) begin
if(reset) begin
	looper_awvalid_reg <= 1'b0;
	looper_wvalid_reg <= 1'b0;
	looper_bvalid_reg <= 1'b0;
end else begin
	if(looper_sub_awready & looper_sub_awvalid) begin
		looper_awvalid_reg <= 1'b1;
	end
	if(looper_sub_wready & looper_sub_wvalid) begin
		looper_wvalid_reg <= 1'b1;
	end
	if(looper_awvalid_reg & looper_wvalid_reg & ~looper_bvalid_reg) begin
		looper_bvalid_reg <= 1'b1;
	end
	if(looper_sub_bready & looper_sub_bvalid) begin
		looper_awvalid_reg <= 1'b0;
		looper_wvalid_reg <= 1'b0;
		looper_bvalid_reg <= 1'b0;
	end
end
end

// -----------------------------------------------------------------------------
// LOOPER subordinate control - read channels
// -----------------------------------------------------------------------------

assign looper_sub_rresp = 2'b00;
assign looper_sub_arready = ~looper_arvalid_reg;
assign looper_sub_rvalid = looper_rvalid_reg;
assign looper_sub_rdata = looper_rdata_reg;

always @ (posedge clk or posedge reset) begin
if(reset) begin
	looper_araddr_reg <= 12'h000;
	looper_arvalid_reg <= 1'b0;
	looper_rvalid_reg <= 1'b0;
	looper_rdata_reg <= 32'h00000000;
end else begin
	if(looper_sub_arready & looper_sub_arvalid) begin
		looper_arvalid_reg <= 1'b1;
		looper_araddr_reg <= looper_sub_araddr;
	end
	if(looper_arvalid_reg & ~looper_rvalid_reg) begin
		looper_rvalid_reg <= 1'b1;
		looper_rdata_reg <= instruction_word;
	end
	if(looper_sub_rready & looper_sub_rvalid) begin
		looper_arvalid_reg <= 1'b0;
		looper_rvalid_reg <= 1'b0;
	end
end
end

// -----------------------------------------------------------------------------
// CSR subordinate control - write channels
// -----------------------------------------------------------------------------

assign csr_sub_bresp = 2'b00;
assign csr_sub_wready = ~csr_wvalid_reg;
assign csr_sub_awready = ~csr_awvalid_reg;
assign csr_sub_bvalid = csr_bvalid_reg;

always @ (posedge clk or posedge reset) begin
if(reset) begin
	csr_awaddr_reg <= 12'h000;
	csr_awvalid_reg <= 1'b0;
	csr_wvalid_reg <= 1'b0;
	csr_bvalid_reg <= 1'b0;
end else begin
	if(csr_sub_awready & csr_sub_awvalid) begin
		csr_awvalid_reg <= 1'b1;
		csr_awaddr_reg <= csr_sub_awaddr;
	end
	if(csr_sub_wready & csr_sub_wvalid) begin
		csr_wvalid_reg <= 1'b1;
		csr_wdata_reg <= csr_sub_wdata;
		csr_wstrb_reg <= csr_sub_wstrb;
	end
	if(csr_awvalid_reg & csr_wvalid_reg & ~csr_bvalid_reg) begin
		csr_bvalid_reg <= 1'b1;
	end
	if(csr_sub_bready & csr_sub_bvalid) begin
		csr_awvalid_reg <= 1'b0;
		csr_wvalid_reg <= 1'b0;
		csr_bvalid_reg <= 1'b0;
	end
end
end

// -----------------------------------------------------------------------------
// CSR subordinate control - read channels
// -----------------------------------------------------------------------------

assign csr_sub_rresp = 2'b00;
assign csr_sub_arready = ~csr_arvalid_reg;
assign csr_sub_rvalid = csr_rvalid_reg;
assign csr_sub_rdata = csr_rdata_reg;

always @ (posedge clk or posedge reset) begin
if(reset) begin
	csr_araddr_reg <= 12'h000;
	csr_arvalid_reg <= 1'b0;
	csr_rvalid_reg <= 1'b0;
	csr_rdata_reg <= 32'h00000000;
end else begin
	if(csr_sub_arready & csr_sub_arvalid) begin
		csr_arvalid_reg <= 1'b1;
		csr_araddr_reg <= csr_sub_araddr;
	end
	if(csr_arvalid_reg & ~csr_rvalid_reg) begin
		csr_rvalid_reg <= 1'b1;
		csr_rdata_reg <= read_regs;
	end
	if(csr_sub_rready & csr_sub_rvalid) begin
		csr_arvalid_reg <= 1'b0;
		csr_rvalid_reg <= 1'b0;
	end
end
end

endmodule

