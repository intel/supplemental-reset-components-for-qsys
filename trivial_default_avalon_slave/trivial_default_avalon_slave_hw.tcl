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
package require -exact qsys 15.1


# 
# module trivial_default_avalon_slave
# 
set_module_property DESCRIPTION "A trival avalon slave that can be used as a default slave."
set_module_property NAME trivial_default_avalon_slave
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Reset Components"
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME trivial_default_avalon_slave
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property VALIDATION_CALLBACK validate
set_module_property ELABORATION_CALLBACK elaborate


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL trivial_default_avalon_slave
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file trivial_default_avalon_slave.v VERILOG PATH trivial_default_avalon_slave.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL trivial_default_avalon_slave
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file trivial_default_avalon_slave.v VERILOG PATH trivial_default_avalon_slave.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL trivial_default_avalon_slave
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file trivial_default_avalon_slave.v VERILOG PATH trivial_default_avalon_slave.v


# 
# parameters
# 
add_parameter DATA_BYTES INTEGER
set_parameter_property DATA_BYTES DEFAULT_VALUE 1
set_parameter_property DATA_BYTES DISPLAY_NAME "Number of Data Bytes"
set_parameter_property DATA_BYTES TYPE INTEGER
set_parameter_property DATA_BYTES UNITS None
set_parameter_property DATA_BYTES GROUP "Slave Data Width"
set_parameter_property DATA_BYTES DISPLAY_HINT none
set_parameter_property DATA_BYTES ALLOWED_RANGES {1 2 4 8 16 32 64 128 256 512}
set_parameter_property DATA_BYTES DESCRIPTION "This is the byte width of the slave interface."
set_parameter_property DATA_BYTES HDL_PARAMETER true
set_parameter_property DATA_BYTES AFFECTS_VALIDATION true
set_parameter_property DATA_BYTES AFFECTS_ELABORATION true

add_parameter READ_DATA_PATTERN INTEGER
set_parameter_property READ_DATA_PATTERN DEFAULT_VALUE 0
set_parameter_property READ_DATA_PATTERN DISPLAY_NAME "readdata port pattern(8-bits)"
set_parameter_property READ_DATA_PATTERN TYPE INTEGER
set_parameter_property READ_DATA_PATTERN UNITS None
set_parameter_property READ_DATA_PATTERN GROUP "Slave Read Data"
set_parameter_property READ_DATA_PATTERN DISPLAY_HINT hexadecimal
set_parameter_property READ_DATA_PATTERN ALLOWED_RANGES 0:255
set_parameter_property READ_DATA_PATTERN DESCRIPTION "This is the value of all bytes returned by this component during a read request."
set_parameter_property READ_DATA_PATTERN HDL_PARAMETER true
set_parameter_property READ_DATA_PATTERN AFFECTS_VALIDATION true

add_parameter ENABLE_READ_RESPONSE INTEGER
set_parameter_property ENABLE_READ_RESPONSE DEFAULT_VALUE 0
set_parameter_property ENABLE_READ_RESPONSE DISPLAY_NAME "Enable slave response port."
set_parameter_property ENABLE_READ_RESPONSE TYPE INTEGER
set_parameter_property ENABLE_READ_RESPONSE UNITS None
set_parameter_property ENABLE_READ_RESPONSE GROUP "Slave Response"
set_parameter_property ENABLE_READ_RESPONSE DISPLAY_HINT boolean
set_parameter_property ENABLE_READ_RESPONSE DESCRIPTION "Enable to use slave response port.  This allows the slave to signal error responses to read requests."
set_parameter_property ENABLE_READ_RESPONSE HDL_PARAMETER false
set_parameter_property ENABLE_READ_RESPONSE AFFECTS_VALIDATION true
set_parameter_property ENABLE_READ_RESPONSE AFFECTS_ELABORATION true

add_parameter RESPONSE_PATTERN INTEGER
set_parameter_property RESPONSE_PATTERN DEFAULT_VALUE 0
set_parameter_property RESPONSE_PATTERN DISPLAY_NAME "response port pattern(2-bits)"
set_parameter_property RESPONSE_PATTERN TYPE INTEGER
set_parameter_property RESPONSE_PATTERN UNITS None
set_parameter_property RESPONSE_PATTERN GROUP "Slave Response"
set_parameter_property RESPONSE_PATTERN DISPLAY_HINT none
set_parameter_property RESPONSE_PATTERN ALLOWED_RANGES {0:00=OKAY 1:01=RESERVED 2:10=SLAVE_ERROR 3:11=DECODE_ERROR}
set_parameter_property RESPONSE_PATTERN DESCRIPTION "This pattern is always returned on the response port of the slave."
set_parameter_property RESPONSE_PATTERN HDL_PARAMETER true
set_parameter_property RESPONSE_PATTERN AFFECTS_VALIDATION true

add_parameter ENABLE_WRITE_RESPONSE INTEGER
set_parameter_property ENABLE_WRITE_RESPONSE DEFAULT_VALUE 0
set_parameter_property ENABLE_WRITE_RESPONSE DISPLAY_NAME "Enable slave writeresponsevalid port."
set_parameter_property ENABLE_WRITE_RESPONSE TYPE INTEGER
set_parameter_property ENABLE_WRITE_RESPONSE UNITS None
set_parameter_property ENABLE_WRITE_RESPONSE GROUP "Slave Response"
set_parameter_property ENABLE_WRITE_RESPONSE DISPLAY_HINT boolean
set_parameter_property ENABLE_WRITE_RESPONSE DESCRIPTION "Enable to use slave writeresponsevalid port.  This allows the slave to signal error responses to write requests."
set_parameter_property ENABLE_WRITE_RESPONSE HDL_PARAMETER false
set_parameter_property ENABLE_WRITE_RESPONSE AFFECTS_VALIDATION true
set_parameter_property ENABLE_WRITE_RESPONSE AFFECTS_ELABORATION true

add_parameter NEVER_RESPOND INTEGER
set_parameter_property NEVER_RESPOND DEFAULT_VALUE 0
set_parameter_property NEVER_RESPOND DISPLAY_NAME "waitrequest Never Responds"
set_parameter_property NEVER_RESPOND TYPE INTEGER
set_parameter_property NEVER_RESPOND UNITS None
set_parameter_property NEVER_RESPOND GROUP "Slave waitrequest Behavior"
set_parameter_property NEVER_RESPOND DISPLAY_HINT boolean
set_parameter_property NEVER_RESPOND DESCRIPTION "Enable to prevent waitrequest from ever asserting.  Disable to allow waitrequest to terminate read and write requests.  A master that accesses this slave when this parameter is enabled will be stalled forever."
set_parameter_property NEVER_RESPOND HDL_PARAMETER true
set_parameter_property NEVER_RESPOND AFFECTS_VALIDATION true

add_parameter ENABLE_CLEAR_EVENT INTEGER
set_parameter_property ENABLE_CLEAR_EVENT DEFAULT_VALUE 0
set_parameter_property ENABLE_CLEAR_EVENT DISPLAY_NAME "Enable clear_event input"
set_parameter_property ENABLE_CLEAR_EVENT TYPE INTEGER
set_parameter_property ENABLE_CLEAR_EVENT UNITS None
set_parameter_property ENABLE_CLEAR_EVENT GROUP "Clear Event Input"
set_parameter_property ENABLE_CLEAR_EVENT DISPLAY_HINT boolean
set_parameter_property ENABLE_CLEAR_EVENT DESCRIPTION "Enable to use clear_event input conduit."
set_parameter_property ENABLE_CLEAR_EVENT HDL_PARAMETER false
set_parameter_property ENABLE_CLEAR_EVENT AFFECTS_VALIDATION true
set_parameter_property ENABLE_CLEAR_EVENT AFFECTS_ELABORATION true

add_parameter CLEAR_EVENT_CONDUIT_ROLE STRING
set_parameter_property CLEAR_EVENT_CONDUIT_ROLE DEFAULT_VALUE "clear_event"
set_parameter_property CLEAR_EVENT_CONDUIT_ROLE DISPLAY_NAME "Role of clear_event conduit"
set_parameter_property CLEAR_EVENT_CONDUIT_ROLE TYPE STRING
set_parameter_property CLEAR_EVENT_CONDUIT_ROLE UNITS None
set_parameter_property CLEAR_EVENT_CONDUIT_ROLE GROUP "Clear Event Input"
set_parameter_property CLEAR_EVENT_CONDUIT_ROLE DESCRIPTION "Enter the role that you want to assign the clear_event conduit input."
set_parameter_property CLEAR_EVENT_CONDUIT_ROLE HDL_PARAMETER false
set_parameter_property CLEAR_EVENT_CONDUIT_ROLE AFFECTS_VALIDATION true
set_parameter_property CLEAR_EVENT_CONDUIT_ROLE AFFECTS_ELABORATION true

add_parameter ENABLE_ACCESS_EVENT_CONDUIT INTEGER
set_parameter_property ENABLE_ACCESS_EVENT_CONDUIT DEFAULT_VALUE 0
set_parameter_property ENABLE_ACCESS_EVENT_CONDUIT DISPLAY_NAME "Enable access_event_conduit output"
set_parameter_property ENABLE_ACCESS_EVENT_CONDUIT TYPE INTEGER
set_parameter_property ENABLE_ACCESS_EVENT_CONDUIT UNITS None
set_parameter_property ENABLE_ACCESS_EVENT_CONDUIT GROUP "Access Event Output"
set_parameter_property ENABLE_ACCESS_EVENT_CONDUIT DISPLAY_HINT boolean
set_parameter_property ENABLE_ACCESS_EVENT_CONDUIT DESCRIPTION "Enable to use access_event_conduit output."
set_parameter_property ENABLE_ACCESS_EVENT_CONDUIT HDL_PARAMETER false
set_parameter_property ENABLE_ACCESS_EVENT_CONDUIT AFFECTS_VALIDATION true
set_parameter_property ENABLE_ACCESS_EVENT_CONDUIT AFFECTS_ELABORATION true

add_parameter ACCESS_EVENT_CONDUIT_ROLE STRING
set_parameter_property ACCESS_EVENT_CONDUIT_ROLE DEFAULT_VALUE "access_event_conduit"
set_parameter_property ACCESS_EVENT_CONDUIT_ROLE DISPLAY_NAME "Role of access_event_conduit"
set_parameter_property ACCESS_EVENT_CONDUIT_ROLE TYPE STRING
set_parameter_property ACCESS_EVENT_CONDUIT_ROLE UNITS None
set_parameter_property ACCESS_EVENT_CONDUIT_ROLE GROUP "Access Event Output"
set_parameter_property ACCESS_EVENT_CONDUIT_ROLE DESCRIPTION "Enter the role that you want to assign the access_event_conduit."
set_parameter_property ACCESS_EVENT_CONDUIT_ROLE HDL_PARAMETER false
set_parameter_property ACCESS_EVENT_CONDUIT_ROLE AFFECTS_VALIDATION true
set_parameter_property ACCESS_EVENT_CONDUIT_ROLE AFFECTS_ELABORATION true

add_parameter ENABLE_ACCESS_EVENT_RESET INTEGER
set_parameter_property ENABLE_ACCESS_EVENT_RESET DEFAULT_VALUE 0
set_parameter_property ENABLE_ACCESS_EVENT_RESET DISPLAY_NAME "Enable access_event_reset output"
set_parameter_property ENABLE_ACCESS_EVENT_RESET TYPE INTEGER
set_parameter_property ENABLE_ACCESS_EVENT_RESET UNITS None
set_parameter_property ENABLE_ACCESS_EVENT_RESET GROUP "Access Event Output"
set_parameter_property ENABLE_ACCESS_EVENT_RESET DISPLAY_HINT boolean
set_parameter_property ENABLE_ACCESS_EVENT_RESET DESCRIPTION "Enable to use access_event_reset output."
set_parameter_property ENABLE_ACCESS_EVENT_RESET HDL_PARAMETER false
set_parameter_property ENABLE_ACCESS_EVENT_RESET AFFECTS_VALIDATION true
set_parameter_property ENABLE_ACCESS_EVENT_RESET AFFECTS_ELABORATION true

add_parameter ENABLE_ACCESS_EVENT_INTERRUPT INTEGER
set_parameter_property ENABLE_ACCESS_EVENT_INTERRUPT DEFAULT_VALUE 0
set_parameter_property ENABLE_ACCESS_EVENT_INTERRUPT DISPLAY_NAME "Enable access_event_interrupt output"
set_parameter_property ENABLE_ACCESS_EVENT_INTERRUPT TYPE INTEGER
set_parameter_property ENABLE_ACCESS_EVENT_INTERRUPT UNITS None
set_parameter_property ENABLE_ACCESS_EVENT_INTERRUPT GROUP "Access Event Output"
set_parameter_property ENABLE_ACCESS_EVENT_INTERRUPT DISPLAY_HINT boolean
set_parameter_property ENABLE_ACCESS_EVENT_INTERRUPT DESCRIPTION "Enable to use access_event_interrupt output."
set_parameter_property ENABLE_ACCESS_EVENT_INTERRUPT HDL_PARAMETER false
set_parameter_property ENABLE_ACCESS_EVENT_INTERRUPT AFFECTS_VALIDATION true
set_parameter_property ENABLE_ACCESS_EVENT_INTERRUPT AFFECTS_ELABORATION true


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

add_interface_port clock clock_clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_reset reset Input 1


# 
# connection point slave
# 
add_interface slave avalon end
set_interface_property slave addressUnits WORDS
set_interface_property slave associatedClock clock
set_interface_property slave associatedReset reset
set_interface_property slave bitsPerSymbol 8
set_interface_property slave bridgedAddressOffset 0
set_interface_property slave burstOnBurstBoundariesOnly false
set_interface_property slave burstcountUnits WORDS
set_interface_property slave explicitAddressSpan 0
set_interface_property slave holdTime 0
set_interface_property slave linewrapBursts false
set_interface_property slave maximumPendingReadTransactions 1
set_interface_property slave maximumPendingWriteTransactions 1
set_interface_property slave readLatency 0
set_interface_property slave readWaitTime 1
set_interface_property slave setupTime 0
set_interface_property slave timingUnits Cycles
set_interface_property slave writeWaitTime 0
set_interface_property slave ENABLED true
set_interface_property slave EXPORT_OF ""
set_interface_property slave PORT_NAME_MAP ""
set_interface_property slave CMSIS_SVD_VARIABLES ""
set_interface_property slave SVD_ADDRESS_GROUP ""

add_interface_port slave slave_read read Input 1
add_interface_port slave slave_readdata readdata Output "DATA_BYTES * 8"
add_interface_port slave slave_readdatavalid readdatavalid Output 1
add_interface_port slave slave_write write Input 1
add_interface_port slave slave_writedata writedata Input "DATA_BYTES * 8"
add_interface_port slave slave_byteenable byteenable Input "DATA_BYTES"
add_interface_port slave slave_waitrequest waitrequest Output 1
add_interface_port slave slave_response response Output 2
add_interface_port slave slave_writeresponsevalid writeresponsevalid Output 1
set_interface_assignment slave embeddedsw.configuration.isFlash 0
set_interface_assignment slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment slave embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clear_event
# 
add_interface clear_event conduit end
set_interface_property clear_event associatedClock ""
set_interface_property clear_event associatedReset ""
set_interface_property clear_event ENABLED true
set_interface_property clear_event EXPORT_OF ""
set_interface_property clear_event PORT_NAME_MAP ""
set_interface_property clear_event CMSIS_SVD_VARIABLES ""
set_interface_property clear_event SVD_ADDRESS_GROUP ""

add_interface_port clear_event clear_event clear_event Input 1


# 
# connection point access_event_conduit
# 
add_interface access_event_conduit conduit end
set_interface_property access_event_conduit associatedClock ""
set_interface_property access_event_conduit associatedReset ""
set_interface_property access_event_conduit ENABLED true
set_interface_property access_event_conduit EXPORT_OF ""
set_interface_property access_event_conduit PORT_NAME_MAP ""
set_interface_property access_event_conduit CMSIS_SVD_VARIABLES ""
set_interface_property access_event_conduit SVD_ADDRESS_GROUP ""

add_interface_port access_event_conduit access_event_conduit access_event_conduit Output 1


# 
# connection point access_event_reset
# 
add_interface access_event_reset reset start
set_interface_property access_event_reset associatedClock ""
set_interface_property access_event_reset associatedDirectReset ""
set_interface_property access_event_reset associatedResetSinks none
set_interface_property access_event_reset synchronousEdges NONE
set_interface_property access_event_reset ENABLED true
set_interface_property access_event_reset EXPORT_OF ""
set_interface_property access_event_reset PORT_NAME_MAP ""
set_interface_property access_event_reset CMSIS_SVD_VARIABLES ""
set_interface_property access_event_reset SVD_ADDRESS_GROUP ""

add_interface_port access_event_reset access_event_reset reset Output 1


# 
# connection point access_event_interrupt
# 
add_interface access_event_interrupt interrupt end
set_interface_property access_event_interrupt associatedAddressablePoint ""
set_interface_property access_event_interrupt bridgedReceiverOffset ""
set_interface_property access_event_interrupt bridgesToReceiver ""
set_interface_property access_event_interrupt ENABLED true
set_interface_property access_event_interrupt EXPORT_OF ""
set_interface_property access_event_interrupt PORT_NAME_MAP ""
set_interface_property access_event_interrupt CMSIS_SVD_VARIABLES ""
set_interface_property access_event_interrupt SVD_ADDRESS_GROUP ""

add_interface_port access_event_interrupt access_event_interrupt irq Output 1


proc elaborate {} {
	if {[ get_parameter_value ENABLE_READ_RESPONSE ] != 0} {
		set_parameter_property ENABLE_WRITE_RESPONSE ENABLED true
		set_parameter_property RESPONSE_PATTERN ENABLED true
		set_port_property slave_response TERMINATION false
		if {[ get_parameter_value ENABLE_WRITE_RESPONSE ] != 0} {
			set_port_property slave_writeresponsevalid TERMINATION false
			set_interface_property slave maximumPendingWriteTransactions 1
		} else {
			set_port_property slave_writeresponsevalid TERMINATION true
			set_interface_property slave maximumPendingWriteTransactions 0
		}
	} else {
		set_parameter_property ENABLE_WRITE_RESPONSE ENABLED false
		set_parameter_property RESPONSE_PATTERN ENABLED false
		set_port_property slave_response TERMINATION true
		set_port_property slave_writeresponsevalid TERMINATION true
		set_interface_property slave maximumPendingWriteTransactions 0
	}

	if {[ get_parameter_value ENABLE_CLEAR_EVENT ] != 0} {
		set_interface_property clear_event ENABLED true
		set_parameter_property CLEAR_EVENT_CONDUIT_ROLE ENABLED true
		set_port_property clear_event ROLE [ get_parameter_value CLEAR_EVENT_CONDUIT_ROLE ]
	} else {
		set_interface_property clear_event ENABLED false
		set_parameter_property CLEAR_EVENT_CONDUIT_ROLE ENABLED false
	}

	if {[ get_parameter_value ENABLE_ACCESS_EVENT_CONDUIT ] != 0} {
		set_interface_property access_event_conduit ENABLED true
		set_parameter_property ACCESS_EVENT_CONDUIT_ROLE ENABLED true
		set_port_property access_event_conduit ROLE [ get_parameter_value ACCESS_EVENT_CONDUIT_ROLE ]
	} else {
		set_interface_property access_event_conduit ENABLED false
		set_parameter_property ACCESS_EVENT_CONDUIT_ROLE ENABLED false
	}

	if {[ get_parameter_value ENABLE_ACCESS_EVENT_RESET ] != 0} {
		set_interface_property access_event_reset ENABLED true
	} else {
		set_interface_property access_event_reset ENABLED false
	}

	if {[ get_parameter_value ENABLE_ACCESS_EVENT_INTERRUPT ] != 0} {
		set_interface_property access_event_interrupt ENABLED true
	} else {
		set_interface_property access_event_interrupt ENABLED false
	}
}


proc validate {} {
        set_module_assignment embeddedsw.CMacro.DATA_BYTES [ get_parameter_value DATA_BYTES ]
        set_module_assignment embeddedsw.CMacro.READ_DATA_PATTERN [ get_parameter_value READ_DATA_PATTERN ]
        set_module_assignment embeddedsw.CMacro.ENABLE_READ_RESPONSE [ get_parameter_value ENABLE_READ_RESPONSE ]
        set_module_assignment embeddedsw.CMacro.RESPONSE_PATTERN [ get_parameter_value RESPONSE_PATTERN ]
        set_module_assignment embeddedsw.CMacro.ENABLE_WRITE_RESPONSE [ get_parameter_value ENABLE_WRITE_RESPONSE ]
        set_module_assignment embeddedsw.CMacro.NEVER_RESPOND [ get_parameter_value NEVER_RESPOND ]
        set_module_assignment embeddedsw.CMacro.ENABLE_CLEAR_EVENT [ get_parameter_value ENABLE_CLEAR_EVENT ]
        set_module_assignment embeddedsw.CMacro.ENABLE_ACCESS_EVENT_CONDUIT [ get_parameter_value ENABLE_ACCESS_EVENT_CONDUIT ]
        set_module_assignment embeddedsw.CMacro.ENABLE_ACCESS_EVENT_RESET [ get_parameter_value ENABLE_ACCESS_EVENT_RESET ]
        set_module_assignment embeddedsw.CMacro.ENABLE_ACCESS_EVENT_INTERRUPT [ get_parameter_value ENABLE_ACCESS_EVENT_INTERRUPT ]
}

