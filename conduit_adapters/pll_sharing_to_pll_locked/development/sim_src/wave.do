#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Top Level Port Map}
add wave -noupdate /sim_top/tb/test_sys_inst/pll_sharing_to_pll_locked_0_pll_locked_pll_locked
add wave -noupdate /sim_top/tb/test_sys_inst/pll_sharing_to_pll_locked_0_pll_sharing_afi_phy_clk
add wave -noupdate /sim_top/tb/test_sys_inst/pll_sharing_to_pll_locked_0_pll_sharing_pll_addr_cmd_clk
add wave -noupdate /sim_top/tb/test_sys_inst/pll_sharing_to_pll_locked_0_pll_sharing_pll_avl_clk
add wave -noupdate /sim_top/tb/test_sys_inst/pll_sharing_to_pll_locked_0_pll_sharing_pll_avl_phy_clk
add wave -noupdate /sim_top/tb/test_sys_inst/pll_sharing_to_pll_locked_0_pll_sharing_pll_config_clk
add wave -noupdate /sim_top/tb/test_sys_inst/pll_sharing_to_pll_locked_0_pll_sharing_pll_locked
add wave -noupdate /sim_top/tb/test_sys_inst/pll_sharing_to_pll_locked_0_pll_sharing_pll_mem_clk
add wave -noupdate /sim_top/tb/test_sys_inst/pll_sharing_to_pll_locked_0_pll_sharing_pll_mem_phy_clk
add wave -noupdate /sim_top/tb/test_sys_inst/pll_sharing_to_pll_locked_0_pll_sharing_pll_write_clk
add wave -noupdate /sim_top/tb/test_sys_inst/pll_sharing_to_pll_locked_0_pll_sharing_pll_write_clk_pre_phy_clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 350
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {336 ps}
