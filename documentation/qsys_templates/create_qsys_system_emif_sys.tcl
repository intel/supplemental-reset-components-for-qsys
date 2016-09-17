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

# qsys scripting (.tcl) file for emif_sys
package require -exact qsys 16.0

create_system {emif_sys}

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

add_instance free_running_clock altera_clock_bridge 16.0
add_instance por power_on_reset 1.0
add_instance rad reset_assertion_delay 1.0
add_instance prm pll_reset_monitor 1.0
add_instance emif altera_mem_if_ddr3_emif 16.0
add_instance ps2pl pll_sharing_to_pll_locked 1.0
add_instance esb emif_status_breakout 1.0
add_instance et_cal event_timer 1.0
add_instance et_init event_timer 1.0
add_instance sync_subsystem sync_subsystem 1.0

#-------------------------------------------------------------------------------

# add_instance emif altera_mem_if_ddr3_emif 16.0
set_instance_parameter_value emif {MEM_VENDOR} {JEDEC}
set_instance_parameter_value emif {MEM_FORMAT} {DISCRETE}
set_instance_parameter_value emif {RDIMM_CONFIG} {0000000000000000}
set_instance_parameter_value emif {LRDIMM_EXTENDED_CONFIG} {0x000000000000000000}
set_instance_parameter_value emif {DISCRETE_FLY_BY} {1}
set_instance_parameter_value emif {DEVICE_DEPTH} {1}
set_instance_parameter_value emif {MEM_MIRROR_ADDRESSING} {0}
set_instance_parameter_value emif {MEM_CLK_FREQ_MAX} {400.0}
set_instance_parameter_value emif {MEM_ROW_ADDR_WIDTH} {12}
set_instance_parameter_value emif {MEM_COL_ADDR_WIDTH} {8}
set_instance_parameter_value emif {MEM_DQ_WIDTH} {8}
set_instance_parameter_value emif {MEM_DQ_PER_DQS} {8}
set_instance_parameter_value emif {MEM_BANKADDR_WIDTH} {3}
set_instance_parameter_value emif {MEM_IF_DM_PINS_EN} {1}
set_instance_parameter_value emif {MEM_IF_DQSN_EN} {1}
set_instance_parameter_value emif {MEM_NUMBER_OF_DIMMS} {1}
set_instance_parameter_value emif {MEM_NUMBER_OF_RANKS_PER_DIMM} {1}
set_instance_parameter_value emif {MEM_NUMBER_OF_RANKS_PER_DEVICE} {1}
set_instance_parameter_value emif {MEM_RANK_MULTIPLICATION_FACTOR} {1}
set_instance_parameter_value emif {MEM_CK_WIDTH} {1}
set_instance_parameter_value emif {MEM_CS_WIDTH} {1}
set_instance_parameter_value emif {MEM_CLK_EN_WIDTH} {1}
set_instance_parameter_value emif {ALTMEMPHY_COMPATIBLE_MODE} {0}
set_instance_parameter_value emif {NEXTGEN} {1}
set_instance_parameter_value emif {MEM_IF_BOARD_BASE_DELAY} {10}
set_instance_parameter_value emif {MEM_IF_SIM_VALID_WINDOW} {0}
set_instance_parameter_value emif {MEM_GUARANTEED_WRITE_INIT} {0}
set_instance_parameter_value emif {MEM_VERBOSE} {1}
set_instance_parameter_value emif {PINGPONGPHY_EN} {0}
set_instance_parameter_value emif {DUPLICATE_AC} {0}
set_instance_parameter_value emif {REFRESH_BURST_VALIDATION} {0}
set_instance_parameter_value emif {AP_MODE_EN} {0}
set_instance_parameter_value emif {AP_MODE} {0}
set_instance_parameter_value emif {MEM_BL} {OTF}
set_instance_parameter_value emif {MEM_BT} {Sequential}
set_instance_parameter_value emif {MEM_ASR} {Manual}
set_instance_parameter_value emif {MEM_SRT} {Normal}
set_instance_parameter_value emif {MEM_PD} {DLL off}
set_instance_parameter_value emif {MEM_DRV_STR} {RZQ/6}
set_instance_parameter_value emif {MEM_DLL_EN} {1}
set_instance_parameter_value emif {MEM_RTT_NOM} {ODT Disabled}
set_instance_parameter_value emif {MEM_RTT_WR} {Dynamic ODT off}
set_instance_parameter_value emif {MEM_WTCL} {6}
set_instance_parameter_value emif {MEM_ATCL} {Disabled}
set_instance_parameter_value emif {MEM_TCL} {7}
set_instance_parameter_value emif {MEM_AUTO_LEVELING_MODE} {1}
set_instance_parameter_value emif {MEM_USER_LEVELING_MODE} {Leveling}
set_instance_parameter_value emif {MEM_INIT_EN} {0}
set_instance_parameter_value emif {MEM_INIT_FILE} {}
set_instance_parameter_value emif {DAT_DATA_WIDTH} {32}
set_instance_parameter_value emif {TIMING_TIS} {175}
set_instance_parameter_value emif {TIMING_TIH} {250}
set_instance_parameter_value emif {TIMING_TDS} {50}
set_instance_parameter_value emif {TIMING_TDH} {125}
set_instance_parameter_value emif {TIMING_TDQSQ} {120}
set_instance_parameter_value emif {TIMING_TQH} {0.38}
set_instance_parameter_value emif {TIMING_TDQSCK} {400}
set_instance_parameter_value emif {TIMING_TDQSCKDS} {450}
set_instance_parameter_value emif {TIMING_TDQSCKDM} {900}
set_instance_parameter_value emif {TIMING_TDQSCKDL} {1200}
set_instance_parameter_value emif {TIMING_TDQSS} {0.25}
set_instance_parameter_value emif {TIMING_TQSH} {0.38}
set_instance_parameter_value emif {TIMING_TDSH} {0.2}
set_instance_parameter_value emif {TIMING_TDSS} {0.2}
set_instance_parameter_value emif {MEM_TINIT_US} {499}
set_instance_parameter_value emif {MEM_TMRD_CK} {3}
set_instance_parameter_value emif {MEM_TRAS_NS} {40.0}
set_instance_parameter_value emif {MEM_TRCD_NS} {15.0}
set_instance_parameter_value emif {MEM_TRP_NS} {15.0}
set_instance_parameter_value emif {MEM_TREFI_US} {7.0}
set_instance_parameter_value emif {MEM_TRFC_NS} {75.0}
set_instance_parameter_value emif {CFG_TCCD_NS} {2.5}
set_instance_parameter_value emif {MEM_TWR_NS} {15.0}
set_instance_parameter_value emif {MEM_TWTR} {2}
set_instance_parameter_value emif {MEM_TFAW_NS} {37.5}
set_instance_parameter_value emif {MEM_TRRD_NS} {7.5}
set_instance_parameter_value emif {MEM_TRTP_NS} {7.5}
set_instance_parameter_value emif {RATE} {Full}
set_instance_parameter_value emif {MEM_CLK_FREQ} {300.0}
set_instance_parameter_value emif {USE_MEM_CLK_FREQ} {0}
set_instance_parameter_value emif {FORCE_DQS_TRACKING} {AUTO}
set_instance_parameter_value emif {FORCE_SHADOW_REGS} {AUTO}
set_instance_parameter_value emif {MRS_MIRROR_PING_PONG_ATSO} {0}
set_instance_parameter_value emif {PARSE_FRIENDLY_DEVICE_FAMILY_PARAM_VALID} {0}
set_instance_parameter_value emif {PARSE_FRIENDLY_DEVICE_FAMILY_PARAM} {}
set_instance_parameter_value emif {DEVICE_FAMILY_PARAM} {}
set_instance_parameter_value emif {SPEED_GRADE} {7}
set_instance_parameter_value emif {IS_ES_DEVICE} {0}
set_instance_parameter_value emif {DISABLE_CHILD_MESSAGING} {0}
set_instance_parameter_value emif {HARD_EMIF} {1}
set_instance_parameter_value emif {HHP_HPS} {0}
set_instance_parameter_value emif {HHP_HPS_VERIFICATION} {0}
set_instance_parameter_value emif {HHP_HPS_SIMULATION} {0}
set_instance_parameter_value emif {HPS_PROTOCOL} {DEFAULT}
set_instance_parameter_value emif {CUT_NEW_FAMILY_TIMING} {1}
set_instance_parameter_value emif {POWER_OF_TWO_BUS} {0}
set_instance_parameter_value emif {SOPC_COMPAT_RESET} {0}
set_instance_parameter_value emif {AVL_MAX_SIZE} {4}
set_instance_parameter_value emif {BYTE_ENABLE} {1}
set_instance_parameter_value emif {ENABLE_CTRL_AVALON_INTERFACE} {1}
set_instance_parameter_value emif {CTL_DEEP_POWERDN_EN} {0}
set_instance_parameter_value emif {CTL_SELF_REFRESH_EN} {0}
set_instance_parameter_value emif {AUTO_POWERDN_EN} {0}
set_instance_parameter_value emif {AUTO_PD_CYCLES} {0}
set_instance_parameter_value emif {CTL_USR_REFRESH_EN} {0}
set_instance_parameter_value emif {CTL_AUTOPCH_EN} {0}
set_instance_parameter_value emif {CTL_ZQCAL_EN} {0}
set_instance_parameter_value emif {ADDR_ORDER} {0}
set_instance_parameter_value emif {CTL_LOOK_AHEAD_DEPTH} {4}
set_instance_parameter_value emif {CONTROLLER_LATENCY} {5}
set_instance_parameter_value emif {CFG_REORDER_DATA} {1}
set_instance_parameter_value emif {STARVE_LIMIT} {10}
set_instance_parameter_value emif {CTL_CSR_ENABLED} {0}
set_instance_parameter_value emif {CTL_CSR_CONNECTION} {INTERNAL_JTAG}
set_instance_parameter_value emif {CTL_ECC_ENABLED} {0}
set_instance_parameter_value emif {CTL_HRB_ENABLED} {0}
set_instance_parameter_value emif {CTL_ECC_AUTO_CORRECTION_ENABLED} {0}
set_instance_parameter_value emif {MULTICAST_EN} {0}
set_instance_parameter_value emif {CTL_DYNAMIC_BANK_ALLOCATION} {0}
set_instance_parameter_value emif {CTL_DYNAMIC_BANK_NUM} {4}
set_instance_parameter_value emif {DEBUG_MODE} {0}
set_instance_parameter_value emif {ENABLE_BURST_MERGE} {0}
set_instance_parameter_value emif {CTL_ENABLE_BURST_INTERRUPT} {0}
set_instance_parameter_value emif {CTL_ENABLE_BURST_TERMINATE} {0}
set_instance_parameter_value emif {LOCAL_ID_WIDTH} {8}
set_instance_parameter_value emif {WRBUFFER_ADDR_WIDTH} {6}
set_instance_parameter_value emif {MAX_PENDING_WR_CMD} {16}
set_instance_parameter_value emif {MAX_PENDING_RD_CMD} {32}
set_instance_parameter_value emif {USE_MM_ADAPTOR} {1}
set_instance_parameter_value emif {USE_AXI_ADAPTOR} {0}
set_instance_parameter_value emif {HCX_COMPAT_MODE} {0}
set_instance_parameter_value emif {CTL_CMD_QUEUE_DEPTH} {8}
set_instance_parameter_value emif {CTL_CSR_READ_ONLY} {1}
set_instance_parameter_value emif {CFG_DATA_REORDERING_TYPE} {INTER_BANK}
set_instance_parameter_value emif {NUM_OF_PORTS} {1}
set_instance_parameter_value emif {ENABLE_BONDING} {0}
set_instance_parameter_value emif {ENABLE_USER_ECC} {0}
set_instance_parameter_value emif {AVL_DATA_WIDTH_PORT} {32 32 32 32 32 32}
set_instance_parameter_value emif {PRIORITY_PORT} {1 1 1 1 1 1}
set_instance_parameter_value emif {WEIGHT_PORT} {0 0 0 0 0 0}
set_instance_parameter_value emif {CPORT_TYPE_PORT} {Bidirectional Bidirectional Bidirectional Bidirectional Bidirectional Bidirectional}
set_instance_parameter_value emif {ENABLE_EMIT_BFM_MASTER} {0}
set_instance_parameter_value emif {FORCE_SEQUENCER_TCL_DEBUG_MODE} {0}
set_instance_parameter_value emif {ENABLE_SEQUENCER_MARGINING_ON_BY_DEFAULT} {0}
set_instance_parameter_value emif {REF_CLK_FREQ} {125.0}
set_instance_parameter_value emif {REF_CLK_FREQ_PARAM_VALID} {0}
set_instance_parameter_value emif {REF_CLK_FREQ_MIN_PARAM} {0.0}
set_instance_parameter_value emif {REF_CLK_FREQ_MAX_PARAM} {0.0}
set_instance_parameter_value emif {PLL_DR_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value emif {PLL_DR_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_DR_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value emif {PLL_DR_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_DR_CLK_MULT_PARAM} {0}
set_instance_parameter_value emif {PLL_DR_CLK_DIV_PARAM} {0}
set_instance_parameter_value emif {PLL_MEM_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value emif {PLL_MEM_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_MEM_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value emif {PLL_MEM_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_MEM_CLK_MULT_PARAM} {0}
set_instance_parameter_value emif {PLL_MEM_CLK_DIV_PARAM} {0}
set_instance_parameter_value emif {PLL_AFI_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value emif {PLL_AFI_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_AFI_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value emif {PLL_AFI_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_AFI_CLK_MULT_PARAM} {0}
set_instance_parameter_value emif {PLL_AFI_CLK_DIV_PARAM} {0}
set_instance_parameter_value emif {PLL_WRITE_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value emif {PLL_WRITE_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_WRITE_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value emif {PLL_WRITE_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_WRITE_CLK_MULT_PARAM} {0}
set_instance_parameter_value emif {PLL_WRITE_CLK_DIV_PARAM} {0}
set_instance_parameter_value emif {PLL_ADDR_CMD_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value emif {PLL_ADDR_CMD_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_ADDR_CMD_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value emif {PLL_ADDR_CMD_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_ADDR_CMD_CLK_MULT_PARAM} {0}
set_instance_parameter_value emif {PLL_ADDR_CMD_CLK_DIV_PARAM} {0}
set_instance_parameter_value emif {PLL_AFI_HALF_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value emif {PLL_AFI_HALF_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_AFI_HALF_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value emif {PLL_AFI_HALF_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_AFI_HALF_CLK_MULT_PARAM} {0}
set_instance_parameter_value emif {PLL_AFI_HALF_CLK_DIV_PARAM} {0}
set_instance_parameter_value emif {PLL_NIOS_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value emif {PLL_NIOS_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_NIOS_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value emif {PLL_NIOS_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_NIOS_CLK_MULT_PARAM} {0}
set_instance_parameter_value emif {PLL_NIOS_CLK_DIV_PARAM} {0}
set_instance_parameter_value emif {PLL_CONFIG_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value emif {PLL_CONFIG_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_CONFIG_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value emif {PLL_CONFIG_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_CONFIG_CLK_MULT_PARAM} {0}
set_instance_parameter_value emif {PLL_CONFIG_CLK_DIV_PARAM} {0}
set_instance_parameter_value emif {PLL_P2C_READ_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value emif {PLL_P2C_READ_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_P2C_READ_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value emif {PLL_P2C_READ_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_P2C_READ_CLK_MULT_PARAM} {0}
set_instance_parameter_value emif {PLL_P2C_READ_CLK_DIV_PARAM} {0}
set_instance_parameter_value emif {PLL_C2P_WRITE_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value emif {PLL_C2P_WRITE_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_C2P_WRITE_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value emif {PLL_C2P_WRITE_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_C2P_WRITE_CLK_MULT_PARAM} {0}
set_instance_parameter_value emif {PLL_C2P_WRITE_CLK_DIV_PARAM} {0}
set_instance_parameter_value emif {PLL_HR_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value emif {PLL_HR_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_HR_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value emif {PLL_HR_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_HR_CLK_MULT_PARAM} {0}
set_instance_parameter_value emif {PLL_HR_CLK_DIV_PARAM} {0}
set_instance_parameter_value emif {PLL_AFI_PHY_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value emif {PLL_AFI_PHY_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_AFI_PHY_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value emif {PLL_AFI_PHY_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value emif {PLL_AFI_PHY_CLK_MULT_PARAM} {0}
set_instance_parameter_value emif {PLL_AFI_PHY_CLK_DIV_PARAM} {0}
set_instance_parameter_value emif {PLL_CLK_PARAM_VALID} {0}
set_instance_parameter_value emif {ENABLE_EXTRA_REPORTING} {0}
set_instance_parameter_value emif {NUM_EXTRA_REPORT_PATH} {10}
set_instance_parameter_value emif {ENABLE_ISS_PROBES} {0}
set_instance_parameter_value emif {CALIB_REG_WIDTH} {8}
set_instance_parameter_value emif {USE_SEQUENCER_BFM} {0}
set_instance_parameter_value emif {PLL_SHARING_MODE} {None}
set_instance_parameter_value emif {NUM_PLL_SHARING_INTERFACES} {1}
set_instance_parameter_value emif {EXPORT_AFI_HALF_CLK} {0}
set_instance_parameter_value emif {ABSTRACT_REAL_COMPARE_TEST} {0}
set_instance_parameter_value emif {INCLUDE_BOARD_DELAY_MODEL} {0}
set_instance_parameter_value emif {INCLUDE_MULTIRANK_BOARD_DELAY_MODEL} {0}
set_instance_parameter_value emif {USE_FAKE_PHY} {0}
set_instance_parameter_value emif {FORCE_MAX_LATENCY_COUNT_WIDTH} {0}
set_instance_parameter_value emif {ENABLE_NON_DESTRUCTIVE_CALIB} {0}
set_instance_parameter_value emif {FIX_READ_LATENCY} {8}
set_instance_parameter_value emif {ENABLE_DELAY_CHAIN_WRITE} {0}
set_instance_parameter_value emif {TRACKING_ERROR_TEST} {0}
set_instance_parameter_value emif {TRACKING_WATCH_TEST} {0}
set_instance_parameter_value emif {MARGIN_VARIATION_TEST} {0}
set_instance_parameter_value emif {AC_ROM_USER_ADD_0} {0_0000_0000_0000}
set_instance_parameter_value emif {AC_ROM_USER_ADD_1} {0_0000_0000_1000}
set_instance_parameter_value emif {TREFI} {35100}
set_instance_parameter_value emif {REFRESH_INTERVAL} {15000}
set_instance_parameter_value emif {ENABLE_NON_DES_CAL_TEST} {0}
set_instance_parameter_value emif {TRFC} {350}
set_instance_parameter_value emif {ENABLE_NON_DES_CAL} {0}
set_instance_parameter_value emif {EXTRA_SETTINGS} {}
set_instance_parameter_value emif {MEM_DEVICE} {MISSING_MODEL}
set_instance_parameter_value emif {FORCE_SYNTHESIS_LANGUAGE} {}
set_instance_parameter_value emif {FORCED_NUM_WRITE_FR_CYCLE_SHIFTS} {0}
set_instance_parameter_value emif {SEQUENCER_TYPE} {NIOS}
set_instance_parameter_value emif {ADVERTIZE_SEQUENCER_SW_BUILD_FILES} {0}
set_instance_parameter_value emif {FORCED_NON_LDC_ADDR_CMD_MEM_CK_INVERT} {0}
set_instance_parameter_value emif {PHY_ONLY} {0}
set_instance_parameter_value emif {SEQ_MODE} {0}
set_instance_parameter_value emif {ADVANCED_CK_PHASES} {0}
set_instance_parameter_value emif {COMMAND_PHASE} {0.0}
set_instance_parameter_value emif {MEM_CK_PHASE} {0.0}
set_instance_parameter_value emif {P2C_READ_CLOCK_ADD_PHASE} {0.0}
set_instance_parameter_value emif {C2P_WRITE_CLOCK_ADD_PHASE} {0.0}
set_instance_parameter_value emif {ACV_PHY_CLK_ADD_FR_PHASE} {0.0}
set_instance_parameter_value emif {MEM_VOLTAGE} {1.5V DDR3}
set_instance_parameter_value emif {PLL_LOCATION} {Top_Bottom}
set_instance_parameter_value emif {SKIP_MEM_INIT} {1}
set_instance_parameter_value emif {READ_DQ_DQS_CLOCK_SOURCE} {INVERTED_DQS_BUS}
set_instance_parameter_value emif {DQ_INPUT_REG_USE_CLKN} {0}
set_instance_parameter_value emif {DQS_DQSN_MODE} {DIFFERENTIAL}
set_instance_parameter_value emif {AFI_DEBUG_INFO_WIDTH} {32}
set_instance_parameter_value emif {CALIBRATION_MODE} {Skip}
set_instance_parameter_value emif {NIOS_ROM_DATA_WIDTH} {32}
set_instance_parameter_value emif {READ_FIFO_SIZE} {8}
set_instance_parameter_value emif {PHY_CSR_ENABLED} {0}
set_instance_parameter_value emif {PHY_CSR_CONNECTION} {INTERNAL_JTAG}
set_instance_parameter_value emif {USER_DEBUG_LEVEL} {1}
set_instance_parameter_value emif {TIMING_BOARD_DERATE_METHOD} {AUTO}
set_instance_parameter_value emif {TIMING_BOARD_CK_CKN_SLEW_RATE} {2.0}
set_instance_parameter_value emif {TIMING_BOARD_AC_SLEW_RATE} {1.0}
set_instance_parameter_value emif {TIMING_BOARD_DQS_DQSN_SLEW_RATE} {2.0}
set_instance_parameter_value emif {TIMING_BOARD_DQ_SLEW_RATE} {1.0}
set_instance_parameter_value emif {TIMING_BOARD_TIS} {0.0}
set_instance_parameter_value emif {TIMING_BOARD_TIH} {0.0}
set_instance_parameter_value emif {TIMING_BOARD_TDS} {0.0}
set_instance_parameter_value emif {TIMING_BOARD_TDH} {0.0}
set_instance_parameter_value emif {TIMING_BOARD_ISI_METHOD} {AUTO}
set_instance_parameter_value emif {TIMING_BOARD_AC_EYE_REDUCTION_SU} {0.0}
set_instance_parameter_value emif {TIMING_BOARD_AC_EYE_REDUCTION_H} {0.0}
set_instance_parameter_value emif {TIMING_BOARD_DQ_EYE_REDUCTION} {0.0}
set_instance_parameter_value emif {TIMING_BOARD_DELTA_DQS_ARRIVAL_TIME} {0.0}
set_instance_parameter_value emif {TIMING_BOARD_READ_DQ_EYE_REDUCTION} {0.0}
set_instance_parameter_value emif {TIMING_BOARD_DELTA_READ_DQS_ARRIVAL_TIME} {0.0}
set_instance_parameter_value emif {PACKAGE_DESKEW} {0}
set_instance_parameter_value emif {AC_PACKAGE_DESKEW} {0}
set_instance_parameter_value emif {TIMING_BOARD_MAX_CK_DELAY} {0.6}
set_instance_parameter_value emif {TIMING_BOARD_MAX_DQS_DELAY} {0.6}
set_instance_parameter_value emif {TIMING_BOARD_SKEW_CKDQS_DIMM_MIN} {-0.01}
set_instance_parameter_value emif {TIMING_BOARD_SKEW_CKDQS_DIMM_MAX} {0.01}
set_instance_parameter_value emif {TIMING_BOARD_SKEW_BETWEEN_DIMMS} {0.05}
set_instance_parameter_value emif {TIMING_BOARD_SKEW_WITHIN_DQS} {0.02}
set_instance_parameter_value emif {TIMING_BOARD_SKEW_BETWEEN_DQS} {0.02}
set_instance_parameter_value emif {TIMING_BOARD_DQ_TO_DQS_SKEW} {0.0}
set_instance_parameter_value emif {TIMING_BOARD_AC_SKEW} {0.02}
set_instance_parameter_value emif {TIMING_BOARD_AC_TO_CK_SKEW} {0.0}
set_instance_parameter_value emif {ENABLE_EXPORT_SEQ_DEBUG_BRIDGE} {0}
set_instance_parameter_value emif {CORE_DEBUG_CONNECTION} {EXPORT}
set_instance_parameter_value emif {ADD_EXTERNAL_SEQ_DEBUG_NIOS} {0}
set_instance_parameter_value emif {ED_EXPORT_SEQ_DEBUG} {0}
set_instance_parameter_value emif {ADD_EFFICIENCY_MONITOR} {0}
set_instance_parameter_value emif {ENABLE_ABS_RAM_MEM_INIT} {0}
set_instance_parameter_value emif {ABS_RAM_MEM_INIT_FILENAME} {meminit}
set_instance_parameter_value emif {DLL_SHARING_MODE} {None}
set_instance_parameter_value emif {NUM_DLL_SHARING_INTERFACES} {1}
set_instance_parameter_value emif {OCT_SHARING_MODE} {None}
set_instance_parameter_value emif {NUM_OCT_SHARING_INTERFACES} {1}

# add_instance esb emif_status_breakout 1.0

# add_instance et_cal event_timer 1.0
set_instance_parameter_value et_cal {TIMEOUT_COUNTER_WIDTH} {24}
set_instance_parameter_value et_cal {EVENT_INPUT_CONDUIT_ROLE} {event_input}
set_instance_parameter_value et_cal {ENABLE_ACQUIRED_RESET} {1}
set_instance_parameter_value et_cal {ACQUIRED_RESET_ROLE} {0}
set_instance_parameter_value et_cal {ENABLE_ACQUIRED_CONDUIT} {0}
set_instance_parameter_value et_cal {ACQUIRED_CONDUIT_ROLE} {acquired}
set_instance_parameter_value et_cal {ENABLE_LOST_RESET} {1}
set_instance_parameter_value et_cal {LOST_RESET_ROLE} {1}
set_instance_parameter_value et_cal {ENABLE_LOST_CONDUIT} {0}
set_instance_parameter_value et_cal {LOST_CONDUIT_ROLE} {lost}
set_instance_parameter_value et_cal {ENABLE_TIMEOUT_RESET} {1}
set_instance_parameter_value et_cal {TIMEOUT_RESET_ROLE} {1}
set_instance_parameter_value et_cal {ENABLE_TIMEOUT_CONDUIT} {0}
set_instance_parameter_value et_cal {TIMEOUT_CONDUIT_ROLE} {timeout}

# add_instance et_init event_timer 1.0
set_instance_parameter_value et_init {TIMEOUT_COUNTER_WIDTH} {4}
set_instance_parameter_value et_init {EVENT_INPUT_CONDUIT_ROLE} {event_input}
set_instance_parameter_value et_init {ENABLE_ACQUIRED_RESET} {1}
set_instance_parameter_value et_init {ACQUIRED_RESET_ROLE} {0}
set_instance_parameter_value et_init {ENABLE_ACQUIRED_CONDUIT} {0}
set_instance_parameter_value et_init {ACQUIRED_CONDUIT_ROLE} {acquired}
set_instance_parameter_value et_init {ENABLE_LOST_RESET} {1}
set_instance_parameter_value et_init {LOST_RESET_ROLE} {1}
set_instance_parameter_value et_init {ENABLE_LOST_CONDUIT} {0}
set_instance_parameter_value et_init {LOST_CONDUIT_ROLE} {lost}
set_instance_parameter_value et_init {ENABLE_TIMEOUT_RESET} {1}
set_instance_parameter_value et_init {TIMEOUT_RESET_ROLE} {1}
set_instance_parameter_value et_init {ENABLE_TIMEOUT_CONDUIT} {0}
set_instance_parameter_value et_init {TIMEOUT_CONDUIT_ROLE} {timeout}

# add_instance free_running_clock altera_clock_bridge 16.0
set_instance_parameter_value free_running_clock {EXPLICIT_CLOCK_RATE} {50000000.0}
set_instance_parameter_value free_running_clock {NUM_CLOCK_OUTPUTS} {1}

# add_instance por power_on_reset 1.0
set_instance_parameter_value por {POR_COUNT} {20}

# add_instance prm pll_reset_monitor 1.0
set_instance_parameter_value prm {RESET_COUNTER_WIDTH} {10}
set_instance_parameter_value prm {LOCK_COUNTER_WIDTH} {16}
set_instance_parameter_value prm {PLL_LOCKED_CONDUIT_ROLE} {pll_locked}
set_instance_parameter_value prm {ENABLE_LOCK_SUCCESS_RESET} {1}
set_instance_parameter_value prm {LOCK_SUCCESS_RESET_ROLE} {0}
set_instance_parameter_value prm {ENABLE_LOCK_SUCCESS_CONDUIT} {0}
set_instance_parameter_value prm {LOCK_SUCCESS_CONDUIT_ROLE} {lock_success}
set_instance_parameter_value prm {ENABLE_LOCK_FAILURE_RESET} {1}
set_instance_parameter_value prm {LOCK_FAILURE_RESET_ROLE} {1}
set_instance_parameter_value prm {ENABLE_LOCK_FAILURE_CONDUIT} {0}
set_instance_parameter_value prm {LOCK_FAILURE_CONDUIT_ROLE} {lock_failure}

# add_instance ps2pl pll_sharing_to_pll_locked 1.0

# add_instance rad reset_assertion_delay 1.0
set_instance_parameter_value rad {DELAY_COUNTER_WIDTH} {5}

# add_instance sync_subsystem sync_subsystem 1.0

# exported interfaces
add_interface free_running_clock_in_clk clock sink
set_interface_property free_running_clock_in_clk EXPORT_OF free_running_clock.in_clk
add_interface memory conduit end
set_interface_property memory EXPORT_OF emif.memory
add_interface oct conduit end
set_interface_property oct EXPORT_OF emif.oct

# connections and connection parameters
add_connection sync_subsystem.master_m0 emif.avl_0
set_connection_parameter_value sync_subsystem.master_m0/emif.avl_0 arbitrationPriority {1}
set_connection_parameter_value sync_subsystem.master_m0/emif.avl_0 baseAddress {0x0000}
set_connection_parameter_value sync_subsystem.master_m0/emif.avl_0 defaultConnection {0}

add_connection sync_subsystem.master_m0 prm.s0
set_connection_parameter_value sync_subsystem.master_m0/prm.s0 arbitrationPriority {1}
set_connection_parameter_value sync_subsystem.master_m0/prm.s0 baseAddress {0x00800008}
set_connection_parameter_value sync_subsystem.master_m0/prm.s0 defaultConnection {0}

add_connection sync_subsystem.master_m0 et_cal.s0
set_connection_parameter_value sync_subsystem.master_m0/et_cal.s0 arbitrationPriority {1}
set_connection_parameter_value sync_subsystem.master_m0/et_cal.s0 baseAddress {0x00800004}
set_connection_parameter_value sync_subsystem.master_m0/et_cal.s0 defaultConnection {0}

add_connection sync_subsystem.master_m0 et_init.s0
set_connection_parameter_value sync_subsystem.master_m0/et_init.s0 arbitrationPriority {1}
set_connection_parameter_value sync_subsystem.master_m0/et_init.s0 baseAddress {0x00800000}
set_connection_parameter_value sync_subsystem.master_m0/et_init.s0 defaultConnection {0}

add_connection emif.afi_half_clk sync_subsystem.cr_clk

add_connection emif.afi_half_clk emif.mp_cmd_clk_0

add_connection emif.afi_half_clk emif.mp_rfifo_clk_0

add_connection emif.afi_half_clk emif.mp_wfifo_clk_0

add_connection emif.afi_half_clk prm.s0_clk

add_connection emif.afi_half_clk et_cal.s0_clk

add_connection emif.afi_half_clk et_init.s0_clk

add_connection free_running_clock.out_clk por.clock

add_connection free_running_clock.out_clk rad.clock

add_connection free_running_clock.out_clk et_cal.event_clk

add_connection free_running_clock.out_clk et_init.event_clk

add_connection free_running_clock.out_clk prm.pll_ref_clk

add_connection free_running_clock.out_clk emif.pll_ref_clk

add_connection esb.cal_success et_cal.event_input
set_connection_parameter_value esb.cal_success/et_cal.event_input endPort {}
set_connection_parameter_value esb.cal_success/et_cal.event_input endPortLSB {0}
set_connection_parameter_value esb.cal_success/et_cal.event_input startPort {}
set_connection_parameter_value esb.cal_success/et_cal.event_input startPortLSB {0}
set_connection_parameter_value esb.cal_success/et_cal.event_input width {0}

add_connection esb.init_done et_init.event_input
set_connection_parameter_value esb.init_done/et_init.event_input endPort {}
set_connection_parameter_value esb.init_done/et_init.event_input endPortLSB {0}
set_connection_parameter_value esb.init_done/et_init.event_input startPort {}
set_connection_parameter_value esb.init_done/et_init.event_input startPortLSB {0}
set_connection_parameter_value esb.init_done/et_init.event_input width {0}

add_connection prm.pll_locked ps2pl.pll_locked
set_connection_parameter_value prm.pll_locked/ps2pl.pll_locked endPort {}
set_connection_parameter_value prm.pll_locked/ps2pl.pll_locked endPortLSB {0}
set_connection_parameter_value prm.pll_locked/ps2pl.pll_locked startPort {}
set_connection_parameter_value prm.pll_locked/ps2pl.pll_locked startPortLSB {0}
set_connection_parameter_value prm.pll_locked/ps2pl.pll_locked width {0}

add_connection emif.pll_sharing ps2pl.pll_sharing
set_connection_parameter_value emif.pll_sharing/ps2pl.pll_sharing endPort {}
set_connection_parameter_value emif.pll_sharing/ps2pl.pll_sharing endPortLSB {0}
set_connection_parameter_value emif.pll_sharing/ps2pl.pll_sharing startPort {}
set_connection_parameter_value emif.pll_sharing/ps2pl.pll_sharing startPortLSB {0}
set_connection_parameter_value emif.pll_sharing/ps2pl.pll_sharing width {0}

add_connection emif.status esb.status
set_connection_parameter_value emif.status/esb.status endPort {}
set_connection_parameter_value emif.status/esb.status endPortLSB {0}
set_connection_parameter_value emif.status/esb.status startPort {}
set_connection_parameter_value emif.status/esb.status startPortLSB {0}
set_connection_parameter_value emif.status/esb.status width {0}

add_connection et_init.acquired_reset sync_subsystem.cr_reset

add_connection et_cal.acquired_reset et_init.event_reset

add_connection et_cal.acquired_reset emif.mp_cmd_reset_n_0

add_connection et_cal.acquired_reset emif.mp_rfifo_reset_n_0

add_connection et_cal.acquired_reset emif.mp_wfifo_reset_n_0

add_connection et_init.acquired_reset prm.s0_reset

add_connection et_init.acquired_reset et_cal.s0_reset

add_connection et_init.acquired_reset et_init.s0_reset

add_connection emif.afi_reset et_cal.event_reset

add_connection esb.cal_fail rad.reset_input

add_connection prm.lock_failure_reset rad.reset_input

add_connection prm.lock_success_reset emif.soft_reset

add_connection et_cal.lost_reset rad.reset_input

add_connection et_init.lost_reset rad.reset_input

add_connection prm.pll_reset emif.global_reset

add_connection por.reset rad.power_on_reset

add_connection rad.reset_output sync_subsystem.cr_reset

add_connection rad.reset_output emif.mp_cmd_reset_n_0

add_connection rad.reset_output emif.mp_rfifo_reset_n_0

add_connection rad.reset_output emif.mp_wfifo_reset_n_0

add_connection rad.reset_output prm.s0_reset

add_connection rad.reset_output et_cal.s0_reset

add_connection rad.reset_output et_init.s0_reset

add_connection rad.reset_output emif.soft_reset

add_connection rad.reset_output_delayed prm.pll_reset_request

add_connection et_cal.timeout_reset rad.reset_input

add_connection et_init.timeout_reset rad.reset_input

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}

save_system {emif_sys.qsys}
