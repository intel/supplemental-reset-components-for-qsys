#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Top Level Port Map}
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0_acquired_acquired
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0_acquired_reset_reset_n
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0_event_clk_clk
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0_event_input_event_input
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0_event_reset_reset
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0_lost_lost
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0_lost_reset_reset_n
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0_s0_read
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/event_timer_0_s0_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0_s0_clk_clk
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0_s0_reset_reset
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0_timeout_timeout
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0_timeout_reset_reset_n
add wave -noupdate -divider {Internal Signals}
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/TIMEOUT_COUNTER_WIDTH
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/event_clk
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/event_reset
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/event_input
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/timeout
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/timeout_reset
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/acquired
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/acquired_reset
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/lost
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/lost_reset
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/s0_clk
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/s0_reset
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/s0_read
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/event_timer_0/s0_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/event_input_sync
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/timeout_count_expired
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/event_acquired_int
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/event_acquired
add wave -noupdate /sim_top/tb/test_sys_inst/event_timer_0/event_lost
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/event_timer_0/timeout_count
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/event_timer_0/capture_timeout_count
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/event_timer_0/capture_timeout_count_sync
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 477
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
WaveRestoreZoom {0 ps} {909993 ps}
