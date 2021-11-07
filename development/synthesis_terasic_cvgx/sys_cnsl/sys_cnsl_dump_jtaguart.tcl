#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

# open the service path to our expected JTAG UART bytestream service
set ju [ lindex [ get_service_paths bytestream ] [ lsearch [ get_service_paths bytestream ] "*(110:128 v1 #0)*" ] ]
if { [ string length "$ju" ] == 0 } {
	set ju [ lindex [ get_service_paths bytestream ] [ lsearch [ get_service_paths bytestream ] "*/jtag_uart.jtag" ] ]
	if { [ string length "$ju" ] == 0 } {
		return -code error "could not locate expected JTAG UART service path"
	}
}

open_service bytestream "$ju"

# dump the JTAG UART contents
set x [ bytestream_receive $ju 1 ]
while { [ string length $x ] } {
	puts -nonewline [ format "%c" $x ]
	set x [ bytestream_receive $ju 1 ]
}

