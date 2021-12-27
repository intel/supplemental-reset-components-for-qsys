#!/bin/bash
#
# Copyright (c) 2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

cd $(dirname ${0})

niosv-bsp \
	settings.bsp \
	--create \
	--qsys=../../test_sys.qsys \
	--quartus-project=../../test_proj.qpf \
	--type=hal \
	--script=test_sw_bsp.tcl

