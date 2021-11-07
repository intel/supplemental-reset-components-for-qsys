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
    add_instance_emif_status_breakout_0

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

proc add_instance_emif_status_breakout_0 { } {
    add_instance emif_status_breakout_0 emif_status_breakout
}

proc add_connections_and_other_settings {} {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    # connections and connection parameters
    # exported interfaces
    add_interface emif_status_breakout_0_status conduit end
    set_interface_property emif_status_breakout_0_status EXPORT_OF emif_status_breakout_0.status
    add_interface emif_status_breakout_0_cal_fail reset source
    set_interface_property emif_status_breakout_0_cal_fail EXPORT_OF emif_status_breakout_0.cal_fail
    add_interface emif_status_breakout_0_cal_success conduit end
    set_interface_property emif_status_breakout_0_cal_success EXPORT_OF emif_status_breakout_0.cal_success
    add_interface emif_status_breakout_0_init_done conduit end
    set_interface_property emif_status_breakout_0_init_done EXPORT_OF emif_status_breakout_0.init_done

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
}

create_qsys_system

save_system {test_sys.qsys}

