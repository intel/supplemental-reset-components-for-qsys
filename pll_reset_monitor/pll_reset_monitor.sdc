#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

#
# Cut the asynchronous clear paths for pll_reset_request_sync_inst and pll_locked_sync_inst
#
set FALSE_PATH {}
lappend FALSE_PATH {*pll_reset_monitor:*|altera_reset_synchronizer:pll_reset_request_sync_inst|altera_reset_synchronizer_int_chain*|}
lappend FALSE_PATH {*pll_reset_monitor:*|altera_reset_synchronizer:pll_locked_sync_inst|altera_reset_synchronizer_int_chain*|}

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

