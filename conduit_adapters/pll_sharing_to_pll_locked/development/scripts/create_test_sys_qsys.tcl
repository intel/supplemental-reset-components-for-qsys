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
    add_instance_pll_sharing_to_pll_locked_0

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

proc add_instance_pll_sharing_to_pll_locked_0 { } {
    add_instance pll_sharing_to_pll_locked_0 pll_sharing_to_pll_locked
}

proc add_connections_and_other_settings {} {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    # connections and connection parameters
    # exported interfaces
    add_interface pll_sharing_to_pll_locked_0_pll_sharing conduit end
    set_interface_property pll_sharing_to_pll_locked_0_pll_sharing EXPORT_OF pll_sharing_to_pll_locked_0.pll_sharing
    add_interface pll_sharing_to_pll_locked_0_pll_locked conduit end
    set_interface_property pll_sharing_to_pll_locked_0_pll_locked EXPORT_OF pll_sharing_to_pll_locked_0.pll_locked

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
}

create_qsys_system

save_system {test_sys.qsys}

