#
# Copyright (c) 2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
package require -exact qsys 21.3


#
# module niosv_reset_looper
#
set_module_property DESCRIPTION "Connect to Nios V instruction master and point reset vector to LOOPER subordinate."
set_module_property NAME niosv_reset_looper
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Reset Components"
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME niosv_reset_looper
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property LOAD_ELABORATION_LIMIT 0


#
# file sets
#
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL niosv_reset_looper
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file niosv_reset_looper.v VERILOG PATH niosv_reset_looper.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL niosv_reset_looper
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file niosv_reset_looper.v VERILOG PATH niosv_reset_looper.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL niosv_reset_looper
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file niosv_reset_looper.v VERILOG PATH niosv_reset_looper.v


#
# parameters
#


#
# display items
#


#
# connection point clock
#
add_interface clock clock end
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""
set_interface_property clock IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port clock clk clk Input 1


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
set_interface_property reset IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port reset reset reset Input 1


#
# connection point csr_sub
#
add_interface csr_sub axi4lite end
set_interface_property csr_sub associatedClock clock
set_interface_property csr_sub associatedReset reset
set_interface_property csr_sub readAcceptanceCapability 1
set_interface_property csr_sub writeAcceptanceCapability 1
set_interface_property csr_sub combinedAcceptanceCapability 1
set_interface_property csr_sub bridgesToMaster ""
set_interface_property csr_sub ENABLED true
set_interface_property csr_sub EXPORT_OF ""
set_interface_property csr_sub PORT_NAME_MAP ""
set_interface_property csr_sub CMSIS_SVD_VARIABLES ""
set_interface_property csr_sub SVD_ADDRESS_GROUP ""
set_interface_property csr_sub IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port csr_sub csr_sub_araddr araddr Input 12
add_interface_port csr_sub csr_sub_arprot arprot Input 3
add_interface_port csr_sub csr_sub_arready arready Output 1
add_interface_port csr_sub csr_sub_arvalid arvalid Input 1
add_interface_port csr_sub csr_sub_awaddr awaddr Input 12
add_interface_port csr_sub csr_sub_awprot awprot Input 3
add_interface_port csr_sub csr_sub_awready awready Output 1
add_interface_port csr_sub csr_sub_awvalid awvalid Input 1
add_interface_port csr_sub csr_sub_bready bready Input 1
add_interface_port csr_sub csr_sub_bresp bresp Output 2
add_interface_port csr_sub csr_sub_bvalid bvalid Output 1
add_interface_port csr_sub csr_sub_rdata rdata Output 32
add_interface_port csr_sub csr_sub_rready rready Input 1
add_interface_port csr_sub csr_sub_rresp rresp Output 2
add_interface_port csr_sub csr_sub_rvalid rvalid Output 1
add_interface_port csr_sub csr_sub_wdata wdata Input 32
add_interface_port csr_sub csr_sub_wready wready Output 1
add_interface_port csr_sub csr_sub_wstrb wstrb Input 4
add_interface_port csr_sub csr_sub_wvalid wvalid Input 1


#
# connection point looper_sub
#
add_interface looper_sub axi4lite end
set_interface_property looper_sub associatedClock clock
set_interface_property looper_sub associatedReset reset
set_interface_property looper_sub readAcceptanceCapability 1
set_interface_property looper_sub writeAcceptanceCapability 1
set_interface_property looper_sub combinedAcceptanceCapability 1
set_interface_property looper_sub bridgesToMaster ""
set_interface_property looper_sub ENABLED true
set_interface_property looper_sub EXPORT_OF ""
set_interface_property looper_sub PORT_NAME_MAP ""
set_interface_property looper_sub CMSIS_SVD_VARIABLES ""
set_interface_property looper_sub SVD_ADDRESS_GROUP ""
set_interface_property looper_sub IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port looper_sub looper_sub_araddr araddr Input 12
add_interface_port looper_sub looper_sub_arprot arprot Input 3
add_interface_port looper_sub looper_sub_arready arready Output 1
add_interface_port looper_sub looper_sub_arvalid arvalid Input 1
add_interface_port looper_sub looper_sub_awaddr awaddr Input 12
add_interface_port looper_sub looper_sub_awprot awprot Input 3
add_interface_port looper_sub looper_sub_awready awready Output 1
add_interface_port looper_sub looper_sub_awvalid awvalid Input 1
add_interface_port looper_sub looper_sub_bready bready Input 1
add_interface_port looper_sub looper_sub_bresp bresp Output 2
add_interface_port looper_sub looper_sub_bvalid bvalid Output 1
add_interface_port looper_sub looper_sub_rdata rdata Output 32
add_interface_port looper_sub looper_sub_rready rready Input 1
add_interface_port looper_sub looper_sub_rresp rresp Output 2
add_interface_port looper_sub looper_sub_rvalid rvalid Output 1
add_interface_port looper_sub looper_sub_wdata wdata Input 32
add_interface_port looper_sub looper_sub_wready wready Output 1
add_interface_port looper_sub looper_sub_wstrb wstrb Input 4
add_interface_port looper_sub looper_sub_wvalid wvalid Input 1

set_interface_assignment looper_sub embeddedsw.configuration.isMemoryDevice 1

