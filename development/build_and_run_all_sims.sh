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

#
# change into the directory of this script
#
cd $(dirname ${0:?})

#
# setup a build log directory
#
BUILD_LOGS="$(pwd)/build_logs"

[ -d "${BUILD_LOGS:?}" ] || {
	mkdir -p "${BUILD_LOGS:?}"
}

#
# build all the tests in parallel
#
EXIT_VALUE=0

../conduit_adapters/conduit_remap/development/build_and_run_testbench.sh 01 02 03 \
	> "${BUILD_LOGS:?}"/conduit_remap_log.txt 2>&1 &
CONDUIT_REMAP_PID="$!"

../conduit_adapters/emif_status_breakout/development/build_and_run_testbench.sh 01 02 03 \
	> "${BUILD_LOGS:?}"/emif_status_breakout_log.txt 2>&1 &
EMIF_STATUS_BREAKOUT_PID="$!"

../conduit_adapters/pll_sharing_to_pll_locked/development/build_and_run_testbench.sh 01 02 03 \
	> "${BUILD_LOGS:?}"/pll_sharing_to_pll_locked_log.txt 2>&1 &
PLL_SHARING_TO_PLL_LOCKED_PID="$!"

../event_timer/development/build_and_run_testbench.sh 01 02 03 \
	> "${BUILD_LOGS:?}"/event_timer_log.txt 2>&1 &
EVENT_TIMER_PID="$!"

../pll_reset_monitor/development/build_and_run_testbench.sh 01 02 03 \
	> "${BUILD_LOGS:?}"/pll_reset_monitor_log.txt 2>&1 &
PLL_RESET_MONITOR_PID="$!"

../power_on_reset/development/build_and_run_testbench.sh 01 02 03 \
	> "${BUILD_LOGS:?}"/power_on_reset_log.txt 2>&1 &
POWER_ON_RESET_PID="$!"

../reset_assertion_delay/development/build_and_run_testbench.sh 01 02 03 \
	> "${BUILD_LOGS:?}"/reset_assertion_delay_log.txt 2>&1 &
RESET_ASSERTION_DELAY_PID="$!"

../reset_debouncer/development/build_and_run_testbench.sh 01 02 03 \
	> "${BUILD_LOGS:?}"/reset_debouncer_log.txt 2>&1 &
RESET_DEBOUNCER_PID="$!"

../reset_event_counter/development/build_and_run_testbench.sh 01 02 03 \
	> "${BUILD_LOGS:?}"/reset_event_counter_log.txt 2>&1 &
RESET_EVENT_COUNTER_PID="$!"

../reset_until_ack/development/build_and_run_testbench.sh 01 02 03 \
	> "${BUILD_LOGS:?}"/reset_until_ack_log.txt 2>&1 &
RESET_UNTIL_ACK_PID="$!"

../trivial_default_avalon_slave/development/build_and_run_testbench.sh 01 02 03 \
	> "${BUILD_LOGS:?}"/trivial_default_avalon_slave_log.txt 2>&1 &
TRIVIAL_DEFAULT_AVALON_SLAVE_PID="$!"

wait ${CONDUIT_REMAP_PID} || { EXIT_VALUE=1; echo "ERROR:CONDUIT_REMAP";}
wait ${EMIF_STATUS_BREAKOUT_PID} || { EXIT_VALUE=1; echo "ERROR:EMIF_STATUS_BREAKOUT";}
wait ${PLL_SHARING_TO_PLL_LOCKED_PID} || { EXIT_VALUE=1; echo "ERROR:PLL_SHARING_TO_PLL_LOCKED";}
wait ${EVENT_TIMER_PID} || { EXIT_VALUE=1; echo "ERROR:EVENT_TIMER";}
wait ${PLL_RESET_MONITOR_PID} || { EXIT_VALUE=1; echo "ERROR:PLL_RESET_MONITOR";}
wait ${POWER_ON_RESET_PID} || { EXIT_VALUE=1; echo "ERROR:POWER_ON_RESET";}
wait ${RESET_ASSERTION_DELAY_PID} || { EXIT_VALUE=1; echo "ERROR:RESET_ASSERTION_DELAY";}
wait ${RESET_DEBOUNCER_PID} || { EXIT_VALUE=1; echo "ERROR:RESET_DEBOUNCER";}
wait ${RESET_EVENT_COUNTER_PID} || { EXIT_VALUE=1; echo "ERROR:RESET_EVENT_COUNTER";}
wait ${RESET_UNTIL_ACK_PID} || { EXIT_VALUE=1; echo "ERROR:RESET_UNTIL_ACK_PID";}
wait ${TRIVIAL_DEFAULT_AVALON_SLAVE_PID} || { EXIT_VALUE=1; echo "ERROR:TRIVIAL_DEFAULT_AVALON_SLAVE";}

[ "${EXIT_VALUE}" -ne "0" ] && { echo "Test Failure"; exit ${EXIT_VALUE}; }

#
# run all the sims sequentially so a simple Modelsim license will work
#
../conduit_adapters/conduit_remap/development/build_and_run_testbench.sh 04 \
	>> "${BUILD_LOGS:?}"/conduit_remap_log.txt 2>&1 \
	|| { EXIT_VALUE=1; echo "ERROR:CONDUIT_REMAP";}

../conduit_adapters/emif_status_breakout/development/build_and_run_testbench.sh 04 \
	>> "${BUILD_LOGS:?}"/emif_status_breakout_log.txt 2>&1 \
	|| { EXIT_VALUE=1; echo "ERROR:EMIF_STATUS_BREAKOUT";}

../conduit_adapters/pll_sharing_to_pll_locked/development/build_and_run_testbench.sh 04 \
	>> "${BUILD_LOGS:?}"/pll_sharing_to_pll_locked_log.txt 2>&1 \
	|| { EXIT_VALUE=1; echo "ERROR:PLL_SHARING_TO_PLL_LOCKED";}

../event_timer/development/build_and_run_testbench.sh 04 \
	>> "${BUILD_LOGS:?}"/event_timer_log.txt 2>&1 \
	|| { EXIT_VALUE=1; echo "ERROR:EVENT_TIMER";}

../pll_reset_monitor/development/build_and_run_testbench.sh 04 \
	>> "${BUILD_LOGS:?}"/pll_reset_monitor_log.txt 2>&1 \
	|| { EXIT_VALUE=1; echo "ERROR:PLL_RESET_MONITOR";}
	
../power_on_reset/development/build_and_run_testbench.sh 04 \
	>> "${BUILD_LOGS:?}"/power_on_reset_log.txt 2>&1 \
	|| { EXIT_VALUE=1; echo "ERROR:POWER_ON_RESET";}
	
../reset_assertion_delay/development/build_and_run_testbench.sh 04 \
	>> "${BUILD_LOGS:?}"/reset_assertion_delay_log.txt 2>&1 \
	|| { EXIT_VALUE=1; echo "ERROR:RESET_ASSERTION_DELAY";}

../reset_debouncer/development/build_and_run_testbench.sh 04 \
	>> "${BUILD_LOGS:?}"/reset_debouncer_log.txt 2>&1 \
	|| { EXIT_VALUE=1; echo "ERROR:RESET_DEBOUNCER";}

../reset_event_counter/development/build_and_run_testbench.sh 04 \
	>> "${BUILD_LOGS:?}"/reset_event_counter_log.txt 2>&1 \
	|| { EXIT_VALUE=1; echo "ERROR:RESET_EVENT_COUNTER";}

../reset_until_ack/development/build_and_run_testbench.sh 04 \
	>> "${BUILD_LOGS:?}"/reset_until_ack_log.txt 2>&1 \
	|| { EXIT_VALUE=1; echo "ERROR:RESET_UNTIL_ACK_PID";}

../trivial_default_avalon_slave/development/build_and_run_testbench.sh 04 \
	>> "${BUILD_LOGS:?}"/trivial_default_avalon_slave_log.txt 2>&1 \
	|| { EXIT_VALUE=1; echo "ERROR:TRIVIAL_DEFAULT_AVALON_SLAVE";}

[ "${EXIT_VALUE}" -ne "0" ] && { echo "Test Failure"; }
[ "${EXIT_VALUE}" -eq "0" ] && { echo "Test Success"; }

exit ${EXIT_VALUE}

