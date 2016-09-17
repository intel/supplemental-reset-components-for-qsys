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

