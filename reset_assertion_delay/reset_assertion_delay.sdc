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

#
# Cut the asynchronous clear paths for reset_input_capture_inst
#
set FALSE_PATH {}
lappend FALSE_PATH {*reset_assertion_delay:*|altera_reset_synchronizer:reset_input_capture_inst|altera_reset_synchronizer_int_chain*|}

set CLEAR_PIN {}
lappend CLEAR_PIN {aclr}
lappend CLEAR_PIN {clrn}

foreach FP ${FALSE_PATH} {
	foreach CP ${CLEAR_PIN} {
		if {[get_collection_size [get_pins -compatibility_mode -nocase -nowarn "${FP}${CP}" ]] > 0} {
			set_false_path -to [get_pins -compatibility_mode -nocase "${FP}${CP}"]
		}
	}
}

