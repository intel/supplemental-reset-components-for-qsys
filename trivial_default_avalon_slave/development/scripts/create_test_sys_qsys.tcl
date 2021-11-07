#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
package require -exact qsys 14.0

create_system {test_sys}

set_project_property {DEVICE_FAMILY} {CYCLONEV}
set_project_property {DEVICE} {5CGXFC5C6F27C7}

proc create_qsys_system {} {

    #
    # Manually reorder this list of component instances to reflect the order
    # that you wish to see them appear in the Qsys GUI.
    #
    add_instance_clk_0
    add_instance_tdas_0_none
    add_instance_tdas_1_slave_response
    add_instance_tdas_2_never_respond
    add_instance_tdas_3_access_events
    add_instance_tdas_4_32_bit_wide
    add_instance_tdas_5_never_respond_access_event

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

proc add_instance_clk_0 { } {
    add_instance clk_0 clock_source
    set_instance_parameter_value clk_0 {clockFrequency} {50000000.0}
    set_instance_parameter_value clk_0 {clockFrequencyKnown} {1}
    set_instance_parameter_value clk_0 {resetSynchronousEdges} {NONE}
}

proc add_instance_tdas_0_none { } {
    add_instance tdas_0_none trivial_default_avalon_slave
    set_instance_parameter_value tdas_0_none {DATA_BYTES} {1}
    set_instance_parameter_value tdas_0_none {READ_DATA_PATTERN} {224}
    set_instance_parameter_value tdas_0_none {ENABLE_READ_RESPONSE} {0}
    set_instance_parameter_value tdas_0_none {RESPONSE_PATTERN} {0}
    set_instance_parameter_value tdas_0_none {ENABLE_WRITE_RESPONSE} {0}
    set_instance_parameter_value tdas_0_none {NEVER_RESPOND} {0}
    set_instance_parameter_value tdas_0_none {ENABLE_CLEAR_EVENT} {0}
    set_instance_parameter_value tdas_0_none {CLEAR_EVENT_CONDUIT_ROLE} {clear_event}
    set_instance_parameter_value tdas_0_none {ENABLE_ACCESS_EVENT_CONDUIT} {0}
    set_instance_parameter_value tdas_0_none {ACCESS_EVENT_CONDUIT_ROLE} {access_event_conduit}
    set_instance_parameter_value tdas_0_none {ENABLE_ACCESS_EVENT_RESET} {0}
    set_instance_parameter_value tdas_0_none {ENABLE_ACCESS_EVENT_INTERRUPT} {0}
}

proc add_instance_tdas_1_slave_response { } {
    add_instance tdas_1_slave_response trivial_default_avalon_slave
    set_instance_parameter_value tdas_1_slave_response {DATA_BYTES} {1}
    set_instance_parameter_value tdas_1_slave_response {READ_DATA_PATTERN} {225}
    set_instance_parameter_value tdas_1_slave_response {ENABLE_READ_RESPONSE} {1}
    set_instance_parameter_value tdas_1_slave_response {RESPONSE_PATTERN} {2}
    set_instance_parameter_value tdas_1_slave_response {ENABLE_WRITE_RESPONSE} {1}
    set_instance_parameter_value tdas_1_slave_response {NEVER_RESPOND} {0}
    set_instance_parameter_value tdas_1_slave_response {ENABLE_CLEAR_EVENT} {0}
    set_instance_parameter_value tdas_1_slave_response {CLEAR_EVENT_CONDUIT_ROLE} {clear_event}
    set_instance_parameter_value tdas_1_slave_response {ENABLE_ACCESS_EVENT_CONDUIT} {0}
    set_instance_parameter_value tdas_1_slave_response {ACCESS_EVENT_CONDUIT_ROLE} {access_event_conduit}
    set_instance_parameter_value tdas_1_slave_response {ENABLE_ACCESS_EVENT_RESET} {0}
    set_instance_parameter_value tdas_1_slave_response {ENABLE_ACCESS_EVENT_INTERRUPT} {0}
}

proc add_instance_tdas_2_never_respond { } {
    add_instance tdas_2_never_respond trivial_default_avalon_slave
    set_instance_parameter_value tdas_2_never_respond {DATA_BYTES} {1}
    set_instance_parameter_value tdas_2_never_respond {READ_DATA_PATTERN} {226}
    set_instance_parameter_value tdas_2_never_respond {ENABLE_READ_RESPONSE} {0}
    set_instance_parameter_value tdas_2_never_respond {RESPONSE_PATTERN} {0}
    set_instance_parameter_value tdas_2_never_respond {ENABLE_WRITE_RESPONSE} {0}
    set_instance_parameter_value tdas_2_never_respond {NEVER_RESPOND} {1}
    set_instance_parameter_value tdas_2_never_respond {ENABLE_CLEAR_EVENT} {0}
    set_instance_parameter_value tdas_2_never_respond {CLEAR_EVENT_CONDUIT_ROLE} {clear_event}
    set_instance_parameter_value tdas_2_never_respond {ENABLE_ACCESS_EVENT_CONDUIT} {0}
    set_instance_parameter_value tdas_2_never_respond {ACCESS_EVENT_CONDUIT_ROLE} {access_event_conduit}
    set_instance_parameter_value tdas_2_never_respond {ENABLE_ACCESS_EVENT_RESET} {0}
    set_instance_parameter_value tdas_2_never_respond {ENABLE_ACCESS_EVENT_INTERRUPT} {0}
}

proc add_instance_tdas_3_access_events { } {
    add_instance tdas_3_access_events trivial_default_avalon_slave
    set_instance_parameter_value tdas_3_access_events {DATA_BYTES} {1}
    set_instance_parameter_value tdas_3_access_events {READ_DATA_PATTERN} {227}
    set_instance_parameter_value tdas_3_access_events {ENABLE_READ_RESPONSE} {0}
    set_instance_parameter_value tdas_3_access_events {RESPONSE_PATTERN} {0}
    set_instance_parameter_value tdas_3_access_events {ENABLE_WRITE_RESPONSE} {0}
    set_instance_parameter_value tdas_3_access_events {NEVER_RESPOND} {0}
    set_instance_parameter_value tdas_3_access_events {ENABLE_CLEAR_EVENT} {1}
    set_instance_parameter_value tdas_3_access_events {CLEAR_EVENT_CONDUIT_ROLE} {clear_event}
    set_instance_parameter_value tdas_3_access_events {ENABLE_ACCESS_EVENT_CONDUIT} {1}
    set_instance_parameter_value tdas_3_access_events {ACCESS_EVENT_CONDUIT_ROLE} {access_event_conduit}
    set_instance_parameter_value tdas_3_access_events {ENABLE_ACCESS_EVENT_RESET} {1}
    set_instance_parameter_value tdas_3_access_events {ENABLE_ACCESS_EVENT_INTERRUPT} {1}
}

proc add_instance_tdas_4_32_bit_wide { } {
    add_instance tdas_4_32_bit_wide trivial_default_avalon_slave
    set_instance_parameter_value tdas_4_32_bit_wide {DATA_BYTES} {4}
    set_instance_parameter_value tdas_4_32_bit_wide {READ_DATA_PATTERN} {228}
    set_instance_parameter_value tdas_4_32_bit_wide {ENABLE_READ_RESPONSE} {0}
    set_instance_parameter_value tdas_4_32_bit_wide {RESPONSE_PATTERN} {0}
    set_instance_parameter_value tdas_4_32_bit_wide {ENABLE_WRITE_RESPONSE} {0}
    set_instance_parameter_value tdas_4_32_bit_wide {NEVER_RESPOND} {0}
    set_instance_parameter_value tdas_4_32_bit_wide {ENABLE_CLEAR_EVENT} {0}
    set_instance_parameter_value tdas_4_32_bit_wide {CLEAR_EVENT_CONDUIT_ROLE} {clear_event}
    set_instance_parameter_value tdas_4_32_bit_wide {ENABLE_ACCESS_EVENT_CONDUIT} {0}
    set_instance_parameter_value tdas_4_32_bit_wide {ACCESS_EVENT_CONDUIT_ROLE} {access_event_conduit}
    set_instance_parameter_value tdas_4_32_bit_wide {ENABLE_ACCESS_EVENT_RESET} {0}
    set_instance_parameter_value tdas_4_32_bit_wide {ENABLE_ACCESS_EVENT_INTERRUPT} {0}
}

proc add_instance_tdas_5_never_respond_access_event { } {
    add_instance tdas_5_never_respond_access_event trivial_default_avalon_slave
    set_instance_parameter_value tdas_5_never_respond_access_event {DATA_BYTES} {1}
    set_instance_parameter_value tdas_5_never_respond_access_event {READ_DATA_PATTERN} {229}
    set_instance_parameter_value tdas_5_never_respond_access_event {ENABLE_READ_RESPONSE} {0}
    set_instance_parameter_value tdas_5_never_respond_access_event {RESPONSE_PATTERN} {0}
    set_instance_parameter_value tdas_5_never_respond_access_event {ENABLE_WRITE_RESPONSE} {0}
    set_instance_parameter_value tdas_5_never_respond_access_event {NEVER_RESPOND} {1}
    set_instance_parameter_value tdas_5_never_respond_access_event {ENABLE_CLEAR_EVENT} {1}
    set_instance_parameter_value tdas_5_never_respond_access_event {CLEAR_EVENT_CONDUIT_ROLE} {clear_event}
    set_instance_parameter_value tdas_5_never_respond_access_event {ENABLE_ACCESS_EVENT_CONDUIT} {1}
    set_instance_parameter_value tdas_5_never_respond_access_event {ACCESS_EVENT_CONDUIT_ROLE} {access_event_conduit}
    set_instance_parameter_value tdas_5_never_respond_access_event {ENABLE_ACCESS_EVENT_RESET} {0}
    set_instance_parameter_value tdas_5_never_respond_access_event {ENABLE_ACCESS_EVENT_INTERRUPT} {0}
}

proc add_connections_and_other_settings {} {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    # connections and connection parameters
    add_connection clk_0.clk tdas_0_none.clock clock

    add_connection clk_0.clk tdas_1_slave_response.clock clock

    add_connection clk_0.clk tdas_2_never_respond.clock clock

    add_connection clk_0.clk tdas_3_access_events.clock clock

    add_connection clk_0.clk tdas_4_32_bit_wide.clock clock

    add_connection clk_0.clk_reset tdas_0_none.reset reset

    add_connection clk_0.clk_reset tdas_1_slave_response.reset reset

    add_connection clk_0.clk_reset tdas_2_never_respond.reset reset

    add_connection clk_0.clk_reset tdas_3_access_events.reset reset

    add_connection clk_0.clk_reset tdas_4_32_bit_wide.reset reset

    add_connection clk_0.clk tdas_5_never_respond_access_event.clock clock

    add_connection clk_0.clk_reset tdas_5_never_respond_access_event.reset reset

    # exported interfaces
    add_interface clk clock sink
    set_interface_property clk EXPORT_OF clk_0.clk_in
    add_interface reset reset sink
    set_interface_property reset EXPORT_OF clk_0.clk_in_reset
    add_interface tdas_0_none_slave avalon slave
    set_interface_property tdas_0_none_slave EXPORT_OF tdas_0_none.slave
    add_interface tdas_1_slave_response_slave avalon slave
    set_interface_property tdas_1_slave_response_slave EXPORT_OF tdas_1_slave_response.slave
    add_interface tdas_2_never_respond_slave avalon slave
    set_interface_property tdas_2_never_respond_slave EXPORT_OF tdas_2_never_respond.slave
    add_interface tdas_3_access_events_access_event_conduit conduit end
    set_interface_property tdas_3_access_events_access_event_conduit EXPORT_OF tdas_3_access_events.access_event_conduit
    add_interface tdas_3_access_events_access_event_interrupt interrupt sender
    set_interface_property tdas_3_access_events_access_event_interrupt EXPORT_OF tdas_3_access_events.access_event_interrupt
    add_interface tdas_3_access_events_access_event_reset reset source
    set_interface_property tdas_3_access_events_access_event_reset EXPORT_OF tdas_3_access_events.access_event_reset
    add_interface tdas_3_access_events_clear_event conduit end
    set_interface_property tdas_3_access_events_clear_event EXPORT_OF tdas_3_access_events.clear_event
    add_interface tdas_3_access_events_slave avalon slave
    set_interface_property tdas_3_access_events_slave EXPORT_OF tdas_3_access_events.slave
    add_interface tdas_4_32_bit_wide_slave avalon slave
    set_interface_property tdas_4_32_bit_wide_slave EXPORT_OF tdas_4_32_bit_wide.slave
    add_interface tdas_5_never_respond_access_event_slave avalon slave
    set_interface_property tdas_5_never_respond_access_event_slave EXPORT_OF tdas_5_never_respond_access_event.slave
    add_interface tdas_5_never_respond_access_event_clear_event conduit end
    set_interface_property tdas_5_never_respond_access_event_clear_event EXPORT_OF tdas_5_never_respond_access_event.clear_event
    add_interface tdas_5_never_respond_access_event_access_event_conduit conduit end
    set_interface_property tdas_5_never_respond_access_event_access_event_conduit EXPORT_OF tdas_5_never_respond_access_event.access_event_conduit

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
}

create_qsys_system

save_system {test_sys.qsys}

