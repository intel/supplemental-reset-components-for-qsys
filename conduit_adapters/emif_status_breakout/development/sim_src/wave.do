#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Top Level Port Map}
add wave -noupdate /sim_top/tb/test_sys_inst/emif_status_breakout_0_status_local_cal_success
add wave -noupdate /sim_top/tb/test_sys_inst/emif_status_breakout_0_cal_success_event_input
add wave -noupdate /sim_top/tb/test_sys_inst/emif_status_breakout_0_status_local_cal_fail
add wave -noupdate /sim_top/tb/test_sys_inst/emif_status_breakout_0_cal_fail_reset
add wave -noupdate /sim_top/tb/test_sys_inst/emif_status_breakout_0_status_local_init_done
add wave -noupdate /sim_top/tb/test_sys_inst/emif_status_breakout_0_init_done_event_input
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
WaveRestoreZoom {0 ps} {168 ps}
