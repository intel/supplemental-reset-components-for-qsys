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

