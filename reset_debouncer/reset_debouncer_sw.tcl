#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

# Create a new driver
create_driver reset_debouncer_driver

# Associate it with the hardware
set_sw_property hw_class_name reset_debouncer

set_sw_property version __VERSION_SHORT__
set_sw_property min_compatible_hw_version 1.0

# Do not initialize the driver in alt_sys_init()
set_sw_property auto_initialize false

# Location in generated BSP that sources will be copied into
set_sw_property bsp_subdirectory drivers

# Include files
add_sw_property include_source inc/reset_debouncer_regs.h

# This driver supports HAL & UCOSII & BML BSP (OS) types
add_sw_property supported_bsp_type HAL
add_sw_property supported_bsp_type UCOSII
add_sw_property supported_bsp_type BML

