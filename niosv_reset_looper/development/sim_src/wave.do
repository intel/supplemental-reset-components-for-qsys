#
# Copyright (c) 2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sim_top/tb/test_sys_inst/niosv_m/niosv_m/clk
add wave -noupdate /sim_top/tb/test_sys_inst/niosv_m/niosv_m/reset_reset
add wave -noupdate -divider {Instruction Manager}
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/niosv_m/niosv_m/instruction_manager_araddr
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/niosv_m/niosv_m/instruction_manager_arsize
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/niosv_m/niosv_m/instruction_manager_arprot
add wave -noupdate /sim_top/tb/test_sys_inst/niosv_m/niosv_m/instruction_manager_arvalid
add wave -noupdate /sim_top/tb/test_sys_inst/niosv_m/niosv_m/instruction_manager_arready
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/niosv_m/niosv_m/instruction_manager_rdata
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/niosv_m/niosv_m/instruction_manager_rresp
add wave -noupdate /sim_top/tb/test_sys_inst/niosv_m/niosv_m/instruction_manager_rvalid
add wave -noupdate /sim_top/tb/test_sys_inst/niosv_m/niosv_m/instruction_manager_rready
add wave -noupdate -divider {looper_0 LOOPER Subordinate}
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/looper_sub_araddr
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/looper_sub_arprot
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/looper_sub_arready
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/looper_sub_arvalid
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/looper_sub_rdata
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/looper_sub_rready
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/looper_sub_rresp
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/looper_sub_rvalid
add wave -noupdate -divider {BFM Host}
add wave -noupdate /sim_top/tb/test_sys_inst/master_bfm/master_bfm/avm_waitrequest
add wave -noupdate /sim_top/tb/test_sys_inst/master_bfm/master_bfm/avm_readdatavalid
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/master_bfm/master_bfm/avm_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/master_bfm/master_bfm/avm_write
add wave -noupdate /sim_top/tb/test_sys_inst/master_bfm/master_bfm/avm_read
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/master_bfm/master_bfm/avm_address
add wave -noupdate /sim_top/tb/test_sys_inst/master_bfm/master_bfm/avm_byteenable
add wave -noupdate /sim_top/tb/test_sys_inst/master_bfm/master_bfm/avm_burstcount
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/master_bfm/master_bfm/avm_writedata
add wave -noupdate -divider {looper_0 CSR Subordinate}
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_araddr
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_arprot
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_arready
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_arvalid
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_awaddr
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_awprot
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_awready
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_awvalid
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_bready
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_bresp
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_bvalid
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_rdata
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_rready
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_rresp
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_rvalid
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_wdata
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_wready
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_wstrb
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/csr_sub_wvalid
add wave -noupdate -divider {Looper Internals}
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/jump_enable
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/jump_abort
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/lui_exec
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/jalr_exec
add wave -noupdate /sim_top/tb/test_sys_inst/looper_0/looper_0/addr_field_valid
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/last_addr_field
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_0/looper_0/jump_addr_reg
add wave -noupdate -divider {LD Internals}
add wave -noupdate /sim_top/tb/test_sys_inst/looper_default/looper_0/jump_enable
add wave -noupdate /sim_top/tb/test_sys_inst/looper_default/looper_0/jump_abort
add wave -noupdate /sim_top/tb/test_sys_inst/looper_default/looper_0/lui_exec
add wave -noupdate /sim_top/tb/test_sys_inst/looper_default/looper_0/jalr_exec
add wave -noupdate /sim_top/tb/test_sys_inst/looper_default/looper_0/addr_field_valid
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_default/looper_0/last_addr_field
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/looper_default/looper_0/jump_addr_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2750000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 220
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1031112813 ps} {1034394063 ps}
