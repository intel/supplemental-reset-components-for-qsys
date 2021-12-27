#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
package require -exact qsys 15.1


#
# module pll_reset_monitor
#
set_module_property DESCRIPTION "Reset and monitor PLL."
set_module_property NAME pll_reset_monitor
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Reset Components"
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME pll_reset_monitor
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
set_fileset_property QUARTUS_SYNTH TOP_LEVEL pll_reset_monitor
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file pll_reset_monitor.v VERILOG PATH pll_reset_monitor.v TOP_LEVEL_FILE
add_fileset_file pll_reset_monitor.sdc SDC PATH pll_reset_monitor.sdc

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL pll_reset_monitor
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file pll_reset_monitor.v VERILOG PATH pll_reset_monitor.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL pll_reset_monitor
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file pll_reset_monitor.v VERILOG PATH pll_reset_monitor.v


#
# parameters
#
add_parameter RESET_COUNTER_WIDTH INTEGER
set_parameter_property RESET_COUNTER_WIDTH DEFAULT_VALUE 10
set_parameter_property RESET_COUNTER_WIDTH DISPLAY_NAME "Reset Counter Width"
set_parameter_property RESET_COUNTER_WIDTH TYPE INTEGER
set_parameter_property RESET_COUNTER_WIDTH GROUP "Reset Counter"
set_parameter_property RESET_COUNTER_WIDTH UNITS Bits
set_parameter_property RESET_COUNTER_WIDTH ALLOWED_RANGES 2:16
set_parameter_property RESET_COUNTER_WIDTH DESCRIPTION "Determines the duration of the PLL reset assertion."
set_parameter_property RESET_COUNTER_WIDTH HDL_PARAMETER true
set_parameter_property RESET_COUNTER_WIDTH AFFECTS_VALIDATION true
set_parameter_property RESET_COUNTER_WIDTH AFFECTS_ELABORATION true

add_parameter LOCK_COUNTER_WIDTH INTEGER
set_parameter_property LOCK_COUNTER_WIDTH DEFAULT_VALUE 16
set_parameter_property LOCK_COUNTER_WIDTH DISPLAY_NAME "Lock Counter Width"
set_parameter_property LOCK_COUNTER_WIDTH TYPE INTEGER
set_parameter_property LOCK_COUNTER_WIDTH GROUP "Lock Counter"
set_parameter_property LOCK_COUNTER_WIDTH UNITS Bits
set_parameter_property LOCK_COUNTER_WIDTH ALLOWED_RANGES 2:19
set_parameter_property LOCK_COUNTER_WIDTH DESCRIPTION "Determines the duration in which PLL lock must be aquired."
set_parameter_property LOCK_COUNTER_WIDTH HDL_PARAMETER true
set_parameter_property LOCK_COUNTER_WIDTH AFFECTS_VALIDATION true
set_parameter_property LOCK_COUNTER_WIDTH AFFECTS_ELABORATION true

add_parameter CLOCK_FREQ LONG
set_parameter_property CLOCK_FREQ DEFAULT_VALUE 0
set_parameter_property CLOCK_FREQ DISPLAY_NAME "Input clock rate"
set_parameter_property CLOCK_FREQ DESCRIPTION {Input clock rate from system.}
set_parameter_property CLOCK_FREQ UNITS None
set_parameter_property CLOCK_FREQ DERIVED true
set_parameter_property CLOCK_FREQ HDL_PARAMETER false
set_parameter_property CLOCK_FREQ VISIBLE false
set_parameter_property CLOCK_FREQ SYSTEM_INFO {CLOCK_RATE "pll_ref_clk"}
set_parameter_property CLOCK_FREQ AFFECTS_VALIDATION true
set_parameter_property CLOCK_FREQ AFFECTS_ELABORATION true

add_parameter RESET_DURATION_TIME FLOAT
set_parameter_property RESET_DURATION_TIME DEFAULT_VALUE "0.0"
set_parameter_property RESET_DURATION_TIME DISPLAY_NAME "Reset Counter Duration"
set_parameter_property RESET_DURATION_TIME DESCRIPTION {Calculation of the reset counter duration.  Clock input must be connected to a known frequency for calculation to appear.}
set_parameter_property RESET_DURATION_TIME UNITS Nanoseconds
set_parameter_property RESET_DURATION_TIME GROUP "Reset Counter"
set_parameter_property RESET_DURATION_TIME DERIVED true
set_parameter_property RESET_DURATION_TIME HDL_PARAMETER false
set_parameter_property RESET_DURATION_TIME VISIBLE false

add_parameter RESET_DURATION_STRING STRING
set_parameter_property RESET_DURATION_STRING DEFAULT_VALUE "Unknown clock input frequency."
set_parameter_property RESET_DURATION_STRING DISPLAY_NAME "Reset Counter Duration"
set_parameter_property RESET_DURATION_STRING DESCRIPTION {Calculation of the reset counter duration.  Clock input must be connected to a known frequency for calculation to appear.}
set_parameter_property RESET_DURATION_STRING UNITS none
set_parameter_property RESET_DURATION_STRING GROUP "Reset Counter"
set_parameter_property RESET_DURATION_STRING DERIVED true
set_parameter_property RESET_DURATION_STRING HDL_PARAMETER false
set_parameter_property RESET_DURATION_STRING VISIBLE false

add_parameter LOCK_DURATION_TIME FLOAT
set_parameter_property LOCK_DURATION_TIME DEFAULT_VALUE "0.0"
set_parameter_property LOCK_DURATION_TIME DISPLAY_NAME "Lock Counter Duration"
set_parameter_property LOCK_DURATION_TIME DESCRIPTION {Calculation of the lock counter duration.  Clock input must be connected to a known frequency for calculation to appear.}
set_parameter_property LOCK_DURATION_TIME UNITS Nanoseconds
set_parameter_property LOCK_DURATION_TIME GROUP "Lock Counter"
set_parameter_property LOCK_DURATION_TIME DERIVED true
set_parameter_property LOCK_DURATION_TIME HDL_PARAMETER false
set_parameter_property LOCK_DURATION_TIME VISIBLE false

add_parameter LOCK_DURATION_STRING STRING
set_parameter_property LOCK_DURATION_STRING DEFAULT_VALUE "Unknown clock input frequency."
set_parameter_property LOCK_DURATION_STRING DISPLAY_NAME "Lock Counter Duration"
set_parameter_property LOCK_DURATION_STRING DESCRIPTION {Calculation of the lock counter duration.  Clock input must be connected to a known frequency for calculation to appear.}
set_parameter_property LOCK_DURATION_STRING UNITS none
set_parameter_property LOCK_DURATION_STRING GROUP "Lock Counter"
set_parameter_property LOCK_DURATION_STRING DERIVED true
set_parameter_property LOCK_DURATION_STRING HDL_PARAMETER false
set_parameter_property LOCK_DURATION_STRING VISIBLE false

add_parameter PLL_LOCKED_CONDUIT_ROLE STRING
set_parameter_property PLL_LOCKED_CONDUIT_ROLE DEFAULT_VALUE "pll_locked"
set_parameter_property PLL_LOCKED_CONDUIT_ROLE DISPLAY_NAME "Role of pll_locked conduit"
set_parameter_property PLL_LOCKED_CONDUIT_ROLE TYPE STRING
set_parameter_property PLL_LOCKED_CONDUIT_ROLE UNITS None
set_parameter_property PLL_LOCKED_CONDUIT_ROLE GROUP "PLL Locked Input"
set_parameter_property PLL_LOCKED_CONDUIT_ROLE DESCRIPTION "Enter the role that you want to assign the pll_locked conduit input."
set_parameter_property PLL_LOCKED_CONDUIT_ROLE HDL_PARAMETER false
set_parameter_property PLL_LOCKED_CONDUIT_ROLE AFFECTS_VALIDATION true
set_parameter_property PLL_LOCKED_CONDUIT_ROLE AFFECTS_ELABORATION true

add_parameter ENABLE_LOCK_SUCCESS_RESET INTEGER
set_parameter_property ENABLE_LOCK_SUCCESS_RESET DEFAULT_VALUE 0
set_parameter_property ENABLE_LOCK_SUCCESS_RESET DISPLAY_NAME "Enable lock_success reset output"
set_parameter_property ENABLE_LOCK_SUCCESS_RESET TYPE INTEGER
set_parameter_property ENABLE_LOCK_SUCCESS_RESET UNITS None
set_parameter_property ENABLE_LOCK_SUCCESS_RESET GROUP "Lock Success Output"
set_parameter_property ENABLE_LOCK_SUCCESS_RESET DISPLAY_HINT boolean
set_parameter_property ENABLE_LOCK_SUCCESS_RESET DESCRIPTION "Enable to use lock_success reset output."
set_parameter_property ENABLE_LOCK_SUCCESS_RESET HDL_PARAMETER false
set_parameter_property ENABLE_LOCK_SUCCESS_RESET AFFECTS_VALIDATION true
set_parameter_property ENABLE_LOCK_SUCCESS_RESET AFFECTS_ELABORATION true

add_parameter LOCK_SUCCESS_RESET_ROLE INTEGER
set_parameter_property LOCK_SUCCESS_RESET_ROLE DEFAULT_VALUE 0
set_parameter_property LOCK_SUCCESS_RESET_ROLE DISPLAY_NAME "lock_success reset polarity"
set_parameter_property LOCK_SUCCESS_RESET_ROLE TYPE INTEGER
set_parameter_property LOCK_SUCCESS_RESET_ROLE UNITS None
set_parameter_property LOCK_SUCCESS_RESET_ROLE GROUP "Lock Success Output"
set_parameter_property LOCK_SUCCESS_RESET_ROLE DISPLAY_HINT none
set_parameter_property LOCK_SUCCESS_RESET_ROLE ALLOWED_RANGES "{0:active lo reset_n} {1:active hi reset}"
set_parameter_property LOCK_SUCCESS_RESET_ROLE DESCRIPTION "Set the polarity of the lock_success reset interface.  NOTE: this does not change the behavior of the output signal, it only changes how Qsys interprets this signal."
set_parameter_property LOCK_SUCCESS_RESET_ROLE HDL_PARAMETER false
set_parameter_property LOCK_SUCCESS_RESET_ROLE AFFECTS_VALIDATION true
set_parameter_property LOCK_SUCCESS_RESET_ROLE AFFECTS_ELABORATION true

add_parameter ENABLE_LOCK_SUCCESS_CONDUIT INTEGER
set_parameter_property ENABLE_LOCK_SUCCESS_CONDUIT DEFAULT_VALUE 1
set_parameter_property ENABLE_LOCK_SUCCESS_CONDUIT DISPLAY_NAME "Enable lock_success conduit output"
set_parameter_property ENABLE_LOCK_SUCCESS_CONDUIT TYPE INTEGER
set_parameter_property ENABLE_LOCK_SUCCESS_CONDUIT UNITS None
set_parameter_property ENABLE_LOCK_SUCCESS_CONDUIT GROUP "Lock Success Output"
set_parameter_property ENABLE_LOCK_SUCCESS_CONDUIT DISPLAY_HINT boolean
set_parameter_property ENABLE_LOCK_SUCCESS_CONDUIT DESCRIPTION "Enable to use lock_success conduit output."
set_parameter_property ENABLE_LOCK_SUCCESS_CONDUIT HDL_PARAMETER false
set_parameter_property ENABLE_LOCK_SUCCESS_CONDUIT AFFECTS_VALIDATION true
set_parameter_property ENABLE_LOCK_SUCCESS_CONDUIT AFFECTS_ELABORATION true

add_parameter LOCK_SUCCESS_CONDUIT_ROLE STRING
set_parameter_property LOCK_SUCCESS_CONDUIT_ROLE DEFAULT_VALUE "lock_success"
set_parameter_property LOCK_SUCCESS_CONDUIT_ROLE DISPLAY_NAME "Role of lock_success conduit"
set_parameter_property LOCK_SUCCESS_CONDUIT_ROLE TYPE STRING
set_parameter_property LOCK_SUCCESS_CONDUIT_ROLE UNITS None
set_parameter_property LOCK_SUCCESS_CONDUIT_ROLE GROUP "Lock Success Output"
set_parameter_property LOCK_SUCCESS_CONDUIT_ROLE DESCRIPTION "Enter the role that you want to assign the lock_success conduit output."
set_parameter_property LOCK_SUCCESS_CONDUIT_ROLE HDL_PARAMETER false
set_parameter_property LOCK_SUCCESS_CONDUIT_ROLE AFFECTS_VALIDATION true
set_parameter_property LOCK_SUCCESS_CONDUIT_ROLE AFFECTS_ELABORATION true

add_parameter ENABLE_LOCK_FAILURE_RESET INTEGER
set_parameter_property ENABLE_LOCK_FAILURE_RESET DEFAULT_VALUE 0
set_parameter_property ENABLE_LOCK_FAILURE_RESET DISPLAY_NAME "Enable lock_failure reset output"
set_parameter_property ENABLE_LOCK_FAILURE_RESET TYPE INTEGER
set_parameter_property ENABLE_LOCK_FAILURE_RESET UNITS None
set_parameter_property ENABLE_LOCK_FAILURE_RESET GROUP "Lock Failure Output"
set_parameter_property ENABLE_LOCK_FAILURE_RESET DISPLAY_HINT boolean
set_parameter_property ENABLE_LOCK_FAILURE_RESET DESCRIPTION "Enable to use lock_failure reset output."
set_parameter_property ENABLE_LOCK_FAILURE_RESET HDL_PARAMETER false
set_parameter_property ENABLE_LOCK_FAILURE_RESET AFFECTS_VALIDATION true
set_parameter_property ENABLE_LOCK_FAILURE_RESET AFFECTS_ELABORATION true

add_parameter LOCK_FAILURE_RESET_ROLE INTEGER
set_parameter_property LOCK_FAILURE_RESET_ROLE DEFAULT_VALUE 0
set_parameter_property LOCK_FAILURE_RESET_ROLE DISPLAY_NAME "lock_failure reset polarity"
set_parameter_property LOCK_FAILURE_RESET_ROLE TYPE INTEGER
set_parameter_property LOCK_FAILURE_RESET_ROLE UNITS None
set_parameter_property LOCK_FAILURE_RESET_ROLE GROUP "Lock Failure Output"
set_parameter_property LOCK_FAILURE_RESET_ROLE DISPLAY_HINT none
set_parameter_property LOCK_FAILURE_RESET_ROLE ALLOWED_RANGES "{0:active lo reset_n} {1:active hi reset}"
set_parameter_property LOCK_FAILURE_RESET_ROLE DESCRIPTION "Set the polarity of the lock_failure reset interface.  NOTE: this does not change the behavior of the output signal, it only changes how Qsys interprets this signal."
set_parameter_property LOCK_FAILURE_RESET_ROLE HDL_PARAMETER false
set_parameter_property LOCK_FAILURE_RESET_ROLE AFFECTS_VALIDATION true
set_parameter_property LOCK_FAILURE_RESET_ROLE AFFECTS_ELABORATION true

add_parameter ENABLE_LOCK_FAILURE_CONDUIT INTEGER
set_parameter_property ENABLE_LOCK_FAILURE_CONDUIT DEFAULT_VALUE 1
set_parameter_property ENABLE_LOCK_FAILURE_CONDUIT DISPLAY_NAME "Enable lock_failure conduit output"
set_parameter_property ENABLE_LOCK_FAILURE_CONDUIT TYPE INTEGER
set_parameter_property ENABLE_LOCK_FAILURE_CONDUIT UNITS None
set_parameter_property ENABLE_LOCK_FAILURE_CONDUIT GROUP "Lock Failure Output"
set_parameter_property ENABLE_LOCK_FAILURE_CONDUIT DISPLAY_HINT boolean
set_parameter_property ENABLE_LOCK_FAILURE_CONDUIT DESCRIPTION "Enable to use lock_failure conduit output."
set_parameter_property ENABLE_LOCK_FAILURE_CONDUIT HDL_PARAMETER false
set_parameter_property ENABLE_LOCK_FAILURE_CONDUIT AFFECTS_VALIDATION true
set_parameter_property ENABLE_LOCK_FAILURE_CONDUIT AFFECTS_ELABORATION true

add_parameter LOCK_FAILURE_CONDUIT_ROLE STRING
set_parameter_property LOCK_FAILURE_CONDUIT_ROLE DEFAULT_VALUE "lock_failure"
set_parameter_property LOCK_FAILURE_CONDUIT_ROLE DISPLAY_NAME "Role of lock_failure conduit"
set_parameter_property LOCK_FAILURE_CONDUIT_ROLE TYPE STRING
set_parameter_property LOCK_FAILURE_CONDUIT_ROLE UNITS None
set_parameter_property LOCK_FAILURE_CONDUIT_ROLE GROUP "Lock Failure Output"
set_parameter_property LOCK_FAILURE_CONDUIT_ROLE DESCRIPTION "Enter the role that you want to assign the lock_failure conduit output."
set_parameter_property LOCK_FAILURE_CONDUIT_ROLE HDL_PARAMETER false
set_parameter_property LOCK_FAILURE_CONDUIT_ROLE AFFECTS_VALIDATION true
set_parameter_property LOCK_FAILURE_CONDUIT_ROLE AFFECTS_ELABORATION true


#
# display items
#


#
# connection point pll_ref_clk
#
add_interface pll_ref_clk clock end
set_interface_property pll_ref_clk clockRate 0
set_interface_property pll_ref_clk ENABLED true
set_interface_property pll_ref_clk EXPORT_OF ""
set_interface_property pll_ref_clk PORT_NAME_MAP ""
set_interface_property pll_ref_clk CMSIS_SVD_VARIABLES ""
set_interface_property pll_ref_clk SVD_ADDRESS_GROUP ""

add_interface_port pll_ref_clk pll_ref_clk clk Input 1

#
# connection point pll_reset_request
#
add_interface pll_reset_request reset end
set_interface_property pll_reset_request associatedClock ""
set_interface_property pll_reset_request synchronousEdges NONE
set_interface_property pll_reset_request ENABLED true
set_interface_property pll_reset_request EXPORT_OF ""
set_interface_property pll_reset_request PORT_NAME_MAP ""
set_interface_property pll_reset_request CMSIS_SVD_VARIABLES ""
set_interface_property pll_reset_request SVD_ADDRESS_GROUP ""

add_interface_port pll_reset_request pll_reset_request reset Input 1


#
# connection point pll_locked
#
add_interface pll_locked conduit end
set_interface_property pll_locked associatedClock ""
set_interface_property pll_locked associatedReset ""
set_interface_property pll_locked ENABLED true
set_interface_property pll_locked EXPORT_OF ""
set_interface_property pll_locked PORT_NAME_MAP ""
set_interface_property pll_locked CMSIS_SVD_VARIABLES ""
set_interface_property pll_locked SVD_ADDRESS_GROUP ""

add_interface_port pll_locked pll_locked pll_locked Input 1


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

add_interface_port s0 s0_readdata readdata Output 32
add_interface_port s0 s0_read read Input 1
set_interface_assignment s0 embeddedsw.configuration.isFlash 0
set_interface_assignment s0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s0 embeddedsw.configuration.isPrintableDevice 0


#
# connection point pll_reset
#
add_interface pll_reset reset start
set_interface_property pll_reset associatedClock pll_ref_clk
set_interface_property pll_reset associatedDirectReset ""
set_interface_property pll_reset associatedResetSinks pll_reset_request
set_interface_property pll_reset synchronousEdges DEASSERT
set_interface_property pll_reset ENABLED true
set_interface_property pll_reset EXPORT_OF ""
set_interface_property pll_reset PORT_NAME_MAP ""
set_interface_property pll_reset CMSIS_SVD_VARIABLES ""
set_interface_property pll_reset SVD_ADDRESS_GROUP ""

add_interface_port pll_reset pll_reset reset Output 1


#
# connection point lock_success
#
add_interface lock_success conduit end
set_interface_property lock_success associatedClock ""
set_interface_property lock_success associatedReset ""
set_interface_property lock_success ENABLED true
set_interface_property lock_success EXPORT_OF ""
set_interface_property lock_success PORT_NAME_MAP ""
set_interface_property lock_success CMSIS_SVD_VARIABLES ""
set_interface_property lock_success SVD_ADDRESS_GROUP ""

add_interface_port lock_success lock_success lock_success Output 1


#
# connection point lock_success_reset
#
add_interface lock_success_reset reset start
set_interface_property lock_success_reset associatedClock ""
set_interface_property lock_success_reset associatedDirectReset ""
set_interface_property lock_success_reset associatedResetSinks none
set_interface_property lock_success_reset synchronousEdges NONE
set_interface_property lock_success_reset ENABLED true
set_interface_property lock_success_reset EXPORT_OF ""
set_interface_property lock_success_reset PORT_NAME_MAP ""
set_interface_property lock_success_reset CMSIS_SVD_VARIABLES ""
set_interface_property lock_success_reset SVD_ADDRESS_GROUP ""

add_interface_port lock_success_reset lock_success_reset reset Output 1


#
# connection point lock_failure
#
add_interface lock_failure conduit end
set_interface_property lock_failure associatedClock ""
set_interface_property lock_failure associatedReset ""
set_interface_property lock_failure ENABLED true
set_interface_property lock_failure EXPORT_OF ""
set_interface_property lock_failure PORT_NAME_MAP ""
set_interface_property lock_failure CMSIS_SVD_VARIABLES ""
set_interface_property lock_failure SVD_ADDRESS_GROUP ""

add_interface_port lock_failure lock_failure lock_failure Output 1


#
# connection point lock_failure_reset
#
add_interface lock_failure_reset reset start
set_interface_property lock_failure_reset associatedClock ""
set_interface_property lock_failure_reset associatedDirectReset ""
set_interface_property lock_failure_reset associatedResetSinks none
set_interface_property lock_failure_reset synchronousEdges NONE
set_interface_property lock_failure_reset ENABLED true
set_interface_property lock_failure_reset EXPORT_OF ""
set_interface_property lock_failure_reset PORT_NAME_MAP ""
set_interface_property lock_failure_reset CMSIS_SVD_VARIABLES ""
set_interface_property lock_failure_reset SVD_ADDRESS_GROUP ""

add_interface_port lock_failure_reset lock_failure_reset reset Output 1


proc elaborate {} {
       set clk_freq [ get_parameter_value CLOCK_FREQ ]
       if { $clk_freq == 0.0 } {
               set_parameter_value RESET_DURATION_TIME 0.0
               set_parameter_property RESET_DURATION_TIME VISIBLE false
               set_parameter_property RESET_DURATION_STRING VISIBLE true
               set_parameter_value LOCK_DURATION_TIME 0.0
               set_parameter_property LOCK_DURATION_TIME VISIBLE false
               set_parameter_property LOCK_DURATION_STRING VISIBLE true
       } else {
               set clk_period [ expr {1.0 / $clk_freq} ]

               set counter_width [ get_parameter_value RESET_COUNTER_WIDTH ]
               set counter_count [ expr { 1 << $counter_width } ]
               set count_period [ expr {$clk_period * $counter_count} ]
               set duration [ expr {$count_period / 0.000000001} ]
               set round_duration [ expr {round($duration)} ]
               set_parameter_value RESET_DURATION_TIME $round_duration
               set_parameter_property RESET_DURATION_TIME VISIBLE true
               set_parameter_property RESET_DURATION_STRING VISIBLE false

               set counter_width [ get_parameter_value LOCK_COUNTER_WIDTH ]
               set counter_count [ expr { 1 << $counter_width } ]
               set count_period [ expr {$clk_period * $counter_count} ]
               set duration [ expr {$count_period / 0.000000001} ]
               set round_duration [ expr {round($duration)} ]
               set_parameter_value LOCK_DURATION_TIME $round_duration
               set_parameter_property LOCK_DURATION_TIME VISIBLE true
               set_parameter_property LOCK_DURATION_STRING VISIBLE false
       }

	# set input conduit role from GUI entry
	set_port_property pll_locked ROLE [ get_parameter_value PLL_LOCKED_CONDUIT_ROLE ]

	# enable output conduits and set roles
	if {[ get_parameter_value ENABLE_LOCK_SUCCESS_CONDUIT ] != 0} {
		set_interface_property lock_success ENABLED true
		set_parameter_property LOCK_SUCCESS_CONDUIT_ROLE ENABLED true
		set_port_property lock_success ROLE [ get_parameter_value LOCK_SUCCESS_CONDUIT_ROLE ]
	} else {
		set_interface_property lock_success ENABLED false
		set_parameter_property LOCK_SUCCESS_CONDUIT_ROLE ENABLED false
	}

	if {[ get_parameter_value ENABLE_LOCK_FAILURE_CONDUIT ] != 0} {
		set_interface_property lock_failure ENABLED true
		set_parameter_property LOCK_FAILURE_CONDUIT_ROLE ENABLED true
		set_port_property lock_failure ROLE [ get_parameter_value LOCK_FAILURE_CONDUIT_ROLE ]
	} else {
		set_interface_property lock_failure ENABLED false
		set_parameter_property LOCK_FAILURE_CONDUIT_ROLE ENABLED false
	}

	# enable output resets and set roles
	if {[ get_parameter_value ENABLE_LOCK_SUCCESS_RESET ] != 0} {
		set_interface_property lock_success_reset ENABLED true
		set_parameter_property LOCK_SUCCESS_RESET_ROLE ENABLED true
		set_port_property lock_success_reset ROLE [ expr {[ get_parameter_value LOCK_SUCCESS_RESET_ROLE ] ? "reset" : "reset_n"} ]
	} else {
		set_interface_property lock_success_reset ENABLED false
		set_parameter_property LOCK_SUCCESS_RESET_ROLE ENABLED false
	}

	if {[ get_parameter_value ENABLE_LOCK_FAILURE_RESET ] != 0} {
		set_interface_property lock_failure_reset ENABLED true
		set_parameter_property LOCK_FAILURE_RESET_ROLE ENABLED true
		set_port_property lock_failure_reset ROLE [ expr {[ get_parameter_value LOCK_FAILURE_RESET_ROLE ] ? "reset" : "reset_n"} ]
	} else {
		set_interface_property lock_failure_reset ENABLED false
		set_parameter_property LOCK_FAILURE_RESET_ROLE ENABLED false
	}
}

proc validate {} {
	set_module_assignment embeddedsw.CMacro.RESET_COUNTER_WIDTH [ get_parameter_value RESET_COUNTER_WIDTH ]
	set_module_assignment embeddedsw.CMacro.LOCK_COUNTER_WIDTH [ get_parameter_value LOCK_COUNTER_WIDTH ]
	set_module_assignment embeddedsw.CMacro.CLOCK_FREQ [ get_parameter_value CLOCK_FREQ ]
	set_module_assignment embeddedsw.CMacro.ENABLE_LOCK_SUCCESS_RESET [ get_parameter_value ENABLE_LOCK_SUCCESS_RESET ]
	set_module_assignment embeddedsw.CMacro.ENABLE_LOCK_SUCCESS_CONDUIT [ get_parameter_value ENABLE_LOCK_SUCCESS_CONDUIT ]
	set_module_assignment embeddedsw.CMacro.ENABLE_LOCK_FAILURE_RESET [ get_parameter_value ENABLE_LOCK_FAILURE_RESET ]
	set_module_assignment embeddedsw.CMacro.ENABLE_LOCK_FAILURE_CONDUIT [ get_parameter_value ENABLE_LOCK_FAILURE_CONDUIT ]
}

