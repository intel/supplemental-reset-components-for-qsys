#!/bin/bash
#
# Copyright (c) 2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

cd $(dirname ${0})

niosv-app \
	--app-dir=. \
	--bsp-dir=../test_sw_bsp \
	--srcs=main.c \
	--elf-name=test_sw.elf

