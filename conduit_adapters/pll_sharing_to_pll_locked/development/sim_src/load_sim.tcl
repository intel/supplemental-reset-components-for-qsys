#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

# Set the hierarchy variables used in Qsys-generated msim_setup.tcl
set TOP_LEVEL_NAME "sim_top"
set SYSTEM_INSTANCE_NAME "tb"
set QSYS_SIMDIR "../test_sys/testbench/"

# Send the transcript to a timestamped file.
set my_TS [ clock format [ clock seconds ] -format %Y%m%d_%H%M%S ]
set my_TRANSCRIPT transcript_${my_TS}.txt
transcript file ${my_TRANSCRIPT}
transcript on

# Source Qsys-generated script and set up alias commands used below
source ${QSYS_SIMDIR}/mentor/msim_setup.tcl

# Compile device library files
dev_com

# Compile the design files in correct order
com

# Compile the additional test files
vlog -sv ./sim_driver.sv -L altera_common_sv_packages
vlog -sv ./sim_top.sv

# Elaborate top level design
elab_debug

# Load the waveform "do file" Tcl script
if [batch_mode] {

} else {

	do ./wave.do
}

# Run the simulation.
run -all

