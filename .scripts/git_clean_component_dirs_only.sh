#!/bin/bash
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

# change into the directory of this script
cd $(dirname ${0:?})

[ "$(basename $(pwd))" == ".scripts" ] || {
	echo ""
	echo "ERROR: script does not appear to be in the '.scripts' directory"
	echo ""
	exit 1
}

[ "$(basename $(dirname $(pwd)))" == "reset_components" ] || {
	echo ""
	echo "ERROR: script does not appear to be in the 'reset_components/.scripts' directory"
	echo ""
	exit 1
}

COMPONENT_DIRECTORIES="
../conduit_adapters
../event_timer
../pll_reset_monitor
../power_on_reset
../reset_assertion_delay
../reset_debouncer
../reset_event_counter
../reset_until_ack
../trivial_default_avalon_slave
"

while read NEXT_DIR
do
[ ! -z ${NEXT_DIR} ] && {
	pushd "${NEXT_DIR:?}" > /dev/null 2>&1
	git clean -fd
	popd > /dev/null 2>&1
}
done < <( echo "${COMPONENT_DIRECTORIES:?}" )

