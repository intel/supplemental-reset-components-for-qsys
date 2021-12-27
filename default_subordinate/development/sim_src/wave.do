#
# Copyright (c) 2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/clk
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/reset_reset
add wave -noupdate -divider {Instruction Manager}
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/instruction_manager_araddr
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/instruction_manager_arsize
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/instruction_manager_arprot
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/instruction_manager_arvalid
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/instruction_manager_arready
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/instruction_manager_rdata
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/instruction_manager_rresp
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/instruction_manager_rvalid
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/instruction_manager_rready
add wave -noupdate -divider {Data Manager}
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_awaddr
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_awsize
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_awprot
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_awvalid
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_awready
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_wdata
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_wstrb
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_wlast
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_wvalid
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_wready
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_bresp
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_bvalid
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_bready
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_araddr
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_arsize
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_arprot
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_arvalid
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_arready
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_rdata
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_rresp
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_rvalid
add wave -noupdate /sim_top/tb/test_sys_inst/intel_niosv_m_0/intel_niosv_m_0/data_manager_rready
add wave -noupdate -divider DEFSUB_0
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_araddr
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_arprot
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_arready
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_arvalid
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_awaddr
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_awprot
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_awready
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_awvalid
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_bready
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_bresp
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_bvalid
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_rdata
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_rready
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_rresp
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_rvalid
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_wdata
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_wready
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_wstrb
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/default_sub_wvalid
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/awvalid_reset
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/awvalid_irq
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/awvalid_conduit
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/wvalid_reset
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/wvalid_irq
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/wvalid_conduit
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/arvalid_reset
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/arvalid_irq
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/arvalid_conduit
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/any_valid_reset
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/any_valid_irq
add wave -noupdate /sim_top/tb/test_sys_inst/default_subordinate_0/default_subordinate_0/any_valid_conduit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {235189500 ps}
