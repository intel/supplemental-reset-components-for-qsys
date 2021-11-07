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
    add_instance_reset_debouncer_0

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

proc add_instance_reset_debouncer_0 { } {
    add_instance reset_debouncer_0 reset_debouncer
    set_instance_parameter_value reset_debouncer_0 {DEBOUNCE_COUNTER_WIDTH} {16}
}

proc add_connections_and_other_settings {} {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    # connections and connection parameters
    # exported interfaces
    add_interface reset_debouncer_0_debounce_clock clock sink
    set_interface_property reset_debouncer_0_debounce_clock EXPORT_OF reset_debouncer_0.debounce_clock
    add_interface reset_debouncer_0_power_on_reset reset sink
    set_interface_property reset_debouncer_0_power_on_reset EXPORT_OF reset_debouncer_0.power_on_reset
    add_interface reset_debouncer_0_reset_input reset sink
    set_interface_property reset_debouncer_0_reset_input EXPORT_OF reset_debouncer_0.reset_input
    add_interface reset_debouncer_0_reset_output reset source
    set_interface_property reset_debouncer_0_reset_output EXPORT_OF reset_debouncer_0.reset_output
    add_interface reset_debouncer_0_s0_clk clock sink
    set_interface_property reset_debouncer_0_s0_clk EXPORT_OF reset_debouncer_0.s0_clk
    add_interface reset_debouncer_0_s0_reset reset sink
    set_interface_property reset_debouncer_0_s0_reset EXPORT_OF reset_debouncer_0.s0_reset
    add_interface reset_debouncer_0_s0 avalon slave
    set_interface_property reset_debouncer_0_s0 EXPORT_OF reset_debouncer_0.s0

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
}

create_qsys_system

save_system {test_sys.qsys}

