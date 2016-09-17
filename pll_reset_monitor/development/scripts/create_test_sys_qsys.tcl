#
# Copyright (c) 2016 Intel Corporation
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
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

