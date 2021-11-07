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
    add_instance_conduit_remap_0
    add_instance_conduit_to_interrupt_0
    add_instance_conduit_to_reset_0
    add_instance_interrupt_to_conduit_0
    add_instance_reset_to_conduit_0

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

proc add_instance_conduit_remap_0 { } {
    add_instance conduit_remap_0 conduit_remap
    set_instance_parameter_value conduit_remap_0 {INPUT_CONDUIT_ROLE} {input}
    set_instance_parameter_value conduit_remap_0 {OUTPUT_CONDUIT_ROLE} {output}
}

proc add_instance_conduit_to_interrupt_0 { } {
    add_instance conduit_to_interrupt_0 conduit_to_interrupt
    set_instance_parameter_value conduit_to_interrupt_0 {INPUT_CONDUIT_ROLE} {input}
}

proc add_instance_conduit_to_reset_0 { } {
    add_instance conduit_to_reset_0 conduit_to_reset
    set_instance_parameter_value conduit_to_reset_0 {INPUT_CONDUIT_ROLE} {input}
}

proc add_instance_interrupt_to_conduit_0 { } {
    add_instance interrupt_to_conduit_0 interrupt_to_conduit
    set_instance_parameter_value interrupt_to_conduit_0 {OUTPUT_CONDUIT_ROLE} {output}
}

proc add_instance_reset_to_conduit_0 { } {
    add_instance reset_to_conduit_0 reset_to_conduit
    set_instance_parameter_value reset_to_conduit_0 {OUTPUT_CONDUIT_ROLE} {output}
}

proc add_connections_and_other_settings {} {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    # connections and connection parameters
    # exported interfaces
    add_interface conduit_remap_0_input_conduit conduit end
    set_interface_property conduit_remap_0_input_conduit EXPORT_OF conduit_remap_0.input_conduit
    add_interface conduit_remap_0_output_conduit conduit end
    set_interface_property conduit_remap_0_output_conduit EXPORT_OF conduit_remap_0.output_conduit
    add_interface conduit_to_interrupt_0_input_conduit conduit end
    set_interface_property conduit_to_interrupt_0_input_conduit EXPORT_OF conduit_to_interrupt_0.input_conduit
    add_interface conduit_to_interrupt_0_output_interrupt interrupt sender
    set_interface_property conduit_to_interrupt_0_output_interrupt EXPORT_OF conduit_to_interrupt_0.output_interrupt
    add_interface conduit_to_reset_0_input_conduit conduit end
    set_interface_property conduit_to_reset_0_input_conduit EXPORT_OF conduit_to_reset_0.input_conduit
    add_interface conduit_to_reset_0_output_reset reset source
    set_interface_property conduit_to_reset_0_output_reset EXPORT_OF conduit_to_reset_0.output_reset
    add_interface interrupt_to_conduit_0_input_interrupt interrupt receiver
    set_interface_property interrupt_to_conduit_0_input_interrupt EXPORT_OF interrupt_to_conduit_0.input_interrupt
    add_interface interrupt_to_conduit_0_output_conduit conduit end
    set_interface_property interrupt_to_conduit_0_output_conduit EXPORT_OF interrupt_to_conduit_0.output_conduit
    add_interface reset_to_conduit_0_input_reset reset sink
    set_interface_property reset_to_conduit_0_input_reset EXPORT_OF reset_to_conduit_0.input_reset
    add_interface reset_to_conduit_0_output_conduit conduit end
    set_interface_property reset_to_conduit_0_output_conduit EXPORT_OF reset_to_conduit_0.output_conduit

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
}

create_qsys_system

save_system {test_sys.qsys}

