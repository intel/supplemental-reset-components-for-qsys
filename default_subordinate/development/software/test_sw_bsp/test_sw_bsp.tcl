#
# Copyright (c) 2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

# Remove existing memory regions and section mappings
foreach region_info [get_current_memory_regions] {
    delete_memory_region [lindex $region_info 0]
}

foreach mapping_info [get_current_section_mappings] {
    delete_section_mapping [lindex $mapping_info 0]
}

# Settings
set_setting hal.enable_c_plus_plus {false}
set_setting hal.enable_clean_exit {false}
set_setting hal.enable_exit {false}
set_setting hal.enable_instruction_related_exceptions_api {false}
set_setting hal.enable_lightweight_device_driver_api {false}
set_setting hal.enable_reduced_device_drivers {false}
set_setting hal.enable_runtime_stack_checking {false}
set_setting hal.enable_sim_optimize {false}
set_setting hal.linker.allow_code_at_reset {true}
set_setting hal.linker.enable_alt_load {false}
set_setting hal.linker.enable_alt_load_copy_exceptions {false}
set_setting hal.linker.enable_alt_load_copy_rodata {false}
set_setting hal.linker.enable_alt_load_copy_rwdata {false}
set_setting hal.linker.enable_exception_stack {false}
set_setting hal.linker.exception_stack_memory_region_name {intel_onchip_memory_0}
set_setting hal.linker.exception_stack_size {1024}
set_setting hal.log_flags {0}
set_setting hal.log_port {none}
set_setting hal.make.ar {riscv-none-embed-ar}
set_setting hal.make.as {riscv-none-embed-gcc}
set_setting hal.make.asflags {-Wa,-gdwarf2}
set_setting hal.make.cc {riscv-none-embed-gcc}
set_setting hal.make.cflags_debug {-g}
set_setting hal.make.cflags_defined_symbols {none}
set_setting hal.make.cflags_optimization {-O2}
set_setting hal.make.cflags_undefined_symbols {none}
set_setting hal.make.cflags_user_flags {none}
set_setting hal.make.cflags_warnings {-Wall -Wformat-security}
set_setting hal.make.cxx {riscv-none-embed-g++}
set_setting hal.make.cxx_flags {none}
set_setting hal.make.enable_cflag_fstack_protector_strong {false}
set_setting hal.make.enable_cflag_wformat_security {false}
set_setting hal.make.objdump {riscv-none-embed-objdump}
set_setting hal.make.objdump_flags {-Sdtx}
set_setting hal.max_file_descriptors {32}
set_setting hal.stderr {none}
set_setting hal.stdin {none}
set_setting hal.stdout {none}
set_setting hal.sys_clk_timer {intel_niosv_m_0}
set_setting hal.timestamp_timer {intel_niosv_m_0}
set_setting intel_niosv_m_hal_driver.internal_timer_ticks_per_sec {1000}

# Software packages

# Drivers
set_driver intel_niosv_m_hal_driver intel_niosv_m_0

# User devices

# Linker memory regions
add_memory_region reset intel_onchip_memory_0 0 32
add_memory_region intel_onchip_memory_0 intel_onchip_memory_0 32 131040

# Linker section mappings
add_section_mapping .text intel_onchip_memory_0
add_section_mapping .rodata intel_onchip_memory_0
add_section_mapping .rwdata intel_onchip_memory_0
add_section_mapping .bss intel_onchip_memory_0
add_section_mapping .heap intel_onchip_memory_0
add_section_mapping .stack intel_onchip_memory_0
