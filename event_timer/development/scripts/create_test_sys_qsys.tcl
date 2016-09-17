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

