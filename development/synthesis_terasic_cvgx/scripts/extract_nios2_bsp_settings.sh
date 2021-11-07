#!/bin/sh
#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

[ -f "${1}" ] || {
echo ""
echo "BSP settings file \"${1}\" not found."
echo ""
echo "USAGE: ${0} <bsp_settings_file>"
echo ""
exit 1
}

nios2-bsp-query-settings --settings ${1} \
	--cmd "puts [ format \"--cpu-name %s \\\\\" [ get_cpu_name ] ]"

nios2-bsp-query-settings --settings ${1} --get-all --show-names | sed -e "s/\(.*\)/--set \1 \\\/"

nios2-bsp-query-settings --settings ${1} \
	--cmd "foreach next [ get_current_memory_regions ] { puts [ format \"--cmd add_memory_region %s \\\\\" \$next ] }"

nios2-bsp-query-settings --settings ${1} \
	--cmd "foreach next [ get_current_section_mappings ] { puts [ format \"--cmd add_section_mapping %s \\\\\" \$next ] }"

nios2-bsp-query-settings --settings ${1} \
	--cmd "foreach next [ get_available_sw_packages ] { puts [ format \"--cmd disable_sw_package %s \\\\\" \$next ] }" \
	| sed -e "s/:[0-9\.]*//"

nios2-bsp-query-settings --settings ${1} \
	--cmd "foreach next [ get_slave_descs ] { puts [ format \"--cmd set_driver %s %s \\\\\" [get_driver [get_module_name \$next]] [get_module_name \$next] ] }" \
	| sed -e "s/:[0-9\.]*//"

