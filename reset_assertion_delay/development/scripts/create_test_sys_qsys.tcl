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
    add_instance_reset_assertion_delay_0

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

proc add_instance_reset_assertion_delay_0 { } {
    add_instance reset_assertion_delay_0 reset_assertion_delay
    set_instance_parameter_value reset_assertion_delay_0 {DELAY_COUNTER_WIDTH} {5}
}

proc add_connections_and_other_settings {} {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    # connections and connection parameters
    # exported interfaces
    add_interface reset_assertion_delay_0_clock clock sink
    set_interface_property reset_assertion_delay_0_clock EXPORT_OF reset_assertion_delay_0.clock
    add_interface reset_assertion_delay_0_power_on_reset reset sink
    set_interface_property reset_assertion_delay_0_power_on_reset EXPORT_OF reset_assertion_delay_0.power_on_reset
    add_interface reset_assertion_delay_0_reset_input reset sink
    set_interface_property reset_assertion_delay_0_reset_input EXPORT_OF reset_assertion_delay_0.reset_input
    add_interface reset_assertion_delay_0_reset_output reset source
    set_interface_property reset_assertion_delay_0_reset_output EXPORT_OF reset_assertion_delay_0.reset_output
    add_interface reset_assertion_delay_0_reset_output_delayed reset source
    set_interface_property reset_assertion_delay_0_reset_output_delayed EXPORT_OF reset_assertion_delay_0.reset_output_delayed

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
}

create_qsys_system

save_system {test_sys.qsys}

