#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

# open the service path to our expected JTAG master jtag_debug service
set jd [ lindex [ get_service_paths jtag_debug ] [ lsearch [ get_service_paths jtag_debug ] "*(110:132 v1 #0)*" ] ]
if { [ string length "$jd" ] == 0 } {
	set jd [ lindex [ get_service_paths jtag_debug ] [ lsearch [ get_service_paths jtag_debug ] "*phy_0" ] ]
	if { [ string length "$jd" ] == 0 } {
		return -code error "could not locate expected jtag_debug service path"
	}
}

open_service jtag_debug "$jd"

# reset the target
jtag_debug_reset_system $jd

