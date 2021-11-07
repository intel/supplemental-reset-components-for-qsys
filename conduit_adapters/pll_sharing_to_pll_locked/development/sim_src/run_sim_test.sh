#!/bin/sh
#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

vsim < ./load_sim.tcl

./check_sim_success.sh
