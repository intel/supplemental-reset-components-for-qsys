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
    add_instance_event_timer_0

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

proc add_instance_event_timer_0 { } {
    add_instance event_timer_0 event_timer
    set_instance_parameter_value event_timer_0 {TIMEOUT_COUNTER_WIDTH} {8}
    set_instance_parameter_value event_timer_0 {EVENT_INPUT_CONDUIT_ROLE} {event_input}
    set_instance_parameter_value event_timer_0 {ENABLE_ACQUIRED_RESET} {1}
    set_instance_parameter_value event_timer_0 {ACQUIRED_RESET_ROLE} {0}
    set_instance_parameter_value event_timer_0 {ENABLE_ACQUIRED_CONDUIT} {1}
    set_instance_parameter_value event_timer_0 {ACQUIRED_CONDUIT_ROLE} {acquired}
    set_instance_parameter_value event_timer_0 {ENABLE_LOST_RESET} {1}
    set_instance_parameter_value event_timer_0 {LOST_RESET_ROLE} {0}
    set_instance_parameter_value event_timer_0 {ENABLE_LOST_CONDUIT} {1}
    set_instance_parameter_value event_timer_0 {LOST_CONDUIT_ROLE} {lost}
    set_instance_parameter_value event_timer_0 {ENABLE_TIMEOUT_RESET} {1}
    set_instance_parameter_value event_timer_0 {TIMEOUT_RESET_ROLE} {0}
    set_instance_parameter_value event_timer_0 {ENABLE_TIMEOUT_CONDUIT} {1}
    set_instance_parameter_value event_timer_0 {TIMEOUT_CONDUIT_ROLE} {timeout}
}

proc add_connections_and_other_settings {} {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    # connections and connection parameters
    # exported interfaces
    add_interface event_timer_0_event_clk clock sink
    set_interface_property event_timer_0_event_clk EXPORT_OF event_timer_0.event_clk
    add_interface event_timer_0_event_reset reset sink
    set_interface_property event_timer_0_event_reset EXPORT_OF event_timer_0.event_reset
    add_interface event_timer_0_event_input conduit end
    set_interface_property event_timer_0_event_input EXPORT_OF event_timer_0.event_input
    add_interface event_timer_0_acquired conduit end
    set_interface_property event_timer_0_acquired EXPORT_OF event_timer_0.acquired
    add_interface event_timer_0_acquired_reset reset source
    set_interface_property event_timer_0_acquired_reset EXPORT_OF event_timer_0.acquired_reset
    add_interface event_timer_0_lost conduit end
    set_interface_property event_timer_0_lost EXPORT_OF event_timer_0.lost
    add_interface event_timer_0_lost_reset reset source
    set_interface_property event_timer_0_lost_reset EXPORT_OF event_timer_0.lost_reset
    add_interface event_timer_0_timeout conduit end
    set_interface_property event_timer_0_timeout EXPORT_OF event_timer_0.timeout
    add_interface event_timer_0_timeout_reset reset source
    set_interface_property event_timer_0_timeout_reset EXPORT_OF event_timer_0.timeout_reset
    add_interface event_timer_0_s0_clk clock sink
    set_interface_property event_timer_0_s0_clk EXPORT_OF event_timer_0.s0_clk
    add_interface event_timer_0_s0_reset reset sink
    set_interface_property event_timer_0_s0_reset EXPORT_OF event_timer_0.s0_reset
    add_interface event_timer_0_s0 avalon slave
    set_interface_property event_timer_0_s0 EXPORT_OF event_timer_0.s0

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
}

create_qsys_system

save_system {test_sys.qsys}

