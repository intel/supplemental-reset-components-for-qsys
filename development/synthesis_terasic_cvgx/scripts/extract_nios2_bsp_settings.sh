#!/bin/sh
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

