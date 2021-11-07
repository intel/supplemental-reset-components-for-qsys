#
# Copyright (c) 2016-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT-0
#
global quartus

set PROJECT_NAME [ lindex $quartus(args) 0 ]
set SCRIPT_NAME [ lindex $quartus(args) 1 ]

if [project_exists $PROJECT_NAME] {

	project_open $PROJECT_NAME

	post_message -type info "Running TCL script:"
	post_message -type info "'$SCRIPT_NAME'"

	source "$SCRIPT_NAME"

	project_close
	qexit -success

} else {

	post_message -type error "project does not exist..."
	post_message -type error "'$PROJECT_NAME'"
	qexit -error
}

