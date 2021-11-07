#!/bin/bash
#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

cd $(dirname $0)

cd ..

find -type 'f'			| \
sort				| \
grep -v "./.git"		| \
grep -v "./.scripts"		| \
grep -v "/development/"		| \
grep -v "/qsys_templates/"

