#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider C2C
add wave -noupdate /sim_top/tb/test_sys_inst/conduit_remap_0_input_conduit_input
add wave -noupdate /sim_top/tb/test_sys_inst/conduit_remap_0_output_conduit_output
add wave -noupdate -divider C2I
add wave -noupdate /sim_top/tb/test_sys_inst/conduit_to_interrupt_0_input_conduit_input
add wave -noupdate /sim_top/tb/test_sys_inst/conduit_to_interrupt_0_output_interrupt_irq
add wave -noupdate -divider C2R
add wave -noupdate /sim_top/tb/test_sys_inst/conduit_to_reset_0_input_conduit_input
add wave -noupdate /sim_top/tb/test_sys_inst/conduit_to_reset_0_output_reset_reset
add wave -noupdate -divider I2C
add wave -noupdate /sim_top/tb/test_sys_inst/interrupt_to_conduit_0_input_interrupt_irq
add wave -noupdate /sim_top/tb/test_sys_inst/interrupt_to_conduit_0_output_conduit_output
add wave -noupdate -divider R2C
add wave -noupdate /sim_top/tb/test_sys_inst/reset_to_conduit_0_input_reset_reset
add wave -noupdate /sim_top/tb/test_sys_inst/reset_to_conduit_0_output_conduit_output
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
WaveRestoreZoom {0 ps} {4441500 ps}
