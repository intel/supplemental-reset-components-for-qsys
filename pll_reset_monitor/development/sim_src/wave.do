#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Top Level Port Map}
add wave -noupdate /sim_top/tb/test_sys_inst/prm_lock_failure_lock_failure
add wave -noupdate /sim_top/tb/test_sys_inst/prm_lock_failure_reset_reset_n
add wave -noupdate /sim_top/tb/test_sys_inst/prm_lock_success_lock_success
add wave -noupdate /sim_top/tb/test_sys_inst/prm_lock_success_reset_reset_n
add wave -noupdate /sim_top/tb/test_sys_inst/prm_pll_locked_pll_locked
add wave -noupdate /sim_top/tb/test_sys_inst/prm_pll_ref_clk_clk
add wave -noupdate /sim_top/tb/test_sys_inst/prm_pll_reset_reset
add wave -noupdate /sim_top/tb/test_sys_inst/prm_pll_reset_request_reset
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/prm_s0_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/prm_s0_read
add wave -noupdate /sim_top/tb/test_sys_inst/prm_s0_clk_clk
add wave -noupdate /sim_top/tb/test_sys_inst/prm_s0_reset_reset
add wave -noupdate -divider {Internal Signals}
add wave -noupdate /sim_top/tb/test_sys_inst/prm/RESET_COUNTER_WIDTH
add wave -noupdate /sim_top/tb/test_sys_inst/prm/LOCK_COUNTER_WIDTH
add wave -noupdate /sim_top/tb/test_sys_inst/prm/pll_ref_clk
add wave -noupdate /sim_top/tb/test_sys_inst/prm/pll_reset_request
add wave -noupdate /sim_top/tb/test_sys_inst/prm/pll_locked
add wave -noupdate /sim_top/tb/test_sys_inst/prm/pll_reset
add wave -noupdate /sim_top/tb/test_sys_inst/prm/lock_success
add wave -noupdate /sim_top/tb/test_sys_inst/prm/lock_success_reset
add wave -noupdate /sim_top/tb/test_sys_inst/prm/lock_failure
add wave -noupdate /sim_top/tb/test_sys_inst/prm/lock_failure_reset
add wave -noupdate /sim_top/tb/test_sys_inst/prm/s0_clk
add wave -noupdate /sim_top/tb/test_sys_inst/prm/s0_reset
add wave -noupdate /sim_top/tb/test_sys_inst/prm/s0_read
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/prm/s0_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/prm/pll_reset_request_sync
add wave -noupdate /sim_top/tb/test_sys_inst/prm/delayed_pll_reset
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/prm/reset_count
add wave -noupdate /sim_top/tb/test_sys_inst/prm/not_pll_locked
add wave -noupdate /sim_top/tb/test_sys_inst/prm/not_pll_locked_sync
add wave -noupdate /sim_top/tb/test_sys_inst/prm/not_pll_locked_sync_sync
add wave -noupdate /sim_top/tb/test_sys_inst/prm/edge_detect
add wave -noupdate /sim_top/tb/test_sys_inst/prm/locked_edge_detected
add wave -noupdate /sim_top/tb/test_sys_inst/prm/not_locked_edge_detected
add wave -noupdate /sim_top/tb/test_sys_inst/prm/lock_count_expired
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/prm/lock_count
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/prm/unlock_count
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/prm/unlock_count_sync
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/prm/capture_lock_count
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/prm/capture_lock_count_sync
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/prm/pre_lock_counter_width
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/prm/lock_counter_width
add wave -noupdate /sim_top/tb/test_sys_inst/prm/lock_success_reg
add wave -noupdate /sim_top/tb/test_sys_inst/prm/lock_failure_reg
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
