#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Top Level Port Map}
add wave -noupdate /sim_top/tb/test_sys_inst/por_clock_clk
add wave -noupdate /sim_top/tb/test_sys_inst/por_reset_reset
add wave -noupdate -divider {Internal Signals}
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/por/clk
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/por/reset
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/por/sync_dout
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/por/output_reg
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/por/power_on_reset_std_sync_inst/clk
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/por/power_on_reset_std_sync_inst/reset_n
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/por/power_on_reset_std_sync_inst/din
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/por/power_on_reset_std_sync_inst/dout
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/por/power_on_reset_std_sync_inst/din_s1
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/por/power_on_reset_std_sync_inst/dreg
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
WaveRestoreZoom {0 ps} {1 us}
