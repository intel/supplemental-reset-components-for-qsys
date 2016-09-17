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
package require -exact qsys 14.0

create_system {test_sys}

set_project_property {DEVICE_FAMILY} {CYCLONEV}
set_project_property {DEVICE} {5CGXFC5C6F27C7}

proc create_qsys_system {} {

    #
    # Manually reorder this list of component instances to reflect the order
    # that you wish to see them appear in the Qsys GUI.
    #
	add_instance_system_pll_ref_clk_50m
	add_instance_system_pll
	add_instance_debug_reset_req
	add_instance_system_reset
	add_instance_default_slave
	add_instance_master
	add_instance_nios2_gen2
	add_instance_nios_ocram_8k
	add_instance_ddr_emif_pll_ref_clk_50m
	add_instance_ddr_emif
	add_instance_fast_peripheral_bridge
	add_instance_slow_peripheral_bridge
	add_instance_slow_default_slave
	add_instance_sysid
	add_instance_jtag_uart
	add_instance_hires_timer
	add_instance_led_pio_out
	add_instance_resets

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

proc add_instance_ddr_emif { } {
    add_instance ddr_emif altera_mem_if_lpddr2_emif
    set_instance_parameter_value ddr_emif {MEM_VENDOR} {Micron}
    set_instance_parameter_value ddr_emif {MEM_FORMAT} {DISCRETE}
    set_instance_parameter_value ddr_emif {DISCRETE_FLY_BY} {1}
    set_instance_parameter_value ddr_emif {DEVICE_DEPTH} {1}
    set_instance_parameter_value ddr_emif {MEM_MIRROR_ADDRESSING} {0}
    set_instance_parameter_value ddr_emif {MEM_CLK_FREQ_MAX} {400.0}
    set_instance_parameter_value ddr_emif {MEM_ROW_ADDR_WIDTH} {14}
    set_instance_parameter_value ddr_emif {MEM_COL_ADDR_WIDTH} {10}
    set_instance_parameter_value ddr_emif {MEM_DQ_WIDTH} {32}
    set_instance_parameter_value ddr_emif {MEM_DQ_PER_DQS} {8}
    set_instance_parameter_value ddr_emif {MEM_BANKADDR_WIDTH} {3}
    set_instance_parameter_value ddr_emif {MEM_IF_DM_PINS_EN} {1}
    set_instance_parameter_value ddr_emif {MEM_IF_DQSN_EN} {1}
    set_instance_parameter_value ddr_emif {MEM_NUMBER_OF_DIMMS} {1}
    set_instance_parameter_value ddr_emif {MEM_NUMBER_OF_RANKS_PER_DIMM} {1}
    set_instance_parameter_value ddr_emif {MEM_NUMBER_OF_RANKS_PER_DEVICE} {1}
    set_instance_parameter_value ddr_emif {MEM_RANK_MULTIPLICATION_FACTOR} {1}
    set_instance_parameter_value ddr_emif {MEM_CK_WIDTH} {1}
    set_instance_parameter_value ddr_emif {MEM_CS_WIDTH} {1}
    set_instance_parameter_value ddr_emif {MEM_CLK_EN_WIDTH} {1}
    set_instance_parameter_value ddr_emif {ALTMEMPHY_COMPATIBLE_MODE} {0}
    set_instance_parameter_value ddr_emif {NEXTGEN} {1}
    set_instance_parameter_value ddr_emif {MEM_IF_BOARD_BASE_DELAY} {10}
    set_instance_parameter_value ddr_emif {MEM_IF_SIM_VALID_WINDOW} {0}
    set_instance_parameter_value ddr_emif {MEM_GUARANTEED_WRITE_INIT} {0}
    set_instance_parameter_value ddr_emif {MEM_VERBOSE} {1}
    set_instance_parameter_value ddr_emif {PINGPONGPHY_EN} {0}
    set_instance_parameter_value ddr_emif {DUPLICATE_AC} {0}
    set_instance_parameter_value ddr_emif {REFRESH_BURST_VALIDATION} {0}
    set_instance_parameter_value ddr_emif {AP_MODE_EN} {0}
    set_instance_parameter_value ddr_emif {AP_MODE} {0}
    set_instance_parameter_value ddr_emif {MEM_BL} {8}
    set_instance_parameter_value ddr_emif {MEM_BT} {Sequential}
    set_instance_parameter_value ddr_emif {MEM_DRV_STR} {40}
    set_instance_parameter_value ddr_emif {MEM_DLL_EN} {1}
    set_instance_parameter_value ddr_emif {MEM_ATCL} {0}
    set_instance_parameter_value ddr_emif {MEM_TCL} {7}
    set_instance_parameter_value ddr_emif {MEM_AUTO_LEVELING_MODE} {1}
    set_instance_parameter_value ddr_emif {MEM_USER_LEVELING_MODE} {Leveling}
    set_instance_parameter_value ddr_emif {MEM_INIT_EN} {0}
    set_instance_parameter_value ddr_emif {MEM_INIT_FILE} {}
    set_instance_parameter_value ddr_emif {DAT_DATA_WIDTH} {32}
    set_instance_parameter_value ddr_emif {TIMING_TIS} {290}
    set_instance_parameter_value ddr_emif {TIMING_TIH} {290}
    set_instance_parameter_value ddr_emif {TIMING_TDS} {270}
    set_instance_parameter_value ddr_emif {TIMING_TDH} {270}
    set_instance_parameter_value ddr_emif {TIMING_TDQSQ} {240}
    set_instance_parameter_value ddr_emif {TIMING_TQHS} {280}
    set_instance_parameter_value ddr_emif {TIMING_TDQSCK} {5500}
    set_instance_parameter_value ddr_emif {TIMING_TDQSCKDS} {450}
    set_instance_parameter_value ddr_emif {TIMING_TDQSCKDM} {900}
    set_instance_parameter_value ddr_emif {TIMING_TDQSCKDL} {1200}
    set_instance_parameter_value ddr_emif {TIMING_TDQSS} {1.0}
    set_instance_parameter_value ddr_emif {TIMING_TDQSH} {0.4}
    set_instance_parameter_value ddr_emif {TIMING_TDSH} {0.2}
    set_instance_parameter_value ddr_emif {TIMING_TDSS} {0.2}
    set_instance_parameter_value ddr_emif {MEM_TINIT_US} {200}
    set_instance_parameter_value ddr_emif {MEM_TMRD_CK} {2}
    set_instance_parameter_value ddr_emif {MEM_TRAS_NS} {70.0}
    set_instance_parameter_value ddr_emif {MEM_TRCD_NS} {18.0}
    set_instance_parameter_value ddr_emif {MEM_TRP_NS} {18.0}
    set_instance_parameter_value ddr_emif {MEM_TREFI_US} {3.9}
    set_instance_parameter_value ddr_emif {MEM_TRFC_NS} {60.0}
    set_instance_parameter_value ddr_emif {CFG_TCCD_NS} {2.5}
    set_instance_parameter_value ddr_emif {MEM_TWR_NS} {15.0}
    set_instance_parameter_value ddr_emif {MEM_TWTR} {2}
    set_instance_parameter_value ddr_emif {MEM_TFAW_NS} {50.0}
    set_instance_parameter_value ddr_emif {MEM_TRRD_NS} {10.0}
    set_instance_parameter_value ddr_emif {MEM_TRTP_NS} {7.5}
    set_instance_parameter_value ddr_emif {RATE} {Full}
    set_instance_parameter_value ddr_emif {MEM_CLK_FREQ} {330.0}
    set_instance_parameter_value ddr_emif {USE_MEM_CLK_FREQ} {0}
    set_instance_parameter_value ddr_emif {FORCE_DQS_TRACKING} {AUTO}
    set_instance_parameter_value ddr_emif {FORCE_SHADOW_REGS} {AUTO}
    set_instance_parameter_value ddr_emif {MRS_MIRROR_PING_PONG_ATSO} {0}
    set_instance_parameter_value ddr_emif {PARSE_FRIENDLY_DEVICE_FAMILY_PARAM_VALID} {0}
    set_instance_parameter_value ddr_emif {PARSE_FRIENDLY_DEVICE_FAMILY_PARAM} {}
    set_instance_parameter_value ddr_emif {DEVICE_FAMILY_PARAM} {}
    set_instance_parameter_value ddr_emif {SPEED_GRADE} {7}
    set_instance_parameter_value ddr_emif {IS_ES_DEVICE} {0}
    set_instance_parameter_value ddr_emif {DISABLE_CHILD_MESSAGING} {0}
    set_instance_parameter_value ddr_emif {HARD_EMIF} {1}
    set_instance_parameter_value ddr_emif {HHP_HPS} {0}
    set_instance_parameter_value ddr_emif {HHP_HPS_VERIFICATION} {0}
    set_instance_parameter_value ddr_emif {HHP_HPS_SIMULATION} {0}
    set_instance_parameter_value ddr_emif {HPS_PROTOCOL} {DEFAULT}
    set_instance_parameter_value ddr_emif {CUT_NEW_FAMILY_TIMING} {1}
    set_instance_parameter_value ddr_emif {POWER_OF_TWO_BUS} {0}
    set_instance_parameter_value ddr_emif {SOPC_COMPAT_RESET} {0}
    set_instance_parameter_value ddr_emif {AVL_MAX_SIZE} {1}
    set_instance_parameter_value ddr_emif {BYTE_ENABLE} {1}
    set_instance_parameter_value ddr_emif {ENABLE_CTRL_AVALON_INTERFACE} {1}
    set_instance_parameter_value ddr_emif {CTL_DEEP_POWERDN_EN} {0}
    set_instance_parameter_value ddr_emif {CTL_SELF_REFRESH_EN} {0}
    set_instance_parameter_value ddr_emif {AUTO_POWERDN_EN} {0}
    set_instance_parameter_value ddr_emif {AUTO_PD_CYCLES} {0}
    set_instance_parameter_value ddr_emif {CTL_USR_REFRESH_EN} {0}
    set_instance_parameter_value ddr_emif {CTL_AUTOPCH_EN} {0}
    set_instance_parameter_value ddr_emif {CTL_ZQCAL_EN} {0}
    set_instance_parameter_value ddr_emif {ADDR_ORDER} {0}
    set_instance_parameter_value ddr_emif {CTL_LOOK_AHEAD_DEPTH} {4}
    set_instance_parameter_value ddr_emif {CONTROLLER_LATENCY} {5}
    set_instance_parameter_value ddr_emif {CFG_REORDER_DATA} {1}
    set_instance_parameter_value ddr_emif {STARVE_LIMIT} {10}
    set_instance_parameter_value ddr_emif {CTL_CSR_ENABLED} {0}
    set_instance_parameter_value ddr_emif {CTL_CSR_CONNECTION} {INTERNAL_JTAG}
    set_instance_parameter_value ddr_emif {CTL_ECC_ENABLED} {0}
    set_instance_parameter_value ddr_emif {CTL_HRB_ENABLED} {0}
    set_instance_parameter_value ddr_emif {CTL_ECC_AUTO_CORRECTION_ENABLED} {0}
    set_instance_parameter_value ddr_emif {MULTICAST_EN} {0}
    set_instance_parameter_value ddr_emif {CTL_DYNAMIC_BANK_ALLOCATION} {0}
    set_instance_parameter_value ddr_emif {CTL_DYNAMIC_BANK_NUM} {4}
    set_instance_parameter_value ddr_emif {DEBUG_MODE} {0}
    set_instance_parameter_value ddr_emif {ENABLE_BURST_MERGE} {0}
    set_instance_parameter_value ddr_emif {CTL_ENABLE_BURST_INTERRUPT} {0}
    set_instance_parameter_value ddr_emif {CTL_ENABLE_BURST_TERMINATE} {0}
    set_instance_parameter_value ddr_emif {LOCAL_ID_WIDTH} {8}
    set_instance_parameter_value ddr_emif {WRBUFFER_ADDR_WIDTH} {6}
    set_instance_parameter_value ddr_emif {MAX_PENDING_WR_CMD} {16}
    set_instance_parameter_value ddr_emif {MAX_PENDING_RD_CMD} {32}
    set_instance_parameter_value ddr_emif {USE_MM_ADAPTOR} {1}
    set_instance_parameter_value ddr_emif {USE_AXI_ADAPTOR} {0}
    set_instance_parameter_value ddr_emif {HCX_COMPAT_MODE} {0}
    set_instance_parameter_value ddr_emif {CTL_CMD_QUEUE_DEPTH} {8}
    set_instance_parameter_value ddr_emif {CTL_CSR_READ_ONLY} {1}
    set_instance_parameter_value ddr_emif {CFG_DATA_REORDERING_TYPE} {INTER_BANK}
    set_instance_parameter_value ddr_emif {NUM_OF_PORTS} {1}
    set_instance_parameter_value ddr_emif {ENABLE_BONDING} {0}
    set_instance_parameter_value ddr_emif {ENABLE_USER_ECC} {0}
    set_instance_parameter_value ddr_emif {AVL_DATA_WIDTH_PORT} {32 32 32 32 32 32}
    set_instance_parameter_value ddr_emif {PRIORITY_PORT} {1 1 1 1 1 1}
    set_instance_parameter_value ddr_emif {WEIGHT_PORT} {0 0 0 0 0 0}
    set_instance_parameter_value ddr_emif {CPORT_TYPE_PORT} {Bidirectional Bidirectional Bidirectional Bidirectional Bidirectional Bidirectional}
    set_instance_parameter_value ddr_emif {ENABLE_EMIT_BFM_MASTER} {0}
    set_instance_parameter_value ddr_emif {FORCE_SEQUENCER_TCL_DEBUG_MODE} {0}
    set_instance_parameter_value ddr_emif {ENABLE_SEQUENCER_MARGINING_ON_BY_DEFAULT} {0}
    set_instance_parameter_value ddr_emif {REF_CLK_FREQ} {50.0}
    set_instance_parameter_value ddr_emif {REF_CLK_FREQ_PARAM_VALID} {0}
    set_instance_parameter_value ddr_emif {REF_CLK_FREQ_MIN_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {REF_CLK_FREQ_MAX_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_DR_CLK_FREQ_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_DR_CLK_FREQ_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_DR_CLK_PHASE_PS_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_DR_CLK_PHASE_PS_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_DR_CLK_MULT_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_DR_CLK_DIV_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_MEM_CLK_FREQ_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_MEM_CLK_FREQ_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_MEM_CLK_PHASE_PS_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_MEM_CLK_PHASE_PS_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_MEM_CLK_MULT_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_MEM_CLK_DIV_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_AFI_CLK_FREQ_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_AFI_CLK_FREQ_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_AFI_CLK_PHASE_PS_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_AFI_CLK_PHASE_PS_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_AFI_CLK_MULT_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_AFI_CLK_DIV_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_WRITE_CLK_FREQ_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_WRITE_CLK_FREQ_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_WRITE_CLK_PHASE_PS_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_WRITE_CLK_PHASE_PS_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_WRITE_CLK_MULT_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_WRITE_CLK_DIV_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_ADDR_CMD_CLK_FREQ_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_ADDR_CMD_CLK_FREQ_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_ADDR_CMD_CLK_PHASE_PS_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_ADDR_CMD_CLK_PHASE_PS_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_ADDR_CMD_CLK_MULT_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_ADDR_CMD_CLK_DIV_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_AFI_HALF_CLK_FREQ_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_AFI_HALF_CLK_FREQ_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_AFI_HALF_CLK_PHASE_PS_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_AFI_HALF_CLK_PHASE_PS_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_AFI_HALF_CLK_MULT_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_AFI_HALF_CLK_DIV_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_NIOS_CLK_FREQ_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_NIOS_CLK_FREQ_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_NIOS_CLK_PHASE_PS_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_NIOS_CLK_PHASE_PS_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_NIOS_CLK_MULT_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_NIOS_CLK_DIV_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_CONFIG_CLK_FREQ_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_CONFIG_CLK_FREQ_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_CONFIG_CLK_PHASE_PS_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_CONFIG_CLK_PHASE_PS_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_CONFIG_CLK_MULT_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_CONFIG_CLK_DIV_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_P2C_READ_CLK_FREQ_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_P2C_READ_CLK_FREQ_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_P2C_READ_CLK_PHASE_PS_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_P2C_READ_CLK_PHASE_PS_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_P2C_READ_CLK_MULT_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_P2C_READ_CLK_DIV_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_C2P_WRITE_CLK_FREQ_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_C2P_WRITE_CLK_FREQ_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_C2P_WRITE_CLK_PHASE_PS_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_C2P_WRITE_CLK_PHASE_PS_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_C2P_WRITE_CLK_MULT_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_C2P_WRITE_CLK_DIV_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_HR_CLK_FREQ_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_HR_CLK_FREQ_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_HR_CLK_PHASE_PS_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_HR_CLK_PHASE_PS_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_HR_CLK_MULT_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_HR_CLK_DIV_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_AFI_PHY_CLK_FREQ_PARAM} {0.0}
    set_instance_parameter_value ddr_emif {PLL_AFI_PHY_CLK_FREQ_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_AFI_PHY_CLK_PHASE_PS_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_AFI_PHY_CLK_PHASE_PS_SIM_STR_PARAM} {}
    set_instance_parameter_value ddr_emif {PLL_AFI_PHY_CLK_MULT_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_AFI_PHY_CLK_DIV_PARAM} {0}
    set_instance_parameter_value ddr_emif {PLL_CLK_PARAM_VALID} {0}
    set_instance_parameter_value ddr_emif {ENABLE_EXTRA_REPORTING} {0}
    set_instance_parameter_value ddr_emif {NUM_EXTRA_REPORT_PATH} {10}
    set_instance_parameter_value ddr_emif {ENABLE_ISS_PROBES} {0}
    set_instance_parameter_value ddr_emif {CALIB_REG_WIDTH} {8}
    set_instance_parameter_value ddr_emif {USE_SEQUENCER_BFM} {0}
    set_instance_parameter_value ddr_emif {PLL_SHARING_MODE} {None}
    set_instance_parameter_value ddr_emif {NUM_PLL_SHARING_INTERFACES} {1}
    set_instance_parameter_value ddr_emif {EXPORT_AFI_HALF_CLK} {1}
    set_instance_parameter_value ddr_emif {ABSTRACT_REAL_COMPARE_TEST} {0}
    set_instance_parameter_value ddr_emif {INCLUDE_BOARD_DELAY_MODEL} {0}
    set_instance_parameter_value ddr_emif {INCLUDE_MULTIRANK_BOARD_DELAY_MODEL} {0}
    set_instance_parameter_value ddr_emif {USE_FAKE_PHY} {0}
    set_instance_parameter_value ddr_emif {FORCE_MAX_LATENCY_COUNT_WIDTH} {0}
    set_instance_parameter_value ddr_emif {ENABLE_NON_DESTRUCTIVE_CALIB} {0}
    set_instance_parameter_value ddr_emif {ENABLE_DELAY_CHAIN_WRITE} {0}
    set_instance_parameter_value ddr_emif {TRACKING_ERROR_TEST} {0}
    set_instance_parameter_value ddr_emif {TRACKING_WATCH_TEST} {0}
    set_instance_parameter_value ddr_emif {MARGIN_VARIATION_TEST} {0}
    set_instance_parameter_value ddr_emif {AC_ROM_USER_ADD_0} {0_0000_0000_0000}
    set_instance_parameter_value ddr_emif {AC_ROM_USER_ADD_1} {0_0000_0000_1000}
    set_instance_parameter_value ddr_emif {TREFI} {35100}
    set_instance_parameter_value ddr_emif {REFRESH_INTERVAL} {15000}
    set_instance_parameter_value ddr_emif {ENABLE_NON_DES_CAL_TEST} {0}
    set_instance_parameter_value ddr_emif {TRFC} {350}
    set_instance_parameter_value ddr_emif {ENABLE_NON_DES_CAL} {0}
    set_instance_parameter_value ddr_emif {EXTRA_SETTINGS} {}
    set_instance_parameter_value ddr_emif {MEM_DEVICE} {MISSING_MODEL}
    set_instance_parameter_value ddr_emif {FORCE_SYNTHESIS_LANGUAGE} {}
    set_instance_parameter_value ddr_emif {FORCED_NUM_WRITE_FR_CYCLE_SHIFTS} {0}
    set_instance_parameter_value ddr_emif {SEQUENCER_TYPE} {NIOS}
    set_instance_parameter_value ddr_emif {ADVERTIZE_SEQUENCER_SW_BUILD_FILES} {0}
    set_instance_parameter_value ddr_emif {FORCED_NON_LDC_ADDR_CMD_MEM_CK_INVERT} {0}
    set_instance_parameter_value ddr_emif {PHY_ONLY} {0}
    set_instance_parameter_value ddr_emif {SEQ_MODE} {0}
    set_instance_parameter_value ddr_emif {ADVANCED_CK_PHASES} {0}
    set_instance_parameter_value ddr_emif {COMMAND_PHASE} {0.0}
    set_instance_parameter_value ddr_emif {MEM_CK_PHASE} {0.0}
    set_instance_parameter_value ddr_emif {P2C_READ_CLOCK_ADD_PHASE} {0.0}
    set_instance_parameter_value ddr_emif {C2P_WRITE_CLOCK_ADD_PHASE} {0.0}
    set_instance_parameter_value ddr_emif {ACV_PHY_CLK_ADD_FR_PHASE} {0.0}
    set_instance_parameter_value ddr_emif {PLL_LOCATION} {Top_Bottom}
    set_instance_parameter_value ddr_emif {SKIP_MEM_INIT} {1}
    set_instance_parameter_value ddr_emif {READ_DQ_DQS_CLOCK_SOURCE} {INVERTED_DQS_BUS}
    set_instance_parameter_value ddr_emif {DQ_INPUT_REG_USE_CLKN} {0}
    set_instance_parameter_value ddr_emif {DQS_DQSN_MODE} {DIFFERENTIAL}
    set_instance_parameter_value ddr_emif {AFI_DEBUG_INFO_WIDTH} {32}
    set_instance_parameter_value ddr_emif {CALIBRATION_MODE} {Full}
    set_instance_parameter_value ddr_emif {NIOS_ROM_DATA_WIDTH} {32}
    set_instance_parameter_value ddr_emif {READ_FIFO_SIZE} {8}
    set_instance_parameter_value ddr_emif {PHY_CSR_ENABLED} {0}
    set_instance_parameter_value ddr_emif {PHY_CSR_CONNECTION} {INTERNAL_JTAG}
    set_instance_parameter_value ddr_emif {USER_DEBUG_LEVEL} {0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_DERATE_METHOD} {AUTO}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_CK_CKN_SLEW_RATE} {2.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_AC_SLEW_RATE} {1.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_DQS_DQSN_SLEW_RATE} {2.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_DQ_SLEW_RATE} {1.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_TIS} {0.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_TIH} {0.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_TDS} {0.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_TDH} {0.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_ISI_METHOD} {AUTO}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_AC_EYE_REDUCTION_SU} {0.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_AC_EYE_REDUCTION_H} {0.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_DQ_EYE_REDUCTION} {0.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_DELTA_DQS_ARRIVAL_TIME} {0.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_READ_DQ_EYE_REDUCTION} {0.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_DELTA_READ_DQS_ARRIVAL_TIME} {0.0}
    set_instance_parameter_value ddr_emif {PACKAGE_DESKEW} {0}
    set_instance_parameter_value ddr_emif {AC_PACKAGE_DESKEW} {0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_MAX_CK_DELAY} {0.33}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_MAX_DQS_DELAY} {0.34}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_SKEW_CKDQS_DIMM_MIN} {-0.01}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_SKEW_CKDQS_DIMM_MAX} {0.01}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_SKEW_BETWEEN_DIMMS} {0.05}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_SKEW_WITHIN_DQS} {0.02}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_SKEW_BETWEEN_DQS} {0.02}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_DQ_TO_DQS_SKEW} {0.0}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_AC_SKEW} {0.02}
    set_instance_parameter_value ddr_emif {TIMING_BOARD_AC_TO_CK_SKEW} {0.0}
    set_instance_parameter_value ddr_emif {ENABLE_EXPORT_SEQ_DEBUG_BRIDGE} {0}
    set_instance_parameter_value ddr_emif {CORE_DEBUG_CONNECTION} {EXPORT}
    set_instance_parameter_value ddr_emif {ADD_EXTERNAL_SEQ_DEBUG_NIOS} {0}
    set_instance_parameter_value ddr_emif {ED_EXPORT_SEQ_DEBUG} {0}
    set_instance_parameter_value ddr_emif {ADD_EFFICIENCY_MONITOR} {0}
    set_instance_parameter_value ddr_emif {ENABLE_ABS_RAM_MEM_INIT} {0}
    set_instance_parameter_value ddr_emif {ABS_RAM_MEM_INIT_FILENAME} {meminit}
    set_instance_parameter_value ddr_emif {DLL_SHARING_MODE} {None}
    set_instance_parameter_value ddr_emif {NUM_DLL_SHARING_INTERFACES} {1}
    set_instance_parameter_value ddr_emif {OCT_SHARING_MODE} {None}
    set_instance_parameter_value ddr_emif {NUM_OCT_SHARING_INTERFACES} {1}
}

proc add_instance_ddr_emif_pll_ref_clk_50m { } {
    add_instance ddr_emif_pll_ref_clk_50m altera_clock_bridge
    set_instance_parameter_value ddr_emif_pll_ref_clk_50m {EXPLICIT_CLOCK_RATE} {50000000.0}
    set_instance_parameter_value ddr_emif_pll_ref_clk_50m {NUM_CLOCK_OUTPUTS} {1}
}

proc add_instance_debug_reset_req { } {
    add_instance debug_reset_req altera_reset_bridge
    set_instance_parameter_value debug_reset_req {ACTIVE_LOW_RESET} {0}
    set_instance_parameter_value debug_reset_req {SYNCHRONOUS_EDGES} {none}
    set_instance_parameter_value debug_reset_req {NUM_RESET_OUTPUTS} {1}
    set_instance_parameter_value debug_reset_req {USE_RESET_REQUEST} {0}
}

proc add_instance_default_slave { } {
    add_instance default_slave trivial_default_avalon_slave
    set_instance_parameter_value default_slave {DATA_BYTES} {4}
    set_instance_parameter_value default_slave {READ_DATA_PATTERN} {0}
    set_instance_parameter_value default_slave {ENABLE_READ_RESPONSE} {0}
    set_instance_parameter_value default_slave {RESPONSE_PATTERN} {0}
    set_instance_parameter_value default_slave {ENABLE_WRITE_RESPONSE} {0}
    set_instance_parameter_value default_slave {NEVER_RESPOND} {0}
    set_instance_parameter_value default_slave {ENABLE_CLEAR_EVENT} {0}
    set_instance_parameter_value default_slave {CLEAR_EVENT_CONDUIT_ROLE} {clear_event}
    set_instance_parameter_value default_slave {ENABLE_ACCESS_EVENT_CONDUIT} {0}
    set_instance_parameter_value default_slave {ACCESS_EVENT_CONDUIT_ROLE} {access_event_conduit}
    set_instance_parameter_value default_slave {ENABLE_ACCESS_EVENT_RESET} {0}
    set_instance_parameter_value default_slave {ENABLE_ACCESS_EVENT_INTERRUPT} {0}
}

proc add_instance_fast_peripheral_bridge { } {
    add_instance fast_peripheral_bridge altera_avalon_mm_bridge
    set_instance_parameter_value fast_peripheral_bridge {DATA_WIDTH} {32}
    set_instance_parameter_value fast_peripheral_bridge {SYMBOL_WIDTH} {8}
    set_instance_parameter_value fast_peripheral_bridge {ADDRESS_WIDTH} {8}
    set_instance_parameter_value fast_peripheral_bridge {USE_AUTO_ADDRESS_WIDTH} {0}
    set_instance_parameter_value fast_peripheral_bridge {ADDRESS_UNITS} {SYMBOLS}
    set_instance_parameter_value fast_peripheral_bridge {MAX_BURST_SIZE} {1}
    set_instance_parameter_value fast_peripheral_bridge {MAX_PENDING_RESPONSES} {4}
    set_instance_parameter_value fast_peripheral_bridge {LINEWRAPBURSTS} {0}
    set_instance_parameter_value fast_peripheral_bridge {PIPELINE_COMMAND} {0}
    set_instance_parameter_value fast_peripheral_bridge {PIPELINE_RESPONSE} {0}
    set_instance_parameter_value fast_peripheral_bridge {USE_RESPONSE} {0}
}

proc add_instance_hires_timer { } {
    add_instance hires_timer altera_avalon_timer
    set_instance_parameter_value hires_timer {alwaysRun} {0}
    set_instance_parameter_value hires_timer {counterSize} {32}
    set_instance_parameter_value hires_timer {fixedPeriod} {0}
    set_instance_parameter_value hires_timer {period} {1}
    set_instance_parameter_value hires_timer {periodUnits} {MSEC}
    set_instance_parameter_value hires_timer {resetOutput} {0}
    set_instance_parameter_value hires_timer {snapshot} {1}
    set_instance_parameter_value hires_timer {timeoutPulseOutput} {0}
    set_instance_parameter_value hires_timer {watchdogPulse} {2}
}

proc add_instance_jtag_uart { } {
    add_instance jtag_uart altera_avalon_jtag_uart
    set_instance_parameter_value jtag_uart {allowMultipleConnections} {0}
    set_instance_parameter_value jtag_uart {hubInstanceID} {0}
    set_instance_parameter_value jtag_uart {readBufferDepth} {64}
    set_instance_parameter_value jtag_uart {readIRQThreshold} {8}
    set_instance_parameter_value jtag_uart {simInputCharacterStream} {}
    set_instance_parameter_value jtag_uart {simInteractiveOptions} {NO_INTERACTIVE_WINDOWS}
    set_instance_parameter_value jtag_uart {useRegistersForReadBuffer} {0}
    set_instance_parameter_value jtag_uart {useRegistersForWriteBuffer} {0}
    set_instance_parameter_value jtag_uart {useRelativePathForSimFile} {0}
    set_instance_parameter_value jtag_uart {writeBufferDepth} {64}
    set_instance_parameter_value jtag_uart {writeIRQThreshold} {8}
}

proc add_instance_led_pio_out { } {
    add_instance led_pio_out altera_avalon_pio
    set_instance_parameter_value led_pio_out {bitClearingEdgeCapReg} {0}
    set_instance_parameter_value led_pio_out {bitModifyingOutReg} {0}
    set_instance_parameter_value led_pio_out {captureEdge} {0}
    set_instance_parameter_value led_pio_out {direction} {Output}
    set_instance_parameter_value led_pio_out {edgeType} {RISING}
    set_instance_parameter_value led_pio_out {generateIRQ} {0}
    set_instance_parameter_value led_pio_out {irqType} {LEVEL}
    set_instance_parameter_value led_pio_out {resetValue} {0.0}
    set_instance_parameter_value led_pio_out {simDoTestBenchWiring} {0}
    set_instance_parameter_value led_pio_out {simDrivenValue} {0.0}
    set_instance_parameter_value led_pio_out {width} {32}
}

proc add_instance_master { } {
    add_instance master altera_jtag_avalon_master
    set_instance_parameter_value master {USE_PLI} {0}
    set_instance_parameter_value master {PLI_PORT} {50000}
    set_instance_parameter_value master {FAST_VER} {0}
    set_instance_parameter_value master {FIFO_DEPTHS} {2}
}

proc add_instance_nios2_gen2 { } {
    add_instance nios2_gen2 altera_nios2_gen2
    set_instance_parameter_value nios2_gen2 {tmr_enabled} {0}
    set_instance_parameter_value nios2_gen2 {setting_disable_tmr_inj} {0}
    set_instance_parameter_value nios2_gen2 {setting_showUnpublishedSettings} {0}
    set_instance_parameter_value nios2_gen2 {setting_showInternalSettings} {0}
    set_instance_parameter_value nios2_gen2 {setting_preciseIllegalMemAccessException} {0}
    set_instance_parameter_value nios2_gen2 {setting_exportPCB} {0}
    set_instance_parameter_value nios2_gen2 {setting_exportdebuginfo} {0}
    set_instance_parameter_value nios2_gen2 {setting_clearXBitsLDNonBypass} {1}
    set_instance_parameter_value nios2_gen2 {setting_bigEndian} {0}
    set_instance_parameter_value nios2_gen2 {setting_export_large_RAMs} {0}
    set_instance_parameter_value nios2_gen2 {setting_asic_enabled} {0}
    set_instance_parameter_value nios2_gen2 {setting_asic_synopsys_translate_on_off} {0}
    set_instance_parameter_value nios2_gen2 {setting_asic_third_party_synthesis} {0}
    set_instance_parameter_value nios2_gen2 {setting_asic_add_scan_mode_input} {0}
    set_instance_parameter_value nios2_gen2 {setting_oci_version} {1}
    set_instance_parameter_value nios2_gen2 {setting_fast_register_read} {0}
    set_instance_parameter_value nios2_gen2 {setting_exportHostDebugPort} {0}
    set_instance_parameter_value nios2_gen2 {setting_oci_export_jtag_signals} {0}
    set_instance_parameter_value nios2_gen2 {setting_avalonDebugPortPresent} {0}
    set_instance_parameter_value nios2_gen2 {setting_alwaysEncrypt} {1}
    set_instance_parameter_value nios2_gen2 {io_regionbase} {0}
    set_instance_parameter_value nios2_gen2 {io_regionsize} {0}
    set_instance_parameter_value nios2_gen2 {setting_support31bitdcachebypass} {1}
    set_instance_parameter_value nios2_gen2 {setting_activateTrace} {0}
    set_instance_parameter_value nios2_gen2 {setting_allow_break_inst} {0}
    set_instance_parameter_value nios2_gen2 {setting_activateTestEndChecker} {0}
    set_instance_parameter_value nios2_gen2 {setting_ecc_sim_test_ports} {0}
    set_instance_parameter_value nios2_gen2 {setting_disableocitrace} {0}
    set_instance_parameter_value nios2_gen2 {setting_activateMonitors} {1}
    set_instance_parameter_value nios2_gen2 {setting_HDLSimCachesCleared} {1}
    set_instance_parameter_value nios2_gen2 {setting_HBreakTest} {0}
    set_instance_parameter_value nios2_gen2 {setting_breakslaveoveride} {0}
    set_instance_parameter_value nios2_gen2 {mpu_useLimit} {0}
    set_instance_parameter_value nios2_gen2 {mpu_enabled} {0}
    set_instance_parameter_value nios2_gen2 {mmu_enabled} {0}
    set_instance_parameter_value nios2_gen2 {mmu_autoAssignTlbPtrSz} {1}
    set_instance_parameter_value nios2_gen2 {cpuReset} {0}
    set_instance_parameter_value nios2_gen2 {resetrequest_enabled} {1}
    set_instance_parameter_value nios2_gen2 {setting_removeRAMinit} {0}
    set_instance_parameter_value nios2_gen2 {setting_shadowRegisterSets} {0}
    set_instance_parameter_value nios2_gen2 {mpu_numOfInstRegion} {8}
    set_instance_parameter_value nios2_gen2 {mpu_numOfDataRegion} {8}
    set_instance_parameter_value nios2_gen2 {mmu_TLBMissExcOffset} {0}
    set_instance_parameter_value nios2_gen2 {resetOffset} {0}
    set_instance_parameter_value nios2_gen2 {exceptionOffset} {32}
    set_instance_parameter_value nios2_gen2 {cpuID} {0}
    set_instance_parameter_value nios2_gen2 {breakOffset} {32}
    set_instance_parameter_value nios2_gen2 {userDefinedSettings} {}
    set_instance_parameter_value nios2_gen2 {tracefilename} {}
    set_instance_parameter_value nios2_gen2 {resetSlave} {nios_ocram_8k.s1}
    set_instance_parameter_value nios2_gen2 {mmu_TLBMissExcSlave} {None}
    set_instance_parameter_value nios2_gen2 {exceptionSlave} {nios_ocram_8k.s1}
    set_instance_parameter_value nios2_gen2 {breakSlave} {None}
    set_instance_parameter_value nios2_gen2 {setting_interruptControllerType} {Internal}
    set_instance_parameter_value nios2_gen2 {setting_branchpredictiontype} {Dynamic}
    set_instance_parameter_value nios2_gen2 {setting_bhtPtrSz} {8}
    set_instance_parameter_value nios2_gen2 {cpuArchRev} {1}
    set_instance_parameter_value nios2_gen2 {mul_shift_choice} {0}
    set_instance_parameter_value nios2_gen2 {mul_32_impl} {0}
    set_instance_parameter_value nios2_gen2 {mul_64_impl} {0}
    set_instance_parameter_value nios2_gen2 {shift_rot_impl} {0}
    set_instance_parameter_value nios2_gen2 {dividerType} {srt2}
    set_instance_parameter_value nios2_gen2 {mpu_minInstRegionSize} {12}
    set_instance_parameter_value nios2_gen2 {mpu_minDataRegionSize} {12}
    set_instance_parameter_value nios2_gen2 {mmu_uitlbNumEntries} {4}
    set_instance_parameter_value nios2_gen2 {mmu_udtlbNumEntries} {6}
    set_instance_parameter_value nios2_gen2 {mmu_tlbPtrSz} {7}
    set_instance_parameter_value nios2_gen2 {mmu_tlbNumWays} {16}
    set_instance_parameter_value nios2_gen2 {mmu_processIDNumBits} {8}
    set_instance_parameter_value nios2_gen2 {impl} {Tiny}
    set_instance_parameter_value nios2_gen2 {icache_size} {4096}
    set_instance_parameter_value nios2_gen2 {fa_cache_line} {2}
    set_instance_parameter_value nios2_gen2 {fa_cache_linesize} {0}
    set_instance_parameter_value nios2_gen2 {icache_tagramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {icache_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {icache_numTCIM} {1}
    set_instance_parameter_value nios2_gen2 {icache_burstType} {None}
    set_instance_parameter_value nios2_gen2 {dcache_bursts} {false}
    set_instance_parameter_value nios2_gen2 {dcache_victim_buf_impl} {ram}
    set_instance_parameter_value nios2_gen2 {dcache_size} {2048}
    set_instance_parameter_value nios2_gen2 {dcache_tagramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {dcache_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {dcache_numTCDM} {1}
    set_instance_parameter_value nios2_gen2 {setting_exportvectors} {0}
    set_instance_parameter_value nios2_gen2 {setting_usedesignware} {0}
    set_instance_parameter_value nios2_gen2 {setting_ecc_present} {0}
    set_instance_parameter_value nios2_gen2 {setting_ic_ecc_present} {1}
    set_instance_parameter_value nios2_gen2 {setting_rf_ecc_present} {1}
    set_instance_parameter_value nios2_gen2 {setting_mmu_ecc_present} {1}
    set_instance_parameter_value nios2_gen2 {setting_dc_ecc_present} {1}
    set_instance_parameter_value nios2_gen2 {setting_itcm_ecc_present} {1}
    set_instance_parameter_value nios2_gen2 {setting_dtcm_ecc_present} {1}
    set_instance_parameter_value nios2_gen2 {regfile_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {ocimem_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {ocimem_ramInit} {0}
    set_instance_parameter_value nios2_gen2 {mmu_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {bht_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {cdx_enabled} {0}
    set_instance_parameter_value nios2_gen2 {mpx_enabled} {0}
    set_instance_parameter_value nios2_gen2 {debug_enabled} {1}
    set_instance_parameter_value nios2_gen2 {debug_triggerArming} {1}
    set_instance_parameter_value nios2_gen2 {debug_debugReqSignals} {0}
    set_instance_parameter_value nios2_gen2 {debug_assignJtagInstanceID} {0}
    set_instance_parameter_value nios2_gen2 {debug_jtagInstanceID} {0}
    set_instance_parameter_value nios2_gen2 {debug_OCIOnchipTrace} {_128}
    set_instance_parameter_value nios2_gen2 {debug_hwbreakpoint} {0}
    set_instance_parameter_value nios2_gen2 {debug_datatrigger} {0}
    set_instance_parameter_value nios2_gen2 {debug_traceType} {none}
    set_instance_parameter_value nios2_gen2 {debug_traceStorage} {onchip_trace}
    set_instance_parameter_value nios2_gen2 {master_addr_map} {0}
    set_instance_parameter_value nios2_gen2 {instruction_master_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {instruction_master_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {flash_instruction_master_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {flash_instruction_master_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {data_master_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {data_master_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_0_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_0_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_1_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_1_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_2_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_2_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_3_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_3_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_0_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_0_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_1_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_1_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_2_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_2_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_3_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_3_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {instruction_master_high_performance_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {instruction_master_high_performance_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {data_master_high_performance_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {data_master_high_performance_paddr_size} {0.0}
}

proc add_instance_nios_ocram_8k { } {
    add_instance nios_ocram_8k altera_avalon_onchip_memory2
    set_instance_parameter_value nios_ocram_8k {allowInSystemMemoryContentEditor} {0}
    set_instance_parameter_value nios_ocram_8k {blockType} {AUTO}
    set_instance_parameter_value nios_ocram_8k {dataWidth} {32}
    set_instance_parameter_value nios_ocram_8k {dualPort} {0}
    set_instance_parameter_value nios_ocram_8k {initMemContent} {1}
    set_instance_parameter_value nios_ocram_8k {initializationFileName} {onchip_mem.hex}
    set_instance_parameter_value nios_ocram_8k {instanceID} {NONE}
    set_instance_parameter_value nios_ocram_8k {memorySize} {8192.0}
    set_instance_parameter_value nios_ocram_8k {readDuringWriteMode} {DONT_CARE}
    set_instance_parameter_value nios_ocram_8k {simAllowMRAMContentsFile} {0}
    set_instance_parameter_value nios_ocram_8k {simMemInitOnlyFilename} {0}
    set_instance_parameter_value nios_ocram_8k {singleClockOperation} {0}
    set_instance_parameter_value nios_ocram_8k {slave1Latency} {1}
    set_instance_parameter_value nios_ocram_8k {slave2Latency} {1}
    set_instance_parameter_value nios_ocram_8k {useNonDefaultInitFile} {0}
    set_instance_parameter_value nios_ocram_8k {copyInitFile} {0}
    set_instance_parameter_value nios_ocram_8k {useShallowMemBlocks} {0}
    set_instance_parameter_value nios_ocram_8k {writable} {1}
    set_instance_parameter_value nios_ocram_8k {ecc_enabled} {0}
    set_instance_parameter_value nios_ocram_8k {resetrequest_enabled} {1}
}

proc add_instance_resets { } {
    add_instance resets reset_subsys
}

proc add_instance_slow_default_slave { } {
    add_instance slow_default_slave trivial_default_avalon_slave
    set_instance_parameter_value slow_default_slave {DATA_BYTES} {4}
    set_instance_parameter_value slow_default_slave {READ_DATA_PATTERN} {238}
    set_instance_parameter_value slow_default_slave {ENABLE_READ_RESPONSE} {0}
    set_instance_parameter_value slow_default_slave {RESPONSE_PATTERN} {0}
    set_instance_parameter_value slow_default_slave {ENABLE_WRITE_RESPONSE} {0}
    set_instance_parameter_value slow_default_slave {NEVER_RESPOND} {0}
    set_instance_parameter_value slow_default_slave {ENABLE_CLEAR_EVENT} {0}
    set_instance_parameter_value slow_default_slave {CLEAR_EVENT_CONDUIT_ROLE} {clear_event}
    set_instance_parameter_value slow_default_slave {ENABLE_ACCESS_EVENT_CONDUIT} {0}
    set_instance_parameter_value slow_default_slave {ACCESS_EVENT_CONDUIT_ROLE} {access_event_conduit}
    set_instance_parameter_value slow_default_slave {ENABLE_ACCESS_EVENT_RESET} {0}
    set_instance_parameter_value slow_default_slave {ENABLE_ACCESS_EVENT_INTERRUPT} {0}
}

proc add_instance_slow_peripheral_bridge { } {
    add_instance slow_peripheral_bridge altera_avalon_mm_bridge
    set_instance_parameter_value slow_peripheral_bridge {DATA_WIDTH} {32}
    set_instance_parameter_value slow_peripheral_bridge {SYMBOL_WIDTH} {8}
    set_instance_parameter_value slow_peripheral_bridge {ADDRESS_WIDTH} {8}
    set_instance_parameter_value slow_peripheral_bridge {USE_AUTO_ADDRESS_WIDTH} {0}
    set_instance_parameter_value slow_peripheral_bridge {ADDRESS_UNITS} {SYMBOLS}
    set_instance_parameter_value slow_peripheral_bridge {MAX_BURST_SIZE} {1}
    set_instance_parameter_value slow_peripheral_bridge {MAX_PENDING_RESPONSES} {4}
    set_instance_parameter_value slow_peripheral_bridge {LINEWRAPBURSTS} {0}
    set_instance_parameter_value slow_peripheral_bridge {PIPELINE_COMMAND} {0}
    set_instance_parameter_value slow_peripheral_bridge {PIPELINE_RESPONSE} {0}
    set_instance_parameter_value slow_peripheral_bridge {USE_RESPONSE} {0}
}

proc add_instance_sysid { } {
    add_instance sysid altera_avalon_sysid_qsys
    set_instance_parameter_value sysid {id} {287454020}
}

proc add_instance_system_pll { } {
    add_instance system_pll altera_pll
    set_instance_parameter_value system_pll {debug_print_output} {0}
    set_instance_parameter_value system_pll {debug_use_rbc_taf_method} {0}
    set_instance_parameter_value system_pll {gui_device_speed_grade} {1}
    set_instance_parameter_value system_pll {gui_pll_mode} {Integer-N PLL}
    set_instance_parameter_value system_pll {gui_reference_clock_frequency} {50.0}
    set_instance_parameter_value system_pll {gui_channel_spacing} {0.0}
    set_instance_parameter_value system_pll {gui_operation_mode} {direct}
    set_instance_parameter_value system_pll {gui_feedback_clock} {Global Clock}
    set_instance_parameter_value system_pll {gui_fractional_cout} {32}
    set_instance_parameter_value system_pll {gui_dsm_out_sel} {1st_order}
    set_instance_parameter_value system_pll {gui_use_locked} {1}
    set_instance_parameter_value system_pll {gui_en_adv_params} {0}
    set_instance_parameter_value system_pll {gui_number_of_clocks} {2}
    set_instance_parameter_value system_pll {gui_multiply_factor} {1}
    set_instance_parameter_value system_pll {gui_frac_multiply_factor} {1.0}
    set_instance_parameter_value system_pll {gui_divide_factor_n} {1}
    set_instance_parameter_value system_pll {gui_cascade_counter0} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency0} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c0} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency0} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units0} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift0} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg0} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift0} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle0} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter1} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency1} {50.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c1} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency1} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units1} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift1} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg1} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift1} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle1} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter2} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency2} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c2} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency2} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units2} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift2} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg2} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift2} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle2} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter3} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency3} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c3} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency3} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units3} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift3} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg3} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift3} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle3} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter4} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency4} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c4} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency4} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units4} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift4} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg4} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift4} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle4} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter5} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency5} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c5} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency5} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units5} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift5} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg5} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift5} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle5} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter6} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency6} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c6} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency6} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units6} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift6} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg6} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift6} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle6} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter7} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency7} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c7} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency7} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units7} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift7} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg7} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift7} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle7} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter8} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency8} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c8} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency8} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units8} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift8} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg8} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift8} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle8} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter9} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency9} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c9} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency9} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units9} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift9} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg9} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift9} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle9} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter10} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency10} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c10} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency10} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units10} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift10} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg10} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift10} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle10} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter11} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency11} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c11} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency11} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units11} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift11} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg11} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift11} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle11} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter12} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency12} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c12} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency12} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units12} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift12} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg12} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift12} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle12} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter13} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency13} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c13} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency13} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units13} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift13} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg13} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift13} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle13} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter14} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency14} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c14} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency14} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units14} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift14} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg14} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift14} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle14} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter15} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency15} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c15} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency15} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units15} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift15} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg15} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift15} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle15} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter16} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency16} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c16} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency16} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units16} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift16} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg16} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift16} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle16} {50}
    set_instance_parameter_value system_pll {gui_cascade_counter17} {0}
    set_instance_parameter_value system_pll {gui_output_clock_frequency17} {100.0}
    set_instance_parameter_value system_pll {gui_divide_factor_c17} {1}
    set_instance_parameter_value system_pll {gui_actual_output_clock_frequency17} {0 MHz}
    set_instance_parameter_value system_pll {gui_ps_units17} {ps}
    set_instance_parameter_value system_pll {gui_phase_shift17} {0}
    set_instance_parameter_value system_pll {gui_phase_shift_deg17} {0.0}
    set_instance_parameter_value system_pll {gui_actual_phase_shift17} {0}
    set_instance_parameter_value system_pll {gui_duty_cycle17} {50}
    set_instance_parameter_value system_pll {gui_pll_auto_reset} {Off}
    set_instance_parameter_value system_pll {gui_pll_bandwidth_preset} {Auto}
    set_instance_parameter_value system_pll {gui_en_reconf} {0}
    set_instance_parameter_value system_pll {gui_en_dps_ports} {0}
    set_instance_parameter_value system_pll {gui_en_phout_ports} {0}
    set_instance_parameter_value system_pll {gui_phout_division} {1}
    set_instance_parameter_value system_pll {gui_mif_generate} {0}
    set_instance_parameter_value system_pll {gui_enable_mif_dps} {0}
    set_instance_parameter_value system_pll {gui_dps_cntr} {C0}
    set_instance_parameter_value system_pll {gui_dps_num} {1}
    set_instance_parameter_value system_pll {gui_dps_dir} {Positive}
    set_instance_parameter_value system_pll {gui_refclk_switch} {0}
    set_instance_parameter_value system_pll {gui_refclk1_frequency} {100.0}
    set_instance_parameter_value system_pll {gui_switchover_mode} {Automatic Switchover}
    set_instance_parameter_value system_pll {gui_switchover_delay} {0}
    set_instance_parameter_value system_pll {gui_active_clk} {0}
    set_instance_parameter_value system_pll {gui_clk_bad} {0}
    set_instance_parameter_value system_pll {gui_enable_cascade_out} {0}
    set_instance_parameter_value system_pll {gui_cascade_outclk_index} {0}
    set_instance_parameter_value system_pll {gui_enable_cascade_in} {0}
    set_instance_parameter_value system_pll {gui_pll_cascading_mode} {Create an adjpllin signal to connect with an upstream PLL}
}

proc add_instance_system_pll_ref_clk_50m { } {
    add_instance system_pll_ref_clk_50m altera_clock_bridge
    set_instance_parameter_value system_pll_ref_clk_50m {EXPLICIT_CLOCK_RATE} {50000000.0}
    set_instance_parameter_value system_pll_ref_clk_50m {NUM_CLOCK_OUTPUTS} {1}
}

proc add_instance_system_reset { } {
    add_instance system_reset altera_reset_bridge
    set_instance_parameter_value system_reset {ACTIVE_LOW_RESET} {0}
    set_instance_parameter_value system_reset {SYNCHRONOUS_EDGES} {none}
    set_instance_parameter_value system_reset {NUM_RESET_OUTPUTS} {1}
    set_instance_parameter_value system_reset {USE_RESET_REQUEST} {0}
}

proc add_connections_and_other_settings {} {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    # connections and connection parameters
    add_connection nios2_gen2.data_master ddr_emif.avl_0 avalon
    set_connection_parameter_value nios2_gen2.data_master/ddr_emif.avl_0 arbitrationPriority {8}
    set_connection_parameter_value nios2_gen2.data_master/ddr_emif.avl_0 baseAddress {0x40000000}
    set_connection_parameter_value nios2_gen2.data_master/ddr_emif.avl_0 defaultConnection {0}

    add_connection nios2_gen2.data_master nios2_gen2.debug_mem_slave avalon
    set_connection_parameter_value nios2_gen2.data_master/nios2_gen2.debug_mem_slave arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/nios2_gen2.debug_mem_slave baseAddress {0x00100000}
    set_connection_parameter_value nios2_gen2.data_master/nios2_gen2.debug_mem_slave defaultConnection {0}

    add_connection nios2_gen2.data_master fast_peripheral_bridge.s0 avalon
    set_connection_parameter_value nios2_gen2.data_master/fast_peripheral_bridge.s0 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/fast_peripheral_bridge.s0 baseAddress {0x10000000}
    set_connection_parameter_value nios2_gen2.data_master/fast_peripheral_bridge.s0 defaultConnection {0}

    add_connection nios2_gen2.data_master nios_ocram_8k.s1 avalon
    set_connection_parameter_value nios2_gen2.data_master/nios_ocram_8k.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/nios_ocram_8k.s1 baseAddress {0x2000}
    set_connection_parameter_value nios2_gen2.data_master/nios_ocram_8k.s1 defaultConnection {0}

    add_connection nios2_gen2.data_master default_slave.slave avalon
    set_connection_parameter_value nios2_gen2.data_master/default_slave.slave arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/default_slave.slave baseAddress {0x0000}
    set_connection_parameter_value nios2_gen2.data_master/default_slave.slave defaultConnection {1}

    add_connection nios2_gen2.instruction_master ddr_emif.avl_0 avalon
    set_connection_parameter_value nios2_gen2.instruction_master/ddr_emif.avl_0 arbitrationPriority {8}
    set_connection_parameter_value nios2_gen2.instruction_master/ddr_emif.avl_0 baseAddress {0x40000000}
    set_connection_parameter_value nios2_gen2.instruction_master/ddr_emif.avl_0 defaultConnection {0}

    add_connection nios2_gen2.instruction_master nios2_gen2.debug_mem_slave avalon
    set_connection_parameter_value nios2_gen2.instruction_master/nios2_gen2.debug_mem_slave arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.instruction_master/nios2_gen2.debug_mem_slave baseAddress {0x00100000}
    set_connection_parameter_value nios2_gen2.instruction_master/nios2_gen2.debug_mem_slave defaultConnection {0}

    add_connection nios2_gen2.instruction_master nios_ocram_8k.s1 avalon
    set_connection_parameter_value nios2_gen2.instruction_master/nios_ocram_8k.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.instruction_master/nios_ocram_8k.s1 baseAddress {0x2000}
    set_connection_parameter_value nios2_gen2.instruction_master/nios_ocram_8k.s1 defaultConnection {0}

    add_connection nios2_gen2.instruction_master default_slave.slave avalon
    set_connection_parameter_value nios2_gen2.instruction_master/default_slave.slave arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.instruction_master/default_slave.slave baseAddress {0x0000}
    set_connection_parameter_value nios2_gen2.instruction_master/default_slave.slave defaultConnection {1}

    add_connection slow_peripheral_bridge.m0 jtag_uart.avalon_jtag_slave avalon
    set_connection_parameter_value slow_peripheral_bridge.m0/jtag_uart.avalon_jtag_slave arbitrationPriority {1}
    set_connection_parameter_value slow_peripheral_bridge.m0/jtag_uart.avalon_jtag_slave baseAddress {0x0098}
    set_connection_parameter_value slow_peripheral_bridge.m0/jtag_uart.avalon_jtag_slave defaultConnection {0}

    add_connection slow_peripheral_bridge.m0 sysid.control_slave avalon
    set_connection_parameter_value slow_peripheral_bridge.m0/sysid.control_slave arbitrationPriority {1}
    set_connection_parameter_value slow_peripheral_bridge.m0/sysid.control_slave baseAddress {0x0090}
    set_connection_parameter_value slow_peripheral_bridge.m0/sysid.control_slave defaultConnection {0}

    add_connection slow_peripheral_bridge.m0 resets.mm_bridge_s0 avalon
    set_connection_parameter_value slow_peripheral_bridge.m0/resets.mm_bridge_s0 arbitrationPriority {1}
    set_connection_parameter_value slow_peripheral_bridge.m0/resets.mm_bridge_s0 baseAddress {0x00c0}
    set_connection_parameter_value slow_peripheral_bridge.m0/resets.mm_bridge_s0 defaultConnection {0}

    add_connection fast_peripheral_bridge.m0 slow_peripheral_bridge.s0 avalon
    set_connection_parameter_value fast_peripheral_bridge.m0/slow_peripheral_bridge.s0 arbitrationPriority {1}
    set_connection_parameter_value fast_peripheral_bridge.m0/slow_peripheral_bridge.s0 baseAddress {0x0000}
    set_connection_parameter_value fast_peripheral_bridge.m0/slow_peripheral_bridge.s0 defaultConnection {0}

    add_connection slow_peripheral_bridge.m0 led_pio_out.s1 avalon
    set_connection_parameter_value slow_peripheral_bridge.m0/led_pio_out.s1 arbitrationPriority {1}
    set_connection_parameter_value slow_peripheral_bridge.m0/led_pio_out.s1 baseAddress {0x0080}
    set_connection_parameter_value slow_peripheral_bridge.m0/led_pio_out.s1 defaultConnection {0}

    add_connection slow_peripheral_bridge.m0 hires_timer.s1 avalon
    set_connection_parameter_value slow_peripheral_bridge.m0/hires_timer.s1 arbitrationPriority {1}
    set_connection_parameter_value slow_peripheral_bridge.m0/hires_timer.s1 baseAddress {0x0000}
    set_connection_parameter_value slow_peripheral_bridge.m0/hires_timer.s1 defaultConnection {0}

    add_connection slow_peripheral_bridge.m0 slow_default_slave.slave avalon
    set_connection_parameter_value slow_peripheral_bridge.m0/slow_default_slave.slave arbitrationPriority {1}
    set_connection_parameter_value slow_peripheral_bridge.m0/slow_default_slave.slave baseAddress {0x0000}
    set_connection_parameter_value slow_peripheral_bridge.m0/slow_default_slave.slave defaultConnection {1}

    add_connection master.master ddr_emif.avl_0 avalon
    set_connection_parameter_value master.master/ddr_emif.avl_0 arbitrationPriority {1}
    set_connection_parameter_value master.master/ddr_emif.avl_0 baseAddress {0x40000000}
    set_connection_parameter_value master.master/ddr_emif.avl_0 defaultConnection {0}

    add_connection master.master fast_peripheral_bridge.s0 avalon
    set_connection_parameter_value master.master/fast_peripheral_bridge.s0 arbitrationPriority {1}
    set_connection_parameter_value master.master/fast_peripheral_bridge.s0 baseAddress {0x10000000}
    set_connection_parameter_value master.master/fast_peripheral_bridge.s0 defaultConnection {0}

    add_connection master.master default_slave.slave avalon
    set_connection_parameter_value master.master/default_slave.slave arbitrationPriority {1}
    set_connection_parameter_value master.master/default_slave.slave baseAddress {0x0000}
    set_connection_parameter_value master.master/default_slave.slave defaultConnection {1}

    add_connection ddr_emif_pll_ref_clk_50m.out_clk resets.ddr_ref_clk_in_clk clock

    add_connection ddr_emif_pll_ref_clk_50m.out_clk ddr_emif.pll_ref_clk clock

    add_connection system_pll_ref_clk_50m.out_clk resets.pll_ref_clk_in_clk clock

    add_connection system_pll_ref_clk_50m.out_clk system_pll.refclk clock

    add_connection system_pll.outclk0 nios2_gen2.clk clock

    add_connection system_pll.outclk0 master.clk clock

    add_connection system_pll.outclk0 fast_peripheral_bridge.clk clock

    add_connection system_pll.outclk0 nios_ocram_8k.clk1 clock

    add_connection system_pll.outclk0 default_slave.clock clock

    add_connection system_pll.outclk0 ddr_emif.mp_cmd_clk_0 clock

    add_connection system_pll.outclk0 ddr_emif.mp_rfifo_clk_0 clock

    add_connection system_pll.outclk0 ddr_emif.mp_wfifo_clk_0 clock

    add_connection system_pll.outclk1 sysid.clk clock

    add_connection system_pll.outclk1 jtag_uart.clk clock

    add_connection system_pll.outclk1 slow_peripheral_bridge.clk clock

    add_connection system_pll.outclk1 led_pio_out.clk clock

    add_connection system_pll.outclk1 hires_timer.clk clock

    add_connection system_pll.outclk1 slow_default_slave.clock clock

    add_connection system_pll.outclk1 resets.system_in_clk clock

    add_connection resets.ddr_emif_status_breakout_status ddr_emif.status conduit
    set_connection_parameter_value resets.ddr_emif_status_breakout_status/ddr_emif.status endPort {}
    set_connection_parameter_value resets.ddr_emif_status_breakout_status/ddr_emif.status endPortLSB {0}
    set_connection_parameter_value resets.ddr_emif_status_breakout_status/ddr_emif.status startPort {}
    set_connection_parameter_value resets.ddr_emif_status_breakout_status/ddr_emif.status startPortLSB {0}
    set_connection_parameter_value resets.ddr_emif_status_breakout_status/ddr_emif.status width {0}

    add_connection resets.ddr_pll_sharing_to_pll_locked_pll_sharing ddr_emif.pll_sharing conduit
    set_connection_parameter_value resets.ddr_pll_sharing_to_pll_locked_pll_sharing/ddr_emif.pll_sharing endPort {}
    set_connection_parameter_value resets.ddr_pll_sharing_to_pll_locked_pll_sharing/ddr_emif.pll_sharing endPortLSB {0}
    set_connection_parameter_value resets.ddr_pll_sharing_to_pll_locked_pll_sharing/ddr_emif.pll_sharing startPort {}
    set_connection_parameter_value resets.ddr_pll_sharing_to_pll_locked_pll_sharing/ddr_emif.pll_sharing startPortLSB {0}
    set_connection_parameter_value resets.ddr_pll_sharing_to_pll_locked_pll_sharing/ddr_emif.pll_sharing width {0}

    add_connection system_pll.locked resets.pll_pll_reset_monitor_pll_locked conduit
    set_connection_parameter_value system_pll.locked/resets.pll_pll_reset_monitor_pll_locked endPort {}
    set_connection_parameter_value system_pll.locked/resets.pll_pll_reset_monitor_pll_locked endPortLSB {0}
    set_connection_parameter_value system_pll.locked/resets.pll_pll_reset_monitor_pll_locked startPort {}
    set_connection_parameter_value system_pll.locked/resets.pll_pll_reset_monitor_pll_locked startPortLSB {0}
    set_connection_parameter_value system_pll.locked/resets.pll_pll_reset_monitor_pll_locked width {0}

    add_connection nios2_gen2.irq jtag_uart.irq interrupt
    set_connection_parameter_value nios2_gen2.irq/jtag_uart.irq irqNumber {0}

    add_connection nios2_gen2.irq hires_timer.irq interrupt
    set_connection_parameter_value nios2_gen2.irq/hires_timer.irq irqNumber {5}

    add_connection ddr_emif.afi_reset resets.ddr_afi_reset_in_reset reset

    add_connection resets.ddr_reset_out_reset_out ddr_emif.global_reset reset

    add_connection resets.ddr_soft_reset_reset_out ddr_emif.soft_reset reset

    add_connection nios2_gen2.debug_reset_request debug_reset_req.in_reset reset

    add_connection master.master_reset debug_reset_req.in_reset reset

    add_connection system_reset.out_reset master.clk_reset reset

    add_connection debug_reset_req.out_reset resets.debug_resets_in_reset reset

    add_connection system_reset.out_reset ddr_emif.mp_cmd_reset_n_0 reset

    add_connection system_reset.out_reset ddr_emif.mp_rfifo_reset_n_0 reset

    add_connection system_reset.out_reset ddr_emif.mp_wfifo_reset_n_0 reset

    add_connection system_reset.out_reset nios2_gen2.reset reset

    add_connection system_reset.out_reset slow_peripheral_bridge.reset reset

    add_connection system_reset.out_reset sysid.reset reset

    add_connection system_reset.out_reset jtag_uart.reset reset

    add_connection system_reset.out_reset hires_timer.reset reset

    add_connection system_reset.out_reset led_pio_out.reset reset

    add_connection system_reset.out_reset slow_default_slave.reset reset

    add_connection system_reset.out_reset default_slave.reset reset

    add_connection system_reset.out_reset fast_peripheral_bridge.reset reset

    add_connection system_reset.out_reset nios_ocram_8k.reset1 reset

    add_connection system_reset.out_reset resets.system_in_reset reset

    add_connection resets.pll_reset_out_reset_out system_pll.reset reset

    add_connection resets.system_reset_out_reset_out system_reset.in_reset reset

    # exported interfaces
    add_interface ddr_emif_pll_ref_clk_50m_in_clk clock sink
    set_interface_property ddr_emif_pll_ref_clk_50m_in_clk EXPORT_OF ddr_emif_pll_ref_clk_50m.in_clk
    add_interface led_pio_out_external_connection conduit end
    set_interface_property led_pio_out_external_connection EXPORT_OF led_pio_out.external_connection
    add_interface memory conduit end
    set_interface_property memory EXPORT_OF ddr_emif.memory
    add_interface oct conduit end
    set_interface_property oct EXPORT_OF ddr_emif.oct
    add_interface resets_cpu_reset_n_in_reset reset sink
    set_interface_property resets_cpu_reset_n_in_reset EXPORT_OF resets.cpu_reset_n_in_reset
    add_interface system_pll_ref_clk_50m_in_clk clock sink
    set_interface_property system_pll_ref_clk_50m_in_clk EXPORT_OF system_pll_ref_clk_50m.in_clk

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {AUTO}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
    set_interconnect_requirement {mm_interconnect_0|cmd_mux.src/ddr_emif_avl_0_agent.cp} {qsys_mm.postTransform.pipelineCount} {1}
    set_interconnect_requirement {mm_interconnect_0|ddr_emif_avl_0_agent.rp/router_003.sink} {qsys_mm.postTransform.pipelineCount} {1}
}

create_qsys_system

save_system {test_sys.qsys}

