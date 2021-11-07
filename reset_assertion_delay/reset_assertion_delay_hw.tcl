#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
package require -exact qsys 15.1


#
# module reset_assertion_delay
#
set_module_property DESCRIPTION "Delay PLL reset after system reset."
set_module_property NAME reset_assertion_delay
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Reset Components"
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME reset_assertion_delay
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property ELABORATION_CALLBACK elaborate
set_module_property VALIDATION_CALLBACK validate


#
# file sets
#
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL reset_assertion_delay
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file reset_assertion_delay.v VERILOG PATH reset_assertion_delay.v TOP_LEVEL_FILE
add_fileset_file reset_assertion_delay.sdc SDC PATH reset_assertion_delay.sdc

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL reset_assertion_delay
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file reset_assertion_delay.v VERILOG PATH reset_assertion_delay.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL reset_assertion_delay
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file reset_assertion_delay.v VERILOG PATH reset_assertion_delay.v


#
# parameters
#
add_parameter DELAY_COUNTER_WIDTH INTEGER
set_parameter_property DELAY_COUNTER_WIDTH DEFAULT_VALUE 5
set_parameter_property DELAY_COUNTER_WIDTH DISPLAY_NAME "Delay Counter Width"
set_parameter_property DELAY_COUNTER_WIDTH TYPE INTEGER
set_parameter_property DELAY_COUNTER_WIDTH GROUP "Delay Counter"
set_parameter_property DELAY_COUNTER_WIDTH UNITS Bits
set_parameter_property DELAY_COUNTER_WIDTH ALLOWED_RANGES 2:32
set_parameter_property DELAY_COUNTER_WIDTH DESCRIPTION "Determines the duration of the reset delay after the initial reset asserts."
set_parameter_property DELAY_COUNTER_WIDTH HDL_PARAMETER true
set_parameter_property DELAY_COUNTER_WIDTH AFFECTS_VALIDATION true
set_parameter_property DELAY_COUNTER_WIDTH AFFECTS_ELABORATION true

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
set_parameter_property CLOCK_FREQ AFFECTS_ELABORATION true

add_parameter DURATION_TIME FLOAT
set_parameter_property DURATION_TIME DEFAULT_VALUE "0.0"
set_parameter_property DURATION_TIME DISPLAY_NAME "Delay Counter Duration"
set_parameter_property DURATION_TIME DESCRIPTION {Calculation of the delay counter duration.  Clock input must be connected to a known frequency for calculation to appear.}
set_parameter_property DURATION_TIME UNITS Nanoseconds
set_parameter_property DURATION_TIME GROUP "Delay Counter"
set_parameter_property DURATION_TIME DERIVED true
set_parameter_property DURATION_TIME HDL_PARAMETER false
set_parameter_property DURATION_TIME VISIBLE false

add_parameter DURATION_STRING STRING
set_parameter_property DURATION_STRING DEFAULT_VALUE "Unknown clock input frequency."
set_parameter_property DURATION_STRING DISPLAY_NAME "Delay Counter Duration"
set_parameter_property DURATION_STRING DESCRIPTION {Calculation of the delay counter duration.  Clock input must be connected to a known frequency for calculation to appear.}
set_parameter_property DURATION_STRING UNITS none
set_parameter_property DURATION_STRING GROUP "Delay Counter"
set_parameter_property DURATION_STRING DERIVED true
set_parameter_property DURATION_STRING HDL_PARAMETER false
set_parameter_property DURATION_STRING VISIBLE false


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
set_interface_property power_on_reset associatedClock clock
set_interface_property power_on_reset synchronousEdges DEASSERT
set_interface_property power_on_reset ENABLED true
set_interface_property power_on_reset EXPORT_OF ""
set_interface_property power_on_reset PORT_NAME_MAP ""
set_interface_property power_on_reset CMSIS_SVD_VARIABLES ""
set_interface_property power_on_reset SVD_ADDRESS_GROUP ""

add_interface_port power_on_reset power_on_reset reset Input 1


#
# connection point reset_input
#
add_interface reset_input reset end
set_interface_property reset_input associatedClock ""
set_interface_property reset_input synchronousEdges NONE
set_interface_property reset_input ENABLED true
set_interface_property reset_input EXPORT_OF ""
set_interface_property reset_input PORT_NAME_MAP ""
set_interface_property reset_input CMSIS_SVD_VARIABLES ""
set_interface_property reset_input SVD_ADDRESS_GROUP ""

add_interface_port reset_input reset_input reset Input 1


#
# connection point reset_output
#
add_interface reset_output reset start
set_interface_property reset_output associatedClock clock
set_interface_property reset_output associatedDirectReset ""
set_interface_property reset_output associatedResetSinks reset_input
set_interface_property reset_output synchronousEdges DEASSERT
set_interface_property reset_output ENABLED true
set_interface_property reset_output EXPORT_OF ""
set_interface_property reset_output PORT_NAME_MAP ""
set_interface_property reset_output CMSIS_SVD_VARIABLES ""
set_interface_property reset_output SVD_ADDRESS_GROUP ""

add_interface_port reset_output reset_output reset Output 1


#
# connection point reset_output_delayed
#
add_interface reset_output_delayed reset start
set_interface_property reset_output_delayed associatedClock clock
set_interface_property reset_output_delayed associatedDirectReset ""
set_interface_property reset_output_delayed associatedResetSinks reset_input
set_interface_property reset_output_delayed synchronousEdges DEASSERT
set_interface_property reset_output_delayed ENABLED true
set_interface_property reset_output_delayed EXPORT_OF ""
set_interface_property reset_output_delayed PORT_NAME_MAP ""
set_interface_property reset_output_delayed CMSIS_SVD_VARIABLES ""
set_interface_property reset_output_delayed SVD_ADDRESS_GROUP ""

add_interface_port reset_output_delayed reset_output_delayed reset Output 1


proc elaborate {} {
       set clk_freq [ get_parameter_value CLOCK_FREQ ]
       if { $clk_freq == 0.0 } {
               set_parameter_value DURATION_TIME 0.0
               set_parameter_property DURATION_TIME VISIBLE false
               set_parameter_property DURATION_STRING VISIBLE true
       } else {
               set clk_period [ expr {1.0 / $clk_freq} ]
               set counter_width [ get_parameter_value DELAY_COUNTER_WIDTH ]
               set counter_count [ expr { 1 << $counter_width } ]
               set count_period [ expr {$clk_period * $counter_count} ]
               set duration [ expr {$count_period / 0.000000001} ]
               set round_duration [ expr {round($duration)} ]
               set_parameter_value DURATION_TIME $round_duration
               set_parameter_property DURATION_TIME VISIBLE true
               set_parameter_property DURATION_STRING VISIBLE false
       }
}

proc validate {} {
	set_module_assignment embeddedsw.CMacro.DELAY_COUNTER_WIDTH [ get_parameter_value DELAY_COUNTER_WIDTH ]
	set_module_assignment embeddedsw.CMacro.CLOCK_FREQ [ get_parameter_value CLOCK_FREQ ]
}

