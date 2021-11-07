#!/bin/sh
#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

THE_TRANSCRIPT_FILE=$( find . -name 'transcript_*' | sort -r | head -n 1 )

[ -z "${THE_TRANSCRIPT_FILE}" ] && {

	echo "ERROR:  Cannot locate transcript file..."
	exit 1
}

grep -q "INFO: Test completed successfully..." ${THE_TRANSCRIPT_FILE} && {

	echo "test success"
	exit 0

} || {

	echo "test fail"
	exit 1

}
