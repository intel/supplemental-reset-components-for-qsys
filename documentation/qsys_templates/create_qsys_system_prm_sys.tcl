#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

# qsys scripting (.tcl) file for prm_sys
package require -exact qsys 16.0

create_system {prm_sys}

set_project_property DEVICE_FAMILY {Cyclone V}
set_project_property DEVICE {5CEBA2F17A7}
set_project_property HIDE_FROM_IP_CATALOG {false}

# Instances and instance parameters
# (disabled instances are intentionally culled)

#
# Manually reorder this list of component instances to reflect the order that
# you wish to see them appear in the Qsys GUI.
#
#-------------------------------------------------------------------------------

add_instance free_running_clock altera_clock_bridge
add_instance por power_on_reset
add_instance prm pll_reset_monitor
add_instance pll altera_pll
add_instance async_subsystem async_subsystem

#-------------------------------------------------------------------------------

# add_instance async_subsystem async_subsystem 1.0

# add_instance free_running_clock altera_clock_bridge 16.0
set_instance_parameter_value free_running_clock {EXPLICIT_CLOCK_RATE} {50000000.0}
set_instance_parameter_value free_running_clock {NUM_CLOCK_OUTPUTS} {1}

# add_instance pll altera_pll 16.0
set_instance_parameter_value pll {debug_print_output} {0}
set_instance_parameter_value pll {debug_use_rbc_taf_method} {0}
set_instance_parameter_value pll {gui_device_speed_grade} {1}
set_instance_parameter_value pll {gui_pll_mode} {Integer-N PLL}
set_instance_parameter_value pll {gui_reference_clock_frequency} {100.0}
set_instance_parameter_value pll {gui_channel_spacing} {0.0}
set_instance_parameter_value pll {gui_operation_mode} {direct}
set_instance_parameter_value pll {gui_feedback_clock} {Global Clock}
set_instance_parameter_value pll {gui_fractional_cout} {32}
set_instance_parameter_value pll {gui_dsm_out_sel} {1st_order}
set_instance_parameter_value pll {gui_use_locked} {1}
set_instance_parameter_value pll {gui_en_adv_params} {0}
set_instance_parameter_value pll {gui_number_of_clocks} {1}
set_instance_parameter_value pll {gui_multiply_factor} {1}
set_instance_parameter_value pll {gui_frac_multiply_factor} {1.0}
set_instance_parameter_value pll {gui_divide_factor_n} {1}
set_instance_parameter_value pll {gui_cascade_counter0} {0}
set_instance_parameter_value pll {gui_output_clock_frequency0} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c0} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency0} {0 MHz}
set_instance_parameter_value pll {gui_ps_units0} {ps}
set_instance_parameter_value pll {gui_phase_shift0} {0}
set_instance_parameter_value pll {gui_phase_shift_deg0} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift0} {0}
set_instance_parameter_value pll {gui_duty_cycle0} {50}
set_instance_parameter_value pll {gui_cascade_counter1} {0}
set_instance_parameter_value pll {gui_output_clock_frequency1} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c1} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency1} {0 MHz}
set_instance_parameter_value pll {gui_ps_units1} {ps}
set_instance_parameter_value pll {gui_phase_shift1} {0}
set_instance_parameter_value pll {gui_phase_shift_deg1} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift1} {0}
set_instance_parameter_value pll {gui_duty_cycle1} {50}
set_instance_parameter_value pll {gui_cascade_counter2} {0}
set_instance_parameter_value pll {gui_output_clock_frequency2} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c2} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency2} {0 MHz}
set_instance_parameter_value pll {gui_ps_units2} {ps}
set_instance_parameter_value pll {gui_phase_shift2} {0}
set_instance_parameter_value pll {gui_phase_shift_deg2} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift2} {0}
set_instance_parameter_value pll {gui_duty_cycle2} {50}
set_instance_parameter_value pll {gui_cascade_counter3} {0}
set_instance_parameter_value pll {gui_output_clock_frequency3} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c3} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency3} {0 MHz}
set_instance_parameter_value pll {gui_ps_units3} {ps}
set_instance_parameter_value pll {gui_phase_shift3} {0}
set_instance_parameter_value pll {gui_phase_shift_deg3} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift3} {0}
set_instance_parameter_value pll {gui_duty_cycle3} {50}
set_instance_parameter_value pll {gui_cascade_counter4} {0}
set_instance_parameter_value pll {gui_output_clock_frequency4} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c4} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency4} {0 MHz}
set_instance_parameter_value pll {gui_ps_units4} {ps}
set_instance_parameter_value pll {gui_phase_shift4} {0}
set_instance_parameter_value pll {gui_phase_shift_deg4} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift4} {0}
set_instance_parameter_value pll {gui_duty_cycle4} {50}
set_instance_parameter_value pll {gui_cascade_counter5} {0}
set_instance_parameter_value pll {gui_output_clock_frequency5} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c5} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency5} {0 MHz}
set_instance_parameter_value pll {gui_ps_units5} {ps}
set_instance_parameter_value pll {gui_phase_shift5} {0}
set_instance_parameter_value pll {gui_phase_shift_deg5} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift5} {0}
set_instance_parameter_value pll {gui_duty_cycle5} {50}
set_instance_parameter_value pll {gui_cascade_counter6} {0}
set_instance_parameter_value pll {gui_output_clock_frequency6} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c6} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency6} {0 MHz}
set_instance_parameter_value pll {gui_ps_units6} {ps}
set_instance_parameter_value pll {gui_phase_shift6} {0}
set_instance_parameter_value pll {gui_phase_shift_deg6} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift6} {0}
set_instance_parameter_value pll {gui_duty_cycle6} {50}
set_instance_parameter_value pll {gui_cascade_counter7} {0}
set_instance_parameter_value pll {gui_output_clock_frequency7} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c7} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency7} {0 MHz}
set_instance_parameter_value pll {gui_ps_units7} {ps}
set_instance_parameter_value pll {gui_phase_shift7} {0}
set_instance_parameter_value pll {gui_phase_shift_deg7} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift7} {0}
set_instance_parameter_value pll {gui_duty_cycle7} {50}
set_instance_parameter_value pll {gui_cascade_counter8} {0}
set_instance_parameter_value pll {gui_output_clock_frequency8} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c8} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency8} {0 MHz}
set_instance_parameter_value pll {gui_ps_units8} {ps}
set_instance_parameter_value pll {gui_phase_shift8} {0}
set_instance_parameter_value pll {gui_phase_shift_deg8} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift8} {0}
set_instance_parameter_value pll {gui_duty_cycle8} {50}
set_instance_parameter_value pll {gui_cascade_counter9} {0}
set_instance_parameter_value pll {gui_output_clock_frequency9} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c9} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency9} {0 MHz}
set_instance_parameter_value pll {gui_ps_units9} {ps}
set_instance_parameter_value pll {gui_phase_shift9} {0}
set_instance_parameter_value pll {gui_phase_shift_deg9} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift9} {0}
set_instance_parameter_value pll {gui_duty_cycle9} {50}
set_instance_parameter_value pll {gui_cascade_counter10} {0}
set_instance_parameter_value pll {gui_output_clock_frequency10} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c10} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency10} {0 MHz}
set_instance_parameter_value pll {gui_ps_units10} {ps}
set_instance_parameter_value pll {gui_phase_shift10} {0}
set_instance_parameter_value pll {gui_phase_shift_deg10} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift10} {0}
set_instance_parameter_value pll {gui_duty_cycle10} {50}
set_instance_parameter_value pll {gui_cascade_counter11} {0}
set_instance_parameter_value pll {gui_output_clock_frequency11} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c11} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency11} {0 MHz}
set_instance_parameter_value pll {gui_ps_units11} {ps}
set_instance_parameter_value pll {gui_phase_shift11} {0}
set_instance_parameter_value pll {gui_phase_shift_deg11} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift11} {0}
set_instance_parameter_value pll {gui_duty_cycle11} {50}
set_instance_parameter_value pll {gui_cascade_counter12} {0}
set_instance_parameter_value pll {gui_output_clock_frequency12} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c12} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency12} {0 MHz}
set_instance_parameter_value pll {gui_ps_units12} {ps}
set_instance_parameter_value pll {gui_phase_shift12} {0}
set_instance_parameter_value pll {gui_phase_shift_deg12} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift12} {0}
set_instance_parameter_value pll {gui_duty_cycle12} {50}
set_instance_parameter_value pll {gui_cascade_counter13} {0}
set_instance_parameter_value pll {gui_output_clock_frequency13} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c13} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency13} {0 MHz}
set_instance_parameter_value pll {gui_ps_units13} {ps}
set_instance_parameter_value pll {gui_phase_shift13} {0}
set_instance_parameter_value pll {gui_phase_shift_deg13} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift13} {0}
set_instance_parameter_value pll {gui_duty_cycle13} {50}
set_instance_parameter_value pll {gui_cascade_counter14} {0}
set_instance_parameter_value pll {gui_output_clock_frequency14} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c14} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency14} {0 MHz}
set_instance_parameter_value pll {gui_ps_units14} {ps}
set_instance_parameter_value pll {gui_phase_shift14} {0}
set_instance_parameter_value pll {gui_phase_shift_deg14} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift14} {0}
set_instance_parameter_value pll {gui_duty_cycle14} {50}
set_instance_parameter_value pll {gui_cascade_counter15} {0}
set_instance_parameter_value pll {gui_output_clock_frequency15} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c15} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency15} {0 MHz}
set_instance_parameter_value pll {gui_ps_units15} {ps}
set_instance_parameter_value pll {gui_phase_shift15} {0}
set_instance_parameter_value pll {gui_phase_shift_deg15} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift15} {0}
set_instance_parameter_value pll {gui_duty_cycle15} {50}
set_instance_parameter_value pll {gui_cascade_counter16} {0}
set_instance_parameter_value pll {gui_output_clock_frequency16} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c16} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency16} {0 MHz}
set_instance_parameter_value pll {gui_ps_units16} {ps}
set_instance_parameter_value pll {gui_phase_shift16} {0}
set_instance_parameter_value pll {gui_phase_shift_deg16} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift16} {0}
set_instance_parameter_value pll {gui_duty_cycle16} {50}
set_instance_parameter_value pll {gui_cascade_counter17} {0}
set_instance_parameter_value pll {gui_output_clock_frequency17} {100.0}
set_instance_parameter_value pll {gui_divide_factor_c17} {1}
set_instance_parameter_value pll {gui_actual_output_clock_frequency17} {0 MHz}
set_instance_parameter_value pll {gui_ps_units17} {ps}
set_instance_parameter_value pll {gui_phase_shift17} {0}
set_instance_parameter_value pll {gui_phase_shift_deg17} {0.0}
set_instance_parameter_value pll {gui_actual_phase_shift17} {0}
set_instance_parameter_value pll {gui_duty_cycle17} {50}
set_instance_parameter_value pll {gui_pll_auto_reset} {Off}
set_instance_parameter_value pll {gui_pll_bandwidth_preset} {Auto}
set_instance_parameter_value pll {gui_en_reconf} {0}
set_instance_parameter_value pll {gui_en_dps_ports} {0}
set_instance_parameter_value pll {gui_en_phout_ports} {0}
set_instance_parameter_value pll {gui_phout_division} {1}
set_instance_parameter_value pll {gui_mif_generate} {0}
set_instance_parameter_value pll {gui_enable_mif_dps} {0}
set_instance_parameter_value pll {gui_dps_cntr} {C0}
set_instance_parameter_value pll {gui_dps_num} {1}
set_instance_parameter_value pll {gui_dps_dir} {Positive}
set_instance_parameter_value pll {gui_refclk_switch} {0}
set_instance_parameter_value pll {gui_refclk1_frequency} {100.0}
set_instance_parameter_value pll {gui_switchover_mode} {Automatic Switchover}
set_instance_parameter_value pll {gui_switchover_delay} {0}
set_instance_parameter_value pll {gui_active_clk} {0}
set_instance_parameter_value pll {gui_clk_bad} {0}
set_instance_parameter_value pll {gui_enable_cascade_out} {0}
set_instance_parameter_value pll {gui_cascade_outclk_index} {0}
set_instance_parameter_value pll {gui_enable_cascade_in} {0}
set_instance_parameter_value pll {gui_pll_cascading_mode} {Create an adjpllin signal to connect with an upstream PLL}

# add_instance por power_on_reset 1.0
set_instance_parameter_value por {POR_COUNT} {20}

# add_instance prm pll_reset_monitor 1.0
set_instance_parameter_value prm {RESET_COUNTER_WIDTH} {5}
set_instance_parameter_value prm {LOCK_COUNTER_WIDTH} {16}
set_instance_parameter_value prm {PLL_LOCKED_CONDUIT_ROLE} {export}
set_instance_parameter_value prm {ENABLE_LOCK_SUCCESS_RESET} {1}
set_instance_parameter_value prm {LOCK_SUCCESS_RESET_ROLE} {0}
set_instance_parameter_value prm {ENABLE_LOCK_SUCCESS_CONDUIT} {0}
set_instance_parameter_value prm {LOCK_SUCCESS_CONDUIT_ROLE} {lock_success}
set_instance_parameter_value prm {ENABLE_LOCK_FAILURE_RESET} {1}
set_instance_parameter_value prm {LOCK_FAILURE_RESET_ROLE} {1}
set_instance_parameter_value prm {ENABLE_LOCK_FAILURE_CONDUIT} {0}
set_instance_parameter_value prm {LOCK_FAILURE_CONDUIT_ROLE} {lock_failure}

# exported interfaces
add_interface free_running_clock_in_clk clock sink
set_interface_property free_running_clock_in_clk EXPORT_OF free_running_clock.in_clk

# connections and connection parameters
add_connection async_subsystem.master_m0 prm.s0
set_connection_parameter_value async_subsystem.master_m0/prm.s0 arbitrationPriority {1}
set_connection_parameter_value async_subsystem.master_m0/prm.s0 baseAddress {0x0000}
set_connection_parameter_value async_subsystem.master_m0/prm.s0 defaultConnection {0}

add_connection free_running_clock.out_clk por.clock

add_connection free_running_clock.out_clk prm.pll_ref_clk

add_connection free_running_clock.out_clk pll.refclk

add_connection pll.outclk0 async_subsystem.cr_clk

add_connection pll.outclk0 prm.s0_clk

add_connection pll.locked prm.pll_locked
set_connection_parameter_value pll.locked/prm.pll_locked endPort {}
set_connection_parameter_value pll.locked/prm.pll_locked endPortLSB {0}
set_connection_parameter_value pll.locked/prm.pll_locked startPort {}
set_connection_parameter_value pll.locked/prm.pll_locked startPortLSB {0}
set_connection_parameter_value pll.locked/prm.pll_locked width {0}

add_connection prm.lock_failure_reset prm.pll_reset_request

add_connection prm.lock_success_reset async_subsystem.cr_reset

add_connection prm.lock_success_reset prm.s0_reset

add_connection prm.pll_reset pll.reset

add_connection por.reset prm.pll_reset_request

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}

save_system {prm_sys.qsys}
