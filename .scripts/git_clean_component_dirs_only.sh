#!/bin/bash
#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
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

