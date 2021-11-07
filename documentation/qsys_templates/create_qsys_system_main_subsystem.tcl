#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

# qsys scripting (.tcl) file for main_subsystem
package require -exact qsys 16.0

create_system {main_subsystem}

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

add_instance main_reset altera_reset_bridge

#-------------------------------------------------------------------------------

# add_instance main_reset altera_reset_bridge 16.0
set_instance_parameter_value main_reset {ACTIVE_LOW_RESET} {0}
set_instance_parameter_value main_reset {SYNCHRONOUS_EDGES} {none}
set_instance_parameter_value main_reset {NUM_RESET_OUTPUTS} {1}
set_instance_parameter_value main_reset {USE_RESET_REQUEST} {0}

# exported interfaces
add_interface main_reset_in_reset reset sink
set_interface_property main_reset_in_reset EXPORT_OF main_reset.in_reset

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}

save_system {main_subsystem.qsys}
