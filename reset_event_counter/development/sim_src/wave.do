#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Top Level Port Map}
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0_clock_clk
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0_power_on_reset_reset
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0_reset_event_reset
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0_s0_read
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/reset_event_counter_0_s0_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0_s0_clk_clk
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0_s0_reset_reset
add wave -noupdate -divider {Internal Signals}
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/COUNTER_WIDTH
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/clk
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/power_on_reset
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/reset_event
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/s0_clk
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/s0_reset
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/s0_read
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/reset_event_counter_0/s0_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/power_on_reset_sync
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/reset_event_sync
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/reset_event_sync_sync
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/edge_detect
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/deassertion_edge_detected
add wave -noupdate /sim_top/tb/test_sys_inst/reset_event_counter_0/assertion_edge_detected
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/reset_event_counter_0/assertion_count
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/reset_event_counter_0/assertion_count_sync
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/reset_event_counter_0/deassertion_count
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/reset_event_counter_0/deassertion_count_sync
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
WaveRestoreZoom {140 ns} {1140 ns}
