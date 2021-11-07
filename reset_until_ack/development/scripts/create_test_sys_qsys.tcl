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
    add_instance_rua

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

proc add_instance_rua { } {
    add_instance rua reset_until_ack
}

proc add_connections_and_other_settings {} {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    # connections and connection parameters
    # exported interfaces
    add_interface rua_clk_in clock sink
    set_interface_property rua_clk_in EXPORT_OF rua.clk_in
    add_interface rua_reset_assert reset sink
    set_interface_property rua_reset_assert EXPORT_OF rua.reset_assert
    add_interface rua_reset_release reset sink
    set_interface_property rua_reset_release EXPORT_OF rua.reset_release
    add_interface rua_reset_out reset source
    set_interface_property rua_reset_out EXPORT_OF rua.reset_out

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
}

create_qsys_system

save_system {test_sys.qsys}

