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
# module reset_until_ack
# 
set_module_property DESCRIPTION "Assert reset output when reset assert input is active, then hold reset output until reset release input is asserted."
set_module_property NAME reset_until_ack
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Reset Components"
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME reset_until_ack
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL reset_until_ack
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file reset_until_ack.v VERILOG PATH reset_until_ack.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL reset_until_ack
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file reset_until_ack.v VERILOG PATH reset_until_ack.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL reset_until_ack
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file reset_until_ack.v VERILOG PATH reset_until_ack.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clk_in
# 
add_interface clk_in clock end
set_interface_property clk_in clockRate 0
set_interface_property clk_in ENABLED true
set_interface_property clk_in EXPORT_OF ""
set_interface_property clk_in PORT_NAME_MAP ""
set_interface_property clk_in CMSIS_SVD_VARIABLES ""
set_interface_property clk_in SVD_ADDRESS_GROUP ""

add_interface_port clk_in clk_in_clk clk Input 1


# 
# connection point reset_assert
# 
add_interface reset_assert reset end
set_interface_property reset_assert associatedClock clk_in
set_interface_property reset_assert synchronousEdges DEASSERT
set_interface_property reset_assert ENABLED true
set_interface_property reset_assert EXPORT_OF ""
set_interface_property reset_assert PORT_NAME_MAP ""
set_interface_property reset_assert CMSIS_SVD_VARIABLES ""
set_interface_property reset_assert SVD_ADDRESS_GROUP ""

add_interface_port reset_assert reset_assert_reset reset Input 1


# 
# connection point reset_release
# 
add_interface reset_release reset end
set_interface_property reset_release associatedClock clk_in
set_interface_property reset_release synchronousEdges BOTH
set_interface_property reset_release ENABLED true
set_interface_property reset_release EXPORT_OF ""
set_interface_property reset_release PORT_NAME_MAP ""
set_interface_property reset_release CMSIS_SVD_VARIABLES ""
set_interface_property reset_release SVD_ADDRESS_GROUP ""

add_interface_port reset_release reset_release_reset reset Input 1


# 
# connection point reset_out
# 
add_interface reset_out reset start
set_interface_property reset_out associatedClock clk_in
set_interface_property reset_out associatedDirectReset ""
set_interface_property reset_out associatedResetSinks reset_assert
set_interface_property reset_out synchronousEdges DEASSERT
set_interface_property reset_out ENABLED true
set_interface_property reset_out EXPORT_OF ""
set_interface_property reset_out PORT_NAME_MAP ""
set_interface_property reset_out CMSIS_SVD_VARIABLES ""
set_interface_property reset_out SVD_ADDRESS_GROUP ""

add_interface_port reset_out reset_out_reset reset Output 1

