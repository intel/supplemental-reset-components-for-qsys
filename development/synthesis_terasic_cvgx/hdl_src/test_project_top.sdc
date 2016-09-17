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

# define our main clock for our top level logic
create_clock -name CLOCK_50_B6A -period 20.000 [get_ports CLOCK_50_B6A]

# derive all PLL clocks and the uncertainty
derive_pll_clocks                                                              
derive_clock_uncertainty

# constrain the JTAG pins
set_input_delay  -clock { altera_reserved_tck } 5 [get_ports {altera_reserved_tdi}]
set_input_delay  -clock { altera_reserved_tck } 5 [get_ports {altera_reserved_tms}]
set_output_delay -clock { altera_reserved_tck } 5 [get_ports {altera_reserved_tdo}]

# NOTE, the DDR pins are taken care of by the SDC contraints provided by the
# core and the pin_assignments.tcl script

# constrain the low speed GPIO pins that we don't need to be timed
set_false_path -to   [get_ports LEDG*]
set_false_path -to   [get_ports LEDR*]

# NOTE: the HMC core has internal async timing paths that leak across clock
# domains through the reset ports that we drive from our Qsys system.  This will
# produce hold/recovery violations in our design, however all of these paths are
# actually false paths.  So to prevent the hold/recovery violations we will
# false path the resets that we drive into the HMC core.
#
# The global ddr reset input and the soft reset input can be cut globally since
# they only drive into the HMC core.
set_false_path -from [get_registers {test_sys:u0|test_sys_resets:resets|altera_reset_controller:ddr_reset_out|altera_reset_synchronizer:alt_rst_sync_uq1|altera_reset_synchronizer_int_chain_out}]
set_false_path -from [get_registers {test_sys:u0|test_sys_resets:resets|altera_reset_controller:ddr_soft_reset|altera_reset_synchronizer:alt_rst_sync_uq1|altera_reset_synchronizer_int_chain_out}]

# The main Qsys system reset that also drives into the AVMM slave interfaces of
# the HMC core will be selectively cut between the last reset output register
# and the HMC core registers.
set_false_path -from [get_registers {test_sys:u0|test_sys_resets:resets|altera_reset_controller:system_reset_out|altera_reset_synchronizer:alt_rst_sync_uq1|altera_reset_synchronizer_int_chain_out}] \
                 -to [get_registers {test_sys:u0|test_sys_ddr_emif:ddr_emif|altera_mem_if_hard_memory_controller_top_cyclonev:c0|*}]

