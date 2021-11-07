#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
set PROJECT_NAME "test_project_top"

if [project_exists $PROJECT_NAME] {
	post_message -type error "project already exists..."
	post_message -type error "'$PROJECT_NAME'"
	qexit -error
}

project_new $PROJECT_NAME

# Project-Wide Assignments
# ========================
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files

# ------------------------------------------------------------------------------
# NOTE: the order of these files matters.  The *top.sdc must come after the
# Qsys QIP file, otherwise the constraints for the HMC can be corrupted.
# ------------------------------------------------------------------------------
set_global_assignment -name QIP_FILE software/boot_check/mem_init/meminit.qip
set_global_assignment -name QIP_FILE test_sys/synthesis/test_sys.qip
set_global_assignment -name VERILOG_FILE hdl_src/test_project_top.v
set_global_assignment -name SDC_FILE hdl_src/test_project_top.sdc
# ------------------------------------------------------------------------------

# Pin & Location Assignments
# ==========================
set_location_assignment PIN_R20 -to CLOCK_50_B5B
set_location_assignment PIN_N20 -to CLOCK_50_B6A
set_location_assignment PIN_AB24 -to CPU_RESET_n
set_location_assignment PIN_AE6 -to DDR2LP_CA[0]
set_location_assignment PIN_AF6 -to DDR2LP_CA[1]
set_location_assignment PIN_AF7 -to DDR2LP_CA[2]
set_location_assignment PIN_AF8 -to DDR2LP_CA[3]
set_location_assignment PIN_U10 -to DDR2LP_CA[4]
set_location_assignment PIN_U11 -to DDR2LP_CA[5]
set_location_assignment PIN_AE9 -to DDR2LP_CA[6]
set_location_assignment PIN_AF9 -to DDR2LP_CA[7]
set_location_assignment PIN_AB12 -to DDR2LP_CA[8]
set_location_assignment PIN_AB11 -to DDR2LP_CA[9]
set_location_assignment PIN_AF14 -to DDR2LP_CKE[0]
set_location_assignment PIN_AE13 -to DDR2LP_CKE[1]
set_location_assignment PIN_P10 -to DDR2LP_CK_n
set_location_assignment PIN_N10 -to DDR2LP_CK_p
set_location_assignment PIN_R11 -to DDR2LP_CS_n[0]
set_location_assignment PIN_T11 -to DDR2LP_CS_n[1]
set_location_assignment PIN_AF11 -to DDR2LP_DM[0]
set_location_assignment PIN_AE18 -to DDR2LP_DM[1]
set_location_assignment PIN_AE20 -to DDR2LP_DM[2]
set_location_assignment PIN_AE24 -to DDR2LP_DM[3]
set_location_assignment PIN_AA14 -to DDR2LP_DQ[0]
set_location_assignment PIN_Y14 -to DDR2LP_DQ[1]
set_location_assignment PIN_AD11 -to DDR2LP_DQ[2]
set_location_assignment PIN_AD12 -to DDR2LP_DQ[3]
set_location_assignment PIN_Y13 -to DDR2LP_DQ[4]
set_location_assignment PIN_W12 -to DDR2LP_DQ[5]
set_location_assignment PIN_AD10 -to DDR2LP_DQ[6]
set_location_assignment PIN_AF12 -to DDR2LP_DQ[7]
set_location_assignment PIN_AC15 -to DDR2LP_DQ[8]
set_location_assignment PIN_AB15 -to DDR2LP_DQ[9]
set_location_assignment PIN_AC14 -to DDR2LP_DQ[10]
set_location_assignment PIN_AF13 -to DDR2LP_DQ[11]
set_location_assignment PIN_AB16 -to DDR2LP_DQ[12]
set_location_assignment PIN_AA16 -to DDR2LP_DQ[13]
set_location_assignment PIN_AE14 -to DDR2LP_DQ[14]
set_location_assignment PIN_AF18 -to DDR2LP_DQ[15]
set_location_assignment PIN_AD16 -to DDR2LP_DQ[16]
set_location_assignment PIN_AD17 -to DDR2LP_DQ[17]
set_location_assignment PIN_AC18 -to DDR2LP_DQ[18]
set_location_assignment PIN_AF19 -to DDR2LP_DQ[19]
set_location_assignment PIN_AC17 -to DDR2LP_DQ[20]
set_location_assignment PIN_AB17 -to DDR2LP_DQ[21]
set_location_assignment PIN_AF21 -to DDR2LP_DQ[22]
set_location_assignment PIN_AE21 -to DDR2LP_DQ[23]
set_location_assignment PIN_AE15 -to DDR2LP_DQ[24]
set_location_assignment PIN_AE16 -to DDR2LP_DQ[25]
set_location_assignment PIN_AC20 -to DDR2LP_DQ[26]
set_location_assignment PIN_AD21 -to DDR2LP_DQ[27]
set_location_assignment PIN_AF16 -to DDR2LP_DQ[28]
set_location_assignment PIN_AF17 -to DDR2LP_DQ[29]
set_location_assignment PIN_AD23 -to DDR2LP_DQ[30]
set_location_assignment PIN_AF23 -to DDR2LP_DQ[31]
set_location_assignment PIN_W13 -to DDR2LP_DQS_n[0]
set_location_assignment PIN_V14 -to DDR2LP_DQS_n[1]
set_location_assignment PIN_W15 -to DDR2LP_DQS_n[2]
set_location_assignment PIN_W17 -to DDR2LP_DQS_n[3]
set_location_assignment PIN_V13 -to DDR2LP_DQS_p[0]
set_location_assignment PIN_U14 -to DDR2LP_DQS_p[1]
set_location_assignment PIN_V15 -to DDR2LP_DQS_p[2]
set_location_assignment PIN_W16 -to DDR2LP_DQS_p[3]
set_location_assignment PIN_AE11 -to DDR2LP_OCT_RZQ
set_location_assignment PIN_L7 -to LEDG[0]
set_location_assignment PIN_K6 -to LEDG[1]
set_location_assignment PIN_D8 -to LEDG[2]
set_location_assignment PIN_E9 -to LEDG[3]
set_location_assignment PIN_A5 -to LEDG[4]
set_location_assignment PIN_B6 -to LEDG[5]
set_location_assignment PIN_H8 -to LEDG[6]
set_location_assignment PIN_H9 -to LEDG[7]
set_location_assignment PIN_F7 -to LEDR[0]
set_location_assignment PIN_F6 -to LEDR[1]
set_location_assignment PIN_G6 -to LEDR[2]
set_location_assignment PIN_G7 -to LEDR[3]
set_location_assignment PIN_J8 -to LEDR[4]
set_location_assignment PIN_J7 -to LEDR[5]
set_location_assignment PIN_K10 -to LEDR[6]
set_location_assignment PIN_K8 -to LEDR[7]
set_location_assignment PIN_H7 -to LEDR[8]
set_location_assignment PIN_J10 -to LEDR[9]

# Classic Timing Assignments
# ==========================
set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85

# Analysis & Synthesis Assignments
# ================================
set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name TOP_LEVEL_ENTITY $PROJECT_NAME

# Fitter Assignments
# ==================
set_global_assignment -name DEVICE 5CGXFC5C6F27C7
set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
set_global_assignment -name STRATIXV_CONFIGURATION_SCHEME "ACTIVE SERIAL X4"
set_global_assignment -name CRC_ERROR_OPEN_DRAIN ON
set_global_assignment -name RESERVE_DATA15_THROUGH_DATA8_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA7_THROUGH_DATA5_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name ACTIVE_SERIAL_CLOCK FREQ_100MHZ

# Assembler Assignments
# =====================
set_global_assignment -name ENABLE_OCT_DONE OFF
set_global_assignment -name POR_SCHEME "INSTANT ON"
set_global_assignment -name EN_USER_IO_WEAK_PULLUP ON
set_global_assignment -name POF_VERIFY_PROTECT OFF
set_global_assignment -name EN_SPI_IO_WEAK_PULLUP ON
set_global_assignment -name ENABLE_SPI_MODE_CHECK OFF
set_global_assignment -name FORCE_SSMCLK_TO_ISMCLK ON
set_global_assignment -name FALLBACK_TO_EXTERNAL_FLASH OFF
set_global_assignment -name EXTERNAL_FLASH_FALLBACK_ADDRESS 0
set_global_assignment -name USE_CONFIGURATION_DEVICE ON
set_global_assignment -name STRATIXII_CONFIGURATION_DEVICE EPCQ256

# Power Estimation Assignments
# ============================
set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"

# Advanced I/O Timing Assignments
# ===============================
set_global_assignment -name OUTPUT_IO_TIMING_NEAR_END_VMEAS "HALF VCCIO" -rise
set_global_assignment -name OUTPUT_IO_TIMING_NEAR_END_VMEAS "HALF VCCIO" -fall
set_global_assignment -name OUTPUT_IO_TIMING_FAR_END_VMEAS "HALF SIGNAL SWING" -rise
set_global_assignment -name OUTPUT_IO_TIMING_FAR_END_VMEAS "HALF SIGNAL SWING" -fall

# Fitter Assignments
# ==================
set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CS_n[1]
set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CKE[1]
set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_OCT_RZQ
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[7]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[9]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[8]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[7]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[0]

project_close
qexit -success

