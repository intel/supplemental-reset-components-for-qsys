#!/bin/bash
#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#

#
# This script is designed to take the _hw.tcl file exported from Qsys for the
# complete Qsys system and transform it into a Qsys system creation script that
# can be passed into qsys-script to create the system from an original source
# TCL script.  To create the _hw.tcl script, run qsys-edit, open your existing
# Qsys system and choose File->"Export system as hw.tcl component".
#
# Assign proper values for the 5 environment variables below before running
# this script.
#

#
# This should be a relative path from the location of this script to the
# location of the Qsys _hw.tcl file.
#
QSYS_HWTCL_INPUT_FILE="../reset_subsys_hw.tcl"

#
# This should be a relative path from the location of this script to the
# location of your output file.
#
OUTPUT_FILE="create_reset_subsys_qsys.tcl"

#
# This is the name of the Qsys system you want to create.
#
SYSTEM_NAME="reset_subsys"

#
# This is the device family that your Qsys system will run in.
#
THE_DEVICE_FAMILY="CYCLONEV"

#
# This is the device family that your Qsys system will run in.
#
THE_DEVICE="5CGXFC5C6F27C7"

#------------------------------------------------------------------------------

cd $(dirname ${0})

[ -f "${QSYS_HWTCL_INPUT_FILE:?}" ] || {
	set +x
	echo "ERROR: Qsys input file does not exist..."
	echo "'${QSYS_HWTCL_INPUT_FILE:?}'"
	realpath "${QSYS_HWTCL_INPUT_FILE:?}"
	exit 1
}

[ -f "${OUTPUT_FILE:?}" ] && {
	set +x
	echo "ERROR: Output file already exists..."
	echo "'${OUTPUT_FILE:?}'"
	realpath "${OUTPUT_FILE:?}"
	exit 1
}

set -x

cat << EOF > ${OUTPUT_FILE:?} || { set +x; echo "ERROR"; exit 1; }
package require -exact qsys 14.0

create_system {${SYSTEM_NAME:?}}

set_project_property {DEVICE_FAMILY} {${THE_DEVICE_FAMILY:?}}
set_project_property {DEVICE} {${THE_DEVICE:?}}

proc create_qsys_system {} {

    #
    # Manually reorder this list of component instances to reflect the order
    # that you wish to see them appear in the Qsys GUI.
    #
EOF

sed \
-e "/[ \t]*add_instance[ \t]*[^ \t]*[ \t]*.*/! d" \
-e "s/[ \t]*\(add_instance\)[ \t]*\([^ \t]*\)[ \t]*.*/    \1_\2/" \
${QSYS_HWTCL_INPUT_FILE:?} >> ${OUTPUT_FILE:?} || { set +x; echo "ERROR"; exit 1; }

cat << EOF >> ${OUTPUT_FILE:?} || { set +x; echo "ERROR"; exit 1; }

    #
    # After all component instantiations are made, add the component connections
    # and other settings to the system.
    #
    add_connections_and_other_settings
}

EOF

sed \
-e "/^proc compose { } {$/,/^}$/! d" \
-e "/^proc compose { } {$/ d" \
-e "/^}$/ d" \
-e "/[ \t]*add_instance[ \t]*[^ \t]*[ \t]*.*/,/^$/! d" \
-e "/[ \t]*add_instance[ \t]*[^ \t]*[ \t]*.*/,/^$/ {
h
s/[ \t]*\(add_instance\)[ \t]*\([^ \t]*\)[ \t]*.*/proc \1_\2 { } {/p
s/^$/}/p
x
s/\([ \t]*add_instance[ \t]*[^ \t]*[ \t]*[^ \t]*\)[ \t]*[0-9.]*/\1/
p
d
}" \
${QSYS_HWTCL_INPUT_FILE:?} >> ${OUTPUT_FILE:?} || { set +x; echo "ERROR"; exit 1; }

cat << EOF >> ${OUTPUT_FILE:?} || { set +x; echo "ERROR"; exit 1; }
proc add_connections_and_other_settings {} {
EOF

sed \
-e "/^proc compose { } {$/,/^}$/! d" \
-e "/^proc compose { } {$/ d" \
-e "/^}$/ d" \
-e "/[ \t]*add_instance[ \t]*[^ \t]*[ \t]*.*/,/^$/ d" \
${QSYS_HWTCL_INPUT_FILE:?} >> ${OUTPUT_FILE:?} || { set +x; echo "ERROR"; exit 1; }

cat << EOF >> ${OUTPUT_FILE:?} || { set +x; echo "ERROR"; exit 1; }
}

create_qsys_system

save_system {${SYSTEM_NAME:?}.qsys}

EOF

set +x

echo "Script completed successfully..."

exit 0

