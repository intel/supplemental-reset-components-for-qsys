#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

# qsys scripting (.tcl) file for sync_subsystem
package require -exact qsys 16.0

create_system {sync_subsystem}

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

add_instance cr clock_source
add_instance master altera_avalon_mm_bridge
add_instance jtag_master altera_jtag_avalon_master

#-------------------------------------------------------------------------------

# add_instance cr clock_source 16.0
set_instance_parameter_value cr {clockFrequency} {50000000.0}
set_instance_parameter_value cr {clockFrequencyKnown} {1}
set_instance_parameter_value cr {resetSynchronousEdges} {NONE}

# add_instance master altera_avalon_mm_bridge 16.0
set_instance_parameter_value master {DATA_WIDTH} {32}
set_instance_parameter_value master {SYMBOL_WIDTH} {8}
set_instance_parameter_value master {ADDRESS_WIDTH} {32}
set_instance_parameter_value master {USE_AUTO_ADDRESS_WIDTH} {0}
set_instance_parameter_value master {ADDRESS_UNITS} {SYMBOLS}
set_instance_parameter_value master {MAX_BURST_SIZE} {1}
set_instance_parameter_value master {MAX_PENDING_RESPONSES} {4}
set_instance_parameter_value master {LINEWRAPBURSTS} {0}
set_instance_parameter_value master {PIPELINE_COMMAND} {1}
set_instance_parameter_value master {PIPELINE_RESPONSE} {1}
set_instance_parameter_value master {USE_RESPONSE} {0}

# add_instance jtag_master altera_jtag_avalon_master 16.0
set_instance_parameter_value jtag_master {USE_PLI} {0}
set_instance_parameter_value jtag_master {PLI_PORT} {50000}
set_instance_parameter_value jtag_master {FAST_VER} {0}
set_instance_parameter_value jtag_master {FIFO_DEPTHS} {2}

# exported interfaces
add_interface cr_clk clock sink
set_interface_property cr_clk EXPORT_OF cr.clk_in
add_interface cr_reset reset sink
set_interface_property cr_reset EXPORT_OF cr.clk_in_reset
add_interface master_m0 avalon master
set_interface_property master_m0 EXPORT_OF master.m0

# connections and connection parameters
add_connection cr.clk master.clk

add_connection cr.clk_reset master.reset

add_connection cr.clk jtag_master.clk

add_connection cr.clk_reset jtag_master.clk_reset

add_connection jtag_master.master_reset jtag_master.clk_reset

add_connection jtag_master.master master.s0
set_connection_parameter_value jtag_master.master/master.s0 arbitrationPriority {1}
set_connection_parameter_value jtag_master.master/master.s0 baseAddress {0x0000}
set_connection_parameter_value jtag_master.master/master.s0 defaultConnection {0}

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}

save_system {sync_subsystem.qsys}
