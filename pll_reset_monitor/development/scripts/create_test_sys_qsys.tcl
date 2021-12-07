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
    add_instance_prm

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

proc add_instance_prm { } {
    add_instance prm pll_reset_monitor
    set_instance_parameter_value prm {RESET_COUNTER_WIDTH} {4}
    set_instance_parameter_value prm {LOCK_COUNTER_WIDTH} {8}
    set_instance_parameter_value prm {PLL_LOCKED_CONDUIT_ROLE} {pll_locked}
    set_instance_parameter_value prm {ENABLE_LOCK_SUCCESS_RESET} {1}
    set_instance_parameter_value prm {LOCK_SUCCESS_RESET_ROLE} {0}
    set_instance_parameter_value prm {ENABLE_LOCK_SUCCESS_CONDUIT} {1}
    set_instance_parameter_value prm {LOCK_SUCCESS_CONDUIT_ROLE} {lock_success}
    set_instance_parameter_value prm {ENABLE_LOCK_FAILURE_RESET} {1}
    set_instance_parameter_value prm {LOCK_FAILURE_RESET_ROLE} {0}
    set_instance_parameter_value prm {ENABLE_LOCK_FAILURE_CONDUIT} {1}
    set_instance_parameter_value prm {LOCK_FAILURE_CONDUIT_ROLE} {lock_failure}
}

proc add_connections_and_other_settings {} {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    # connections and connection parameters
    # exported interfaces
    add_interface prm_pll_ref_clk clock sink
    set_interface_property prm_pll_ref_clk EXPORT_OF prm.pll_ref_clk
    add_interface prm_pll_reset_request reset sink
    set_interface_property prm_pll_reset_request EXPORT_OF prm.pll_reset_request
    add_interface prm_pll_locked conduit end
    set_interface_property prm_pll_locked EXPORT_OF prm.pll_locked
    add_interface prm_s0_clk clock sink
    set_interface_property prm_s0_clk EXPORT_OF prm.s0_clk
    add_interface prm_s0_reset reset sink
    set_interface_property prm_s0_reset EXPORT_OF prm.s0_reset
    add_interface prm_s0 avalon slave
    set_interface_property prm_s0 EXPORT_OF prm.s0
    add_interface prm_pll_reset reset source
    set_interface_property prm_pll_reset EXPORT_OF prm.pll_reset
    add_interface prm_lock_success conduit end
    set_interface_property prm_lock_success EXPORT_OF prm.lock_success
    add_interface prm_lock_success_reset reset source
    set_interface_property prm_lock_success_reset EXPORT_OF prm.lock_success_reset
    add_interface prm_lock_failure conduit end
    set_interface_property prm_lock_failure EXPORT_OF prm.lock_failure
    add_interface prm_lock_failure_reset reset source
    set_interface_property prm_lock_failure_reset EXPORT_OF prm.lock_failure_reset

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
}

create_qsys_system

save_system {test_sys.qsys}

