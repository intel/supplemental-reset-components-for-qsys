#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

# qsys scripting (.tcl) file for rec_sys
package require -exact qsys 16.0

create_system {rec_sys}

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

add_instance free_running_clock altera_clock_bridge
add_instance external_reset_pin altera_reset_bridge
add_instance por power_on_reset
add_instance rd reset_debouncer
add_instance rec reset_event_counter
add_instance async_subsystem async_subsystem

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
set_instance_parameter_value rd {DEBOUNCE_COUNTER_WIDTH} {16}

# add_instance rec reset_event_counter 1.0
set_instance_parameter_value rec {COUNTER_WIDTH} {16}

# exported interfaces
add_interface external_reset_pin_in_reset reset sink
set_interface_property external_reset_pin_in_reset EXPORT_OF external_reset_pin.in_reset
add_interface free_running_clock_in_clk clock sink
set_interface_property free_running_clock_in_clk EXPORT_OF free_running_clock.in_clk

# connections and connection parameters
add_connection async_subsystem.master_m0 rd.s0
set_connection_parameter_value async_subsystem.master_m0/rd.s0 arbitrationPriority {1}
set_connection_parameter_value async_subsystem.master_m0/rd.s0 baseAddress {0x0004}
set_connection_parameter_value async_subsystem.master_m0/rd.s0 defaultConnection {0}

add_connection async_subsystem.master_m0 rec.s0
set_connection_parameter_value async_subsystem.master_m0/rec.s0 arbitrationPriority {1}
set_connection_parameter_value async_subsystem.master_m0/rec.s0 baseAddress {0x0000}
set_connection_parameter_value async_subsystem.master_m0/rec.s0 defaultConnection {0}

add_connection free_running_clock.out_clk por.clock

add_connection free_running_clock.out_clk rec.clock

add_connection free_running_clock.out_clk async_subsystem.cr_clk

add_connection free_running_clock.out_clk rd.debounce_clock

add_connection free_running_clock.out_clk rd.s0_clk

add_connection free_running_clock.out_clk rec.s0_clk

add_connection external_reset_pin.out_reset rd.reset_input

add_connection por.reset rd.power_on_reset

add_connection por.reset rec.power_on_reset

add_connection rd.reset_output async_subsystem.cr_reset

add_connection rd.reset_output rec.reset_event

add_connection rd.reset_output rd.s0_reset

add_connection rd.reset_output rec.s0_reset

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}

save_system {rec_sys.qsys}
