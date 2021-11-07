#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
package require -exact qsys 15.1


#
# module reset_event_counter
#
set_module_property DESCRIPTION "Counts reset assertion and deassertion events."
set_module_property NAME reset_event_counter
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Reset Components"
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME reset_event_counter
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property VALIDATION_CALLBACK validate


#
# file sets
#
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL reset_event_counter
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file reset_event_counter.v VERILOG PATH reset_event_counter.v TOP_LEVEL_FILE
add_fileset_file reset_event_counter.sdc SDC PATH reset_event_counter.sdc

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL reset_event_counter
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file reset_event_counter.v VERILOG PATH reset_event_counter.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL reset_event_counter
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file reset_event_counter.v VERILOG PATH reset_event_counter.v


#
# parameters
#
add_parameter COUNTER_WIDTH INTEGER 16
set_parameter_property COUNTER_WIDTH DEFAULT_VALUE 16
set_parameter_property COUNTER_WIDTH DISPLAY_NAME "Counter Width"
set_parameter_property COUNTER_WIDTH TYPE INTEGER
set_parameter_property COUNTER_WIDTH GROUP "Counter"
set_parameter_property COUNTER_WIDTH UNITS Bits
set_parameter_property COUNTER_WIDTH ALLOWED_RANGES 2:16
set_parameter_property COUNTER_WIDTH DESCRIPTION "Specify the width of the assertion and deassertion counters."
set_parameter_property COUNTER_WIDTH HDL_PARAMETER true

add_parameter CLOCK_FREQ LONG
set_parameter_property CLOCK_FREQ DEFAULT_VALUE 0
set_parameter_property CLOCK_FREQ DISPLAY_NAME "Input clock rate"
set_parameter_property CLOCK_FREQ DESCRIPTION {Input clock rate from system.}
set_parameter_property CLOCK_FREQ UNITS None
set_parameter_property CLOCK_FREQ DERIVED true
set_parameter_property CLOCK_FREQ HDL_PARAMETER false
set_parameter_property CLOCK_FREQ VISIBLE false
set_parameter_property CLOCK_FREQ SYSTEM_INFO {CLOCK_RATE "clock"}
set_parameter_property CLOCK_FREQ AFFECTS_VALIDATION true


#
# display items
#


#
# connection point clock
#
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


#
# connection point power_on_reset
#
add_interface power_on_reset reset end
set_interface_property power_on_reset associatedClock ""
set_interface_property power_on_reset synchronousEdges NONE
set_interface_property power_on_reset ENABLED true
set_interface_property power_on_reset EXPORT_OF ""
set_interface_property power_on_reset PORT_NAME_MAP ""
set_interface_property power_on_reset CMSIS_SVD_VARIABLES ""
set_interface_property power_on_reset SVD_ADDRESS_GROUP ""

add_interface_port power_on_reset power_on_reset reset Input 1


#
# connection point reset_event
#
add_interface reset_event reset end
set_interface_property reset_event associatedClock ""
set_interface_property reset_event synchronousEdges NONE
set_interface_property reset_event ENABLED true
set_interface_property reset_event EXPORT_OF ""
set_interface_property reset_event PORT_NAME_MAP ""
set_interface_property reset_event CMSIS_SVD_VARIABLES ""
set_interface_property reset_event SVD_ADDRESS_GROUP ""

add_interface_port reset_event reset_event reset Input 1


#
# connection point s0_clk
#
add_interface s0_clk clock end
set_interface_property s0_clk clockRate 0
set_interface_property s0_clk ENABLED true
set_interface_property s0_clk EXPORT_OF ""
set_interface_property s0_clk PORT_NAME_MAP ""
set_interface_property s0_clk CMSIS_SVD_VARIABLES ""
set_interface_property s0_clk SVD_ADDRESS_GROUP ""

add_interface_port s0_clk s0_clk clk Input 1


#
# connection point s0_reset
#
add_interface s0_reset reset end
set_interface_property s0_reset associatedClock s0_clk
set_interface_property s0_reset synchronousEdges DEASSERT
set_interface_property s0_reset ENABLED true
set_interface_property s0_reset EXPORT_OF ""
set_interface_property s0_reset PORT_NAME_MAP ""
set_interface_property s0_reset CMSIS_SVD_VARIABLES ""
set_interface_property s0_reset SVD_ADDRESS_GROUP ""

add_interface_port s0_reset s0_reset reset Input 1


#
# connection point s0
#
add_interface s0 avalon end
set_interface_property s0 addressUnits WORDS
set_interface_property s0 associatedClock s0_clk
set_interface_property s0 associatedReset s0_reset
set_interface_property s0 bitsPerSymbol 8
set_interface_property s0 burstOnBurstBoundariesOnly false
set_interface_property s0 burstcountUnits WORDS
set_interface_property s0 explicitAddressSpan 0
set_interface_property s0 holdTime 0
set_interface_property s0 linewrapBursts false
set_interface_property s0 maximumPendingReadTransactions 0
set_interface_property s0 maximumPendingWriteTransactions 0
set_interface_property s0 readLatency 0
set_interface_property s0 readWaitTime 1
set_interface_property s0 setupTime 0
set_interface_property s0 timingUnits Cycles
set_interface_property s0 writeWaitTime 0
set_interface_property s0 ENABLED true
set_interface_property s0 EXPORT_OF ""
set_interface_property s0 PORT_NAME_MAP ""
set_interface_property s0 CMSIS_SVD_VARIABLES ""
set_interface_property s0 SVD_ADDRESS_GROUP ""

add_interface_port s0 s0_read read Input 1
add_interface_port s0 s0_readdata readdata Output 32
set_interface_assignment s0 embeddedsw.configuration.isFlash 0
set_interface_assignment s0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s0 embeddedsw.configuration.isPrintableDevice 0


proc validate {} {
        set_module_assignment embeddedsw.CMacro.COUNTER_WIDTH [ get_parameter_value COUNTER_WIDTH ]
	set_module_assignment embeddedsw.CMacro.CLOCK_FREQ [ get_parameter_value CLOCK_FREQ ]
}

