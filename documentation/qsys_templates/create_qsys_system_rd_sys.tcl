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

# qsys scripting (.tcl) file for rd_sys
package require -exact qsys 16.0

create_system {rd_sys}

set_project_property DEVICE_FAMILY {Cyclone V}
set_project_property DEVICE {5CEBA2F17A7}
set_project_property HIDE_FROM_IP_CATALOG {false}

# Instances and instance parameters
# (disabled instances are intentionally culled)

#
# Manually reorder this list of component instances to reflect the order that
# you wish to see them appear in the Qsys GUI.
#
#-------------------------------------------------------------------------------

add_instance free_running_clock altera_clock_bridge 16.0
add_instance external_reset_pin altera_reset_bridge 16.0
add_instance por power_on_reset 1.0
add_instance rd reset_debouncer 1.0
add_instance async_subsystem async_subsystem 1.0

#-------------------------------------------------------------------------------

# add_instance async_subsystem async_subsystem 1.0

# add_instance external_reset_pin altera_reset_bridge 16.0
set_instance_parameter_value external_reset_pin {ACTIVE_LOW_RESET} {0}
set_instance_parameter_value external_reset_pin {SYNCHRONOUS_EDGES} {none}
set_instance_parameter_value external_reset_pin {NUM_RESET_OUTPUTS} {1}
set_instance_parameter_value external_reset_pin {USE_RESET_REQUEST} {0}

# add_instance free_running_clock altera_clock_bridge 16.0
set_instance_parameter_value free_running_clock {EXPLICIT_CLOCK_RATE} {50000000.0}
set_instance_parameter_value free_running_clock {NUM_CLOCK_OUTPUTS} {1}

# add_instance por power_on_reset 1.0
set_instance_parameter_value por {POR_COUNT} {20}

# add_instance rd reset_debouncer 1.0
set_instance_parameter_value rd {DEBOUNCE_COUNTER_WIDTH} {22}

# exported interfaces
add_interface external_reset_pin_in_reset reset sink
set_interface_property external_reset_pin_in_reset EXPORT_OF external_reset_pin.in_reset
add_interface free_running_clock_in_clk clock sink
set_interface_property free_running_clock_in_clk EXPORT_OF free_running_clock.in_clk

# connections and connection parameters
add_connection async_subsystem.master_m0 rd.s0
set_connection_parameter_value async_subsystem.master_m0/rd.s0 arbitrationPriority {1}
set_connection_parameter_value async_subsystem.master_m0/rd.s0 baseAddress {0x0000}
set_connection_parameter_value async_subsystem.master_m0/rd.s0 defaultConnection {0}

add_connection free_running_clock.out_clk por.clock

add_connection free_running_clock.out_clk async_subsystem.cr_clk

add_connection free_running_clock.out_clk rd.debounce_clock

add_connection free_running_clock.out_clk rd.s0_clk

add_connection external_reset_pin.out_reset rd.reset_input

add_connection por.reset rd.power_on_reset

add_connection rd.reset_output async_subsystem.cr_reset

add_connection rd.reset_output rd.s0_reset

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}

save_system {rd_sys.qsys}
