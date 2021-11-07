#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Top Level Port Map}
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0_clock_clk
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0_power_on_reset_reset
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0_reset_input_reset
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0_reset_output_reset
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0_reset_output_delayed_reset
add wave -noupdate -divider {Internal Signals}
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0/DELAY_COUNTER_WIDTH
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0/clk
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0/power_on_reset
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0/reset_input
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0/reset_output
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0/reset_output_delayed
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0/reset_input_capture
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0/reset_input_sync
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0/delay_count_expired_int
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0/delay_count_expired
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/reset_assertion_delay_0/delay_count
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0/reset_condition
add wave -noupdate /sim_top/tb/test_sys_inst/reset_assertion_delay_0/reset_output_reg
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
