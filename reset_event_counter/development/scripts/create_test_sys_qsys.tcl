#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
package require -exact qsys 14.0

create_system {test_sys}

set_project_property {DEVICE_FAMILY} {Arria 10}
set_project_property {DEVICE} {10AS066N3F40E2SG}

proc create_qsys_system {} {

    #
    # Manually reorder this list of component instances to reflect the order
    # that you wish to see them appear in the Qsys GUI.
    #
    add_instance_reset_event_counter_0

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

proc add_instance_reset_event_counter_0 { } {
    add_instance reset_event_counter_0 reset_event_counter
    set_instance_parameter_value reset_event_counter_0 {COUNTER_WIDTH} {16}
}

proc add_connections_and_other_settings {} {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    # connections and connection parameters
    # exported interfaces
    add_interface reset_event_counter_0_clock clock sink
    set_interface_property reset_event_counter_0_clock EXPORT_OF reset_event_counter_0.clock
    add_interface reset_event_counter_0_power_on_reset reset sink
    set_interface_property reset_event_counter_0_power_on_reset EXPORT_OF reset_event_counter_0.power_on_reset
    add_interface reset_event_counter_0_reset_event reset sink
    set_interface_property reset_event_counter_0_reset_event EXPORT_OF reset_event_counter_0.reset_event
    add_interface reset_event_counter_0_s0_clk clock sink
    set_interface_property reset_event_counter_0_s0_clk EXPORT_OF reset_event_counter_0.s0_clk
    add_interface reset_event_counter_0_s0_reset reset sink
    set_interface_property reset_event_counter_0_s0_reset EXPORT_OF reset_event_counter_0.s0_reset
    add_interface reset_event_counter_0_s0 avalon slave
    set_interface_property reset_event_counter_0_s0 EXPORT_OF reset_event_counter_0.s0

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
}

create_qsys_system

save_system {test_sys.qsys}

