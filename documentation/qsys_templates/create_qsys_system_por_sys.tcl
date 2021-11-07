#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

# qsys scripting (.tcl) file for por_sys
package require -exact qsys 16.0

create_system {por_sys}

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
add_instance por power_on_reset
add_instance main_subsys main_subsystem

#-------------------------------------------------------------------------------

# add_instance free_running_clock altera_clock_bridge 16.0
set_instance_parameter_value free_running_clock {EXPLICIT_CLOCK_RATE} {50000000.0}
set_instance_parameter_value free_running_clock {NUM_CLOCK_OUTPUTS} {1}

# add_instance main_subsys main_subsystem 1.0

# add_instance por power_on_reset 1.0
set_instance_parameter_value por {POR_COUNT} {20}

# exported interfaces
add_interface free_running_clock_in_clk clock sink
set_interface_property free_running_clock_in_clk EXPORT_OF free_running_clock.in_clk

# connections and connection parameters
add_connection free_running_clock.out_clk por.clock

add_connection por.reset main_subsys.main_reset_in_reset

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}

save_system {por_sys.qsys}
