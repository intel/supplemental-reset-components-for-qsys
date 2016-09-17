#
# Copyright (c) 2016 Intel Corporation
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
#
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sim_top/tb/test_sys_inst/clk_clk
add wave -noupdate /sim_top/tb/test_sys_inst/reset_reset_n
add wave -noupdate /sim_top/tb/test_sys_inst/rst_controller_reset_out_reset
add wave -noupdate -divider {TDAS0 none}
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_0_none_slave_read
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_0_none_slave_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_0_none_slave_readdatavalid
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_0_none_slave_write
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_0_none_slave_writedata
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_0_none_slave_byteenable
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_0_none_slave_waitrequest
add wave -noupdate -divider {TDAS1 slave response}
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_1_slave_response_slave_read
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_1_slave_response_slave_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_1_slave_response_slave_readdatavalid
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_1_slave_response_slave_write
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_1_slave_response_slave_writedata
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_1_slave_response_slave_byteenable
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_1_slave_response_slave_waitrequest
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_1_slave_response_slave_response
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_1_slave_response_slave_writeresponsevalid
add wave -noupdate -divider {TDAS2 never respond}
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_2_never_respond_slave_read
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_2_never_respond_slave_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_2_never_respond_slave_readdatavalid
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_2_never_respond_slave_write
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_2_never_respond_slave_writedata
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_2_never_respond_slave_byteenable
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_2_never_respond_slave_waitrequest
add wave -noupdate -divider {TDAS3 access events}
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_3_access_events_access_event_conduit_access_event_conduit
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_3_access_events_access_event_interrupt_irq
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_3_access_events_access_event_reset_reset
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_3_access_events_clear_event_clear_event
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_3_access_events_slave_read
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_3_access_events_slave_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_3_access_events_slave_readdatavalid
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_3_access_events_slave_write
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_3_access_events_slave_writedata
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_3_access_events_slave_byteenable
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_3_access_events_slave_waitrequest
add wave -noupdate -divider {TDAS4 32-bit width}
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_4_32_bit_wide_slave_read
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_4_32_bit_wide_slave_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_4_32_bit_wide_slave_readdatavalid
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_4_32_bit_wide_slave_write
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_4_32_bit_wide_slave_writedata
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_4_32_bit_wide_slave_byteenable
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_4_32_bit_wide_slave_waitrequest
add wave -noupdate -divider {TDAS5 never respond access events}
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_5_never_respond_access_event_access_event_conduit_access_event_conduit
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_5_never_respond_access_event_clear_event_clear_event
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_5_never_respond_access_event_slave_read
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_5_never_respond_access_event_slave_readdata
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_5_never_respond_access_event_slave_readdatavalid
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_5_never_respond_access_event_slave_write
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_5_never_respond_access_event_slave_writedata
add wave -noupdate -radix hexadecimal /sim_top/tb/test_sys_inst/tdas_5_never_respond_access_event_slave_byteenable
add wave -noupdate /sim_top/tb/test_sys_inst/tdas_5_never_respond_access_event_slave_waitrequest
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
