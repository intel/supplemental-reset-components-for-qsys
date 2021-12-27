#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
package require -exact qsys 15.1


#
# module event_timer
#
set_module_property DESCRIPTION "Count the number of clocks required to acquire an event signal."
set_module_property NAME event_timer
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Reset Components"
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME event_timer
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
set_fileset_property QUARTUS_SYNTH TOP_LEVEL event_timer
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file event_timer.v VERILOG PATH event_timer.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL event_timer
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file event_timer.v VERILOG PATH event_timer.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL event_timer
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file event_timer.v VERILOG PATH event_timer.v


#
# parameters
#
add_parameter TIMEOUT_COUNTER_WIDTH INTEGER
set_parameter_property TIMEOUT_COUNTER_WIDTH DEFAULT_VALUE 16
set_parameter_property TIMEOUT_COUNTER_WIDTH DISPLAY_NAME "Timeout Counter Width"
set_parameter_property TIMEOUT_COUNTER_WIDTH TYPE INTEGER
set_parameter_property TIMEOUT_COUNTER_WIDTH GROUP "Timeout Counter"
set_parameter_property TIMEOUT_COUNTER_WIDTH UNITS Bits
set_parameter_property TIMEOUT_COUNTER_WIDTH ALLOWED_RANGES 2:32
set_parameter_property TIMEOUT_COUNTER_WIDTH DESCRIPTION "Determines the maximum duration in which the input event must be aquired."
set_parameter_property TIMEOUT_COUNTER_WIDTH HDL_PARAMETER true
set_parameter_property TIMEOUT_COUNTER_WIDTH AFFECTS_VALIDATION true
set_parameter_property TIMEOUT_COUNTER_WIDTH AFFECTS_ELABORATION true

add_parameter CLOCK_FREQ LONG
set_parameter_property CLOCK_FREQ DEFAULT_VALUE 0
set_parameter_property CLOCK_FREQ DISPLAY_NAME "Input clock rate"
set_parameter_property CLOCK_FREQ DESCRIPTION {Input clock rate from system.}
set_parameter_property CLOCK_FREQ UNITS None
set_parameter_property CLOCK_FREQ DERIVED true
set_parameter_property CLOCK_FREQ HDL_PARAMETER false
set_parameter_property CLOCK_FREQ VISIBLE false
set_parameter_property CLOCK_FREQ SYSTEM_INFO {CLOCK_RATE "event_clk"}
set_parameter_property CLOCK_FREQ AFFECTS_VALIDATION true
set_parameter_property CLOCK_FREQ AFFECTS_ELABORATION true

add_parameter DURATION_TIME FLOAT
set_parameter_property DURATION_TIME DEFAULT_VALUE "0.0"
set_parameter_property DURATION_TIME DISPLAY_NAME "Timeout Counter Duration"
set_parameter_property DURATION_TIME DESCRIPTION {Calculation of the timeout counter duration.  Clock input must be connected to a known frequency for calculation to appear.}
set_parameter_property DURATION_TIME UNITS Nanoseconds
set_parameter_property DURATION_TIME GROUP "Timeout Counter"
set_parameter_property DURATION_TIME DERIVED true
set_parameter_property DURATION_TIME HDL_PARAMETER false
set_parameter_property DURATION_TIME VISIBLE false

add_parameter DURATION_STRING STRING
set_parameter_property DURATION_STRING DEFAULT_VALUE "Unknown clock input frequency."
set_parameter_property DURATION_STRING DISPLAY_NAME "Timeout Counter Duration"
set_parameter_property DURATION_STRING DESCRIPTION {Calculation of the timeout counter duration.  Clock input must be connected to a known frequency for calculation to appear.}
set_parameter_property DURATION_STRING UNITS none
set_parameter_property DURATION_STRING GROUP "Timeout Counter"
set_parameter_property DURATION_STRING DERIVED true
set_parameter_property DURATION_STRING HDL_PARAMETER false
set_parameter_property DURATION_STRING VISIBLE false

add_parameter EVENT_INPUT_CONDUIT_ROLE STRING
set_parameter_property EVENT_INPUT_CONDUIT_ROLE DEFAULT_VALUE "event_input"
set_parameter_property EVENT_INPUT_CONDUIT_ROLE DISPLAY_NAME "Role of event_input conduit"
set_parameter_property EVENT_INPUT_CONDUIT_ROLE TYPE STRING
set_parameter_property EVENT_INPUT_CONDUIT_ROLE UNITS None
set_parameter_property EVENT_INPUT_CONDUIT_ROLE GROUP "Event Input"
set_parameter_property EVENT_INPUT_CONDUIT_ROLE DESCRIPTION "Enter the role that you want to assign the event_input conduit input."
set_parameter_property EVENT_INPUT_CONDUIT_ROLE HDL_PARAMETER false
set_parameter_property EVENT_INPUT_CONDUIT_ROLE AFFECTS_VALIDATION true
set_parameter_property EVENT_INPUT_CONDUIT_ROLE AFFECTS_ELABORATION true

add_parameter ENABLE_ACQUIRED_RESET INTEGER
set_parameter_property ENABLE_ACQUIRED_RESET DEFAULT_VALUE 0
set_parameter_property ENABLE_ACQUIRED_RESET DISPLAY_NAME "Enable acquired reset output"
set_parameter_property ENABLE_ACQUIRED_RESET TYPE INTEGER
set_parameter_property ENABLE_ACQUIRED_RESET UNITS None
set_parameter_property ENABLE_ACQUIRED_RESET GROUP "Acquired Output"
set_parameter_property ENABLE_ACQUIRED_RESET DISPLAY_HINT boolean
set_parameter_property ENABLE_ACQUIRED_RESET DESCRIPTION "Enable to use acquired reset output."
set_parameter_property ENABLE_ACQUIRED_RESET HDL_PARAMETER false
set_parameter_property ENABLE_ACQUIRED_RESET AFFECTS_VALIDATION true
set_parameter_property ENABLE_ACQUIRED_RESET AFFECTS_ELABORATION true

add_parameter ACQUIRED_RESET_ROLE INTEGER
set_parameter_property ACQUIRED_RESET_ROLE DEFAULT_VALUE 0
set_parameter_property ACQUIRED_RESET_ROLE DISPLAY_NAME "acquired reset polarity"
set_parameter_property ACQUIRED_RESET_ROLE TYPE INTEGER
set_parameter_property ACQUIRED_RESET_ROLE UNITS None
set_parameter_property ACQUIRED_RESET_ROLE GROUP "Acquired Output"
set_parameter_property ACQUIRED_RESET_ROLE DISPLAY_HINT none
set_parameter_property ACQUIRED_RESET_ROLE ALLOWED_RANGES "{0:active lo reset_n} {1:active hi reset}"
set_parameter_property ACQUIRED_RESET_ROLE DESCRIPTION "Set the polarity of the acquired reset interface.  NOTE: this does not change the behavior of the input signal, it only changes how Qsys interprets this signal."
set_parameter_property ACQUIRED_RESET_ROLE HDL_PARAMETER false
set_parameter_property ACQUIRED_RESET_ROLE AFFECTS_VALIDATION true
set_parameter_property ACQUIRED_RESET_ROLE AFFECTS_ELABORATION true

add_parameter ENABLE_ACQUIRED_CONDUIT INTEGER
set_parameter_property ENABLE_ACQUIRED_CONDUIT DEFAULT_VALUE 1
set_parameter_property ENABLE_ACQUIRED_CONDUIT DISPLAY_NAME "Enable acquired conduit output"
set_parameter_property ENABLE_ACQUIRED_CONDUIT TYPE INTEGER
set_parameter_property ENABLE_ACQUIRED_CONDUIT UNITS None
set_parameter_property ENABLE_ACQUIRED_CONDUIT GROUP "Acquired Output"
set_parameter_property ENABLE_ACQUIRED_CONDUIT DISPLAY_HINT boolean
set_parameter_property ENABLE_ACQUIRED_CONDUIT DESCRIPTION "Enable to use acquired conduit output."
set_parameter_property ENABLE_ACQUIRED_CONDUIT HDL_PARAMETER false
set_parameter_property ENABLE_ACQUIRED_CONDUIT AFFECTS_VALIDATION true
set_parameter_property ENABLE_ACQUIRED_CONDUIT AFFECTS_ELABORATION true

add_parameter ACQUIRED_CONDUIT_ROLE STRING
set_parameter_property ACQUIRED_CONDUIT_ROLE DEFAULT_VALUE "acquired"
set_parameter_property ACQUIRED_CONDUIT_ROLE DISPLAY_NAME "Role of acquired conduit"
set_parameter_property ACQUIRED_CONDUIT_ROLE TYPE STRING
set_parameter_property ACQUIRED_CONDUIT_ROLE UNITS None
set_parameter_property ACQUIRED_CONDUIT_ROLE GROUP "Acquired Output"
set_parameter_property ACQUIRED_CONDUIT_ROLE DESCRIPTION "Enter the role that you want to assign the acquired conduit output."
set_parameter_property ACQUIRED_CONDUIT_ROLE HDL_PARAMETER false
set_parameter_property ACQUIRED_CONDUIT_ROLE AFFECTS_VALIDATION true
set_parameter_property ACQUIRED_CONDUIT_ROLE AFFECTS_ELABORATION true

add_parameter ENABLE_LOST_RESET INTEGER
set_parameter_property ENABLE_LOST_RESET DEFAULT_VALUE 0
set_parameter_property ENABLE_LOST_RESET DISPLAY_NAME "Enable lost reset output"
set_parameter_property ENABLE_LOST_RESET TYPE INTEGER
set_parameter_property ENABLE_LOST_RESET UNITS None
set_parameter_property ENABLE_LOST_RESET GROUP "Lost Output"
set_parameter_property ENABLE_LOST_RESET DISPLAY_HINT boolean
set_parameter_property ENABLE_LOST_RESET DESCRIPTION "Enable to use lost reset output."
set_parameter_property ENABLE_LOST_RESET HDL_PARAMETER false
set_parameter_property ENABLE_LOST_RESET AFFECTS_VALIDATION true
set_parameter_property ENABLE_LOST_RESET AFFECTS_ELABORATION true

add_parameter LOST_RESET_ROLE INTEGER
set_parameter_property LOST_RESET_ROLE DEFAULT_VALUE 0
set_parameter_property LOST_RESET_ROLE DISPLAY_NAME "lost reset polarity"
set_parameter_property LOST_RESET_ROLE TYPE INTEGER
set_parameter_property LOST_RESET_ROLE UNITS None
set_parameter_property LOST_RESET_ROLE GROUP "Lost Output"
set_parameter_property LOST_RESET_ROLE DISPLAY_HINT none
set_parameter_property LOST_RESET_ROLE ALLOWED_RANGES "{0:active lo reset_n} {1:active hi reset}"
set_parameter_property LOST_RESET_ROLE DESCRIPTION "Set the polarity of the lost reset interface.  NOTE: this does not change the behavior of the output signal, it only changes how Qsys interprets this signal."
set_parameter_property LOST_RESET_ROLE HDL_PARAMETER false
set_parameter_property LOST_RESET_ROLE AFFECTS_VALIDATION true
set_parameter_property LOST_RESET_ROLE AFFECTS_ELABORATION true

add_parameter ENABLE_LOST_CONDUIT INTEGER
set_parameter_property ENABLE_LOST_CONDUIT DEFAULT_VALUE 1
set_parameter_property ENABLE_LOST_CONDUIT DISPLAY_NAME "Enable lost conduit output"
set_parameter_property ENABLE_LOST_CONDUIT TYPE INTEGER
set_parameter_property ENABLE_LOST_CONDUIT UNITS None
set_parameter_property ENABLE_LOST_CONDUIT GROUP "Lost Output"
set_parameter_property ENABLE_LOST_CONDUIT DISPLAY_HINT boolean
set_parameter_property ENABLE_LOST_CONDUIT DESCRIPTION "Enable to use lost conduit output."
set_parameter_property ENABLE_LOST_CONDUIT HDL_PARAMETER false
set_parameter_property ENABLE_LOST_CONDUIT AFFECTS_VALIDATION true
set_parameter_property ENABLE_LOST_CONDUIT AFFECTS_ELABORATION true

add_parameter LOST_CONDUIT_ROLE STRING
set_parameter_property LOST_CONDUIT_ROLE DEFAULT_VALUE "lost"
set_parameter_property LOST_CONDUIT_ROLE DISPLAY_NAME "Role of lost conduit"
set_parameter_property LOST_CONDUIT_ROLE TYPE STRING
set_parameter_property LOST_CONDUIT_ROLE UNITS None
set_parameter_property LOST_CONDUIT_ROLE GROUP "Lost Output"
set_parameter_property LOST_CONDUIT_ROLE DESCRIPTION "Enter the role that you want to assign the lost conduit output."
set_parameter_property LOST_CONDUIT_ROLE HDL_PARAMETER false
set_parameter_property LOST_CONDUIT_ROLE AFFECTS_VALIDATION true
set_parameter_property LOST_CONDUIT_ROLE AFFECTS_ELABORATION true

add_parameter ENABLE_TIMEOUT_RESET INTEGER
set_parameter_property ENABLE_TIMEOUT_RESET DEFAULT_VALUE 0
set_parameter_property ENABLE_TIMEOUT_RESET DISPLAY_NAME "Enable timeout reset output"
set_parameter_property ENABLE_TIMEOUT_RESET TYPE INTEGER
set_parameter_property ENABLE_TIMEOUT_RESET UNITS None
set_parameter_property ENABLE_TIMEOUT_RESET GROUP "Timeout Output"
set_parameter_property ENABLE_TIMEOUT_RESET DISPLAY_HINT boolean
set_parameter_property ENABLE_TIMEOUT_RESET DESCRIPTION "Enable to use timeout reset output."
set_parameter_property ENABLE_TIMEOUT_RESET HDL_PARAMETER false
set_parameter_property ENABLE_TIMEOUT_RESET AFFECTS_VALIDATION true
set_parameter_property ENABLE_TIMEOUT_RESET AFFECTS_ELABORATION true

add_parameter TIMEOUT_RESET_ROLE INTEGER
set_parameter_property TIMEOUT_RESET_ROLE DEFAULT_VALUE 0
set_parameter_property TIMEOUT_RESET_ROLE DISPLAY_NAME "timeout reset polarity"
set_parameter_property TIMEOUT_RESET_ROLE TYPE INTEGER
set_parameter_property TIMEOUT_RESET_ROLE UNITS None
set_parameter_property TIMEOUT_RESET_ROLE GROUP "Timeout Output"
set_parameter_property TIMEOUT_RESET_ROLE DISPLAY_HINT none
set_parameter_property TIMEOUT_RESET_ROLE ALLOWED_RANGES "{0:active lo reset_n} {1:active hi reset}"
set_parameter_property TIMEOUT_RESET_ROLE DESCRIPTION "Set the polarity of the timeout reset interface.  NOTE: this does not change the behavior of the output signal, it only changes how Qsys interprets this signal."
set_parameter_property TIMEOUT_RESET_ROLE HDL_PARAMETER false
set_parameter_property TIMEOUT_RESET_ROLE AFFECTS_VALIDATION true
set_parameter_property TIMEOUT_RESET_ROLE AFFECTS_ELABORATION true

add_parameter ENABLE_TIMEOUT_CONDUIT INTEGER
set_parameter_property ENABLE_TIMEOUT_CONDUIT DEFAULT_VALUE 1
set_parameter_property ENABLE_TIMEOUT_CONDUIT DISPLAY_NAME "Enable timeout conduit output"
set_parameter_property ENABLE_TIMEOUT_CONDUIT TYPE INTEGER
set_parameter_property ENABLE_TIMEOUT_CONDUIT UNITS None
set_parameter_property ENABLE_TIMEOUT_CONDUIT GROUP "Timeout Output"
set_parameter_property ENABLE_TIMEOUT_CONDUIT DISPLAY_HINT boolean
set_parameter_property ENABLE_TIMEOUT_CONDUIT DESCRIPTION "Enable to use timeout conduit output."
set_parameter_property ENABLE_TIMEOUT_CONDUIT HDL_PARAMETER false
set_parameter_property ENABLE_TIMEOUT_CONDUIT AFFECTS_VALIDATION true
set_parameter_property ENABLE_TIMEOUT_CONDUIT AFFECTS_ELABORATION true

add_parameter TIMEOUT_CONDUIT_ROLE STRING
set_parameter_property TIMEOUT_CONDUIT_ROLE DEFAULT_VALUE "timeout"
set_parameter_property TIMEOUT_CONDUIT_ROLE DISPLAY_NAME "Role of timeout conduit"
set_parameter_property TIMEOUT_CONDUIT_ROLE TYPE STRING
set_parameter_property TIMEOUT_CONDUIT_ROLE UNITS None
set_parameter_property TIMEOUT_CONDUIT_ROLE GROUP "Timeout Output"
set_parameter_property TIMEOUT_CONDUIT_ROLE DESCRIPTION "Enter the role that you want to assign the timeout conduit output."
set_parameter_property TIMEOUT_CONDUIT_ROLE HDL_PARAMETER false
set_parameter_property TIMEOUT_CONDUIT_ROLE AFFECTS_VALIDATION true
set_parameter_property TIMEOUT_CONDUIT_ROLE AFFECTS_ELABORATION true


#
# display items
#


#
# connection point event_clk
#
add_interface event_clk clock end
set_interface_property event_clk clockRate 0
set_interface_property event_clk ENABLED true
set_interface_property event_clk EXPORT_OF ""
set_interface_property event_clk PORT_NAME_MAP ""
set_interface_property event_clk CMSIS_SVD_VARIABLES ""
set_interface_property event_clk SVD_ADDRESS_GROUP ""

add_interface_port event_clk event_clk clk Input 1


#
# connection point event_reset
#
add_interface event_reset reset end
set_interface_property event_reset associatedClock event_clk
set_interface_property event_reset synchronousEdges DEASSERT
set_interface_property event_reset ENABLED true
set_interface_property event_reset EXPORT_OF ""
set_interface_property event_reset PORT_NAME_MAP ""
set_interface_property event_reset CMSIS_SVD_VARIABLES ""
set_interface_property event_reset SVD_ADDRESS_GROUP ""

add_interface_port event_reset event_reset reset Input 1


#
# connection point event_input
#
add_interface event_input conduit end
set_interface_property event_input associatedClock ""
set_interface_property event_input associatedReset ""
set_interface_property event_input ENABLED true
set_interface_property event_input EXPORT_OF ""
set_interface_property event_input PORT_NAME_MAP ""
set_interface_property event_input CMSIS_SVD_VARIABLES ""
set_interface_property event_input SVD_ADDRESS_GROUP ""

add_interface_port event_input event_input event_input Input 1


#
# connection point acquired
#
add_interface acquired conduit end
set_interface_property acquired associatedClock ""
set_interface_property acquired associatedReset ""
set_interface_property acquired ENABLED true
set_interface_property acquired EXPORT_OF ""
set_interface_property acquired PORT_NAME_MAP ""
set_interface_property acquired CMSIS_SVD_VARIABLES ""
set_interface_property acquired SVD_ADDRESS_GROUP ""

add_interface_port acquired acquired acquired Output 1


#
# connection point acquired_reset
#
add_interface acquired_reset reset start
set_interface_property acquired_reset associatedClock ""
set_interface_property acquired_reset associatedDirectReset ""
set_interface_property acquired_reset associatedResetSinks none
set_interface_property acquired_reset synchronousEdges NONE
set_interface_property acquired_reset ENABLED true
set_interface_property acquired_reset EXPORT_OF ""
set_interface_property acquired_reset PORT_NAME_MAP ""
set_interface_property acquired_reset CMSIS_SVD_VARIABLES ""
set_interface_property acquired_reset SVD_ADDRESS_GROUP ""

add_interface_port acquired_reset acquired_reset reset Output 1


#
# connection point lost
#
add_interface lost conduit end
set_interface_property lost associatedClock ""
set_interface_property lost associatedReset ""
set_interface_property lost ENABLED true
set_interface_property lost EXPORT_OF ""
set_interface_property lost PORT_NAME_MAP ""
set_interface_property lost CMSIS_SVD_VARIABLES ""
set_interface_property lost SVD_ADDRESS_GROUP ""

add_interface_port lost lost lost Output 1


#
# connection point lost_reset
#
add_interface lost_reset reset start
set_interface_property lost_reset associatedClock ""
set_interface_property lost_reset associatedDirectReset ""
set_interface_property lost_reset associatedResetSinks none
set_interface_property lost_reset synchronousEdges NONE
set_interface_property lost_reset ENABLED true
set_interface_property lost_reset EXPORT_OF ""
set_interface_property lost_reset PORT_NAME_MAP ""
set_interface_property lost_reset CMSIS_SVD_VARIABLES ""
set_interface_property lost_reset SVD_ADDRESS_GROUP ""

add_interface_port lost_reset lost_reset reset Output 1


#
# connection point timeout
#
add_interface timeout conduit end
set_interface_property timeout associatedClock ""
set_interface_property timeout associatedReset ""
set_interface_property timeout ENABLED true
set_interface_property timeout EXPORT_OF ""
set_interface_property timeout PORT_NAME_MAP ""
set_interface_property timeout CMSIS_SVD_VARIABLES ""
set_interface_property timeout SVD_ADDRESS_GROUP ""

add_interface_port timeout timeout timeout Output 1


#
# connection point timeout_reset
#
add_interface timeout_reset reset start
set_interface_property timeout_reset associatedClock ""
set_interface_property timeout_reset associatedDirectReset ""
set_interface_property timeout_reset associatedResetSinks none
set_interface_property timeout_reset synchronousEdges NONE
set_interface_property timeout_reset ENABLED true
set_interface_property timeout_reset EXPORT_OF ""
set_interface_property timeout_reset PORT_NAME_MAP ""
set_interface_property timeout_reset CMSIS_SVD_VARIABLES ""
set_interface_property timeout_reset SVD_ADDRESS_GROUP ""

add_interface_port timeout_reset timeout_reset reset Output 1


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


proc elaborate {} {
	set clk_freq [ get_parameter_value CLOCK_FREQ ]
	if { $clk_freq == 0.0 } {
		set_parameter_value DURATION_TIME 0.0
		set_parameter_property DURATION_TIME VISIBLE false
		set_parameter_property DURATION_STRING VISIBLE true
	} else {
		set clk_period [ expr {1.0 / $clk_freq} ]
		set counter_width [ get_parameter_value TIMEOUT_COUNTER_WIDTH ]
		set counter_count [ expr { 1 << $counter_width } ]
		set count_period [ expr {$clk_period * $counter_count} ]
		set duration [ expr {$count_period / 0.000000001} ]
		set round_duration [ expr {round($duration)} ]
		set_parameter_value DURATION_TIME $round_duration
		set_parameter_property DURATION_TIME VISIBLE true
		set_parameter_property DURATION_STRING VISIBLE false
	}

	# set input conduit role from GUI entry
	set_port_property event_input ROLE [ get_parameter_value EVENT_INPUT_CONDUIT_ROLE ]

	# enable output conduits and set roles
	if {[ get_parameter_value ENABLE_ACQUIRED_CONDUIT ] != 0} {
		set_interface_property acquired ENABLED true
		set_parameter_property ACQUIRED_CONDUIT_ROLE ENABLED true
		set_port_property acquired ROLE [ get_parameter_value ACQUIRED_CONDUIT_ROLE ]
	} else {
		set_interface_property acquired ENABLED false
		set_parameter_property ACQUIRED_CONDUIT_ROLE ENABLED false
	}

	if {[ get_parameter_value ENABLE_LOST_CONDUIT ] != 0} {
		set_interface_property lost ENABLED true
		set_parameter_property LOST_CONDUIT_ROLE ENABLED true
		set_port_property lost ROLE [ get_parameter_value LOST_CONDUIT_ROLE ]
	} else {
		set_interface_property lost ENABLED false
		set_parameter_property LOST_CONDUIT_ROLE ENABLED false
	}

	if {[ get_parameter_value ENABLE_TIMEOUT_CONDUIT ] != 0} {
		set_interface_property timeout ENABLED true
		set_parameter_property TIMEOUT_CONDUIT_ROLE ENABLED true
		set_port_property timeout ROLE [ get_parameter_value TIMEOUT_CONDUIT_ROLE ]
	} else {
		set_interface_property timeout ENABLED false
		set_parameter_property TIMEOUT_CONDUIT_ROLE ENABLED false
	}

	# enable output resets and set roles
	if {[ get_parameter_value ENABLE_ACQUIRED_RESET ] != 0} {
		set_interface_property acquired_reset ENABLED true
		set_parameter_property ACQUIRED_RESET_ROLE ENABLED true
		set_port_property acquired_reset ROLE [ expr {[ get_parameter_value ACQUIRED_RESET_ROLE ] ? "reset" : "reset_n"} ]
	} else {
		set_interface_property acquired_reset ENABLED false
		set_parameter_property ACQUIRED_RESET_ROLE ENABLED false
	}

	if {[ get_parameter_value ENABLE_LOST_RESET ] != 0} {
		set_interface_property lost_reset ENABLED true
		set_parameter_property LOST_RESET_ROLE ENABLED true
		set_port_property lost_reset ROLE [ expr {[ get_parameter_value LOST_RESET_ROLE ] ? "reset" : "reset_n"} ]
	} else {
		set_interface_property lost_reset ENABLED false
		set_parameter_property LOST_RESET_ROLE ENABLED false
	}

	if {[ get_parameter_value ENABLE_TIMEOUT_RESET ] != 0} {
		set_interface_property timeout_reset ENABLED true
		set_parameter_property TIMEOUT_RESET_ROLE ENABLED true
		set_port_property timeout_reset ROLE [ expr {[ get_parameter_value TIMEOUT_RESET_ROLE ] ? "reset" : "reset_n"} ]
	} else {
		set_interface_property timeout_reset ENABLED false
		set_parameter_property TIMEOUT_RESET_ROLE ENABLED false
	}

}

proc validate {} {
	set_module_assignment embeddedsw.CMacro.TIMEOUT_COUNTER_WIDTH [ get_parameter_value TIMEOUT_COUNTER_WIDTH ]
	set_module_assignment embeddedsw.CMacro.CLOCK_FREQ [ get_parameter_value CLOCK_FREQ ]
	set_module_assignment embeddedsw.CMacro.ENABLE_ACQUIRED_RESET [ get_parameter_value ENABLE_ACQUIRED_RESET ]
	set_module_assignment embeddedsw.CMacro.ENABLE_ACQUIRED_CONDUIT [ get_parameter_value ENABLE_ACQUIRED_CONDUIT ]
	set_module_assignment embeddedsw.CMacro.ENABLE_LOST_RESET [ get_parameter_value ENABLE_LOST_RESET ]
	set_module_assignment embeddedsw.CMacro.ENABLE_LOST_CONDUIT [ get_parameter_value ENABLE_LOST_CONDUIT ]
	set_module_assignment embeddedsw.CMacro.ENABLE_TIMEOUT_RESET [ get_parameter_value ENABLE_TIMEOUT_RESET ]
	set_module_assignment embeddedsw.CMacro.ENABLE_TIMEOUT_CONDUIT [ get_parameter_value ENABLE_TIMEOUT_CONDUIT ]
}

