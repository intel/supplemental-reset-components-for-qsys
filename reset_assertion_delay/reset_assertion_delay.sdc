#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
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

