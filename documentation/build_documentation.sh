#!/bin/bash
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

[ ${#} -lt "1" ] && {
cat << EOF

USAGE: $(basename ${0}) <arg> [<arg>] ...

    <arg> may be a specific build stage to execute followed by additional build
          stages to execute.  Or the argument may be "all" to execute all build
          stages.

Typical usage is: '$(basename ${0}) all'

EOF
exit 1
}

set -x
#
# change into the directory of this script
#
cd $(dirname ${0:?})
pwd

#
# setup a build log directory
#
BUILD_LOGS="$(pwd)/build_logs"

[ -d "${BUILD_LOGS:?}" ] || {
	mkdir -p "${BUILD_LOGS:?}"
}

#
# verify that the tools we know we need are available
#
type \
	-P \
	pdflatex \
	> "${BUILD_LOGS:?}"/00_tool_check_log.txt 2>&1 \
	|| {
		set +x
		echo ""
		echo "ERROR: could not locate all of the tools we need."
		echo ""
		exit 1
	}

set +x

#
# build the documentation
#
while [ -n "${1}" ] ; do
case "${1}" in

01|initial_pdflatex|all)
set -x
[ -f howto_supplemental_reset_components_for_qsys.pdf ] && {
	set +x
	echo "ERROR: 'pdf' file already exists"
	exit 1
}
[ -f howto_supplemental_reset_components_for_qsys.aux ] && {
	set +x
	echo "ERROR: 'aux' file already exists"
	exit 1
}
[ -f howto_supplemental_reset_components_for_qsys.toc ] && {
	set +x
	echo "ERROR: 'toc' file already exists"
	exit 1
}
[ -f howto_supplemental_reset_components_for_qsys.out ] && {
	set +x
	echo "ERROR: 'out' file already exists"
	exit 1
}
pdflatex \
	-halt-on-error \
	howto_supplemental_reset_components_for_qsys.tex \
	> "${BUILD_LOGS:?}"/01_initial_pdflatex.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

02|second_pdflatex|all)
set -x
[ -f howto_supplemental_reset_components_for_qsys.log ] || {
	set +x
	echo "ERROR: 'log' file does not exists"
	exit 1
}
grep \
	"Warning" \
	howto_supplemental_reset_components_for_qsys.log \
	> "${BUILD_LOGS:?}"/02_second_pdflatex.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }

pdflatex \
	-halt-on-error \
	howto_supplemental_reset_components_for_qsys.tex \
	> "${BUILD_LOGS:?}"/02_second_pdflatex.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

03|third_pdflatex|all)
set -x
[ -f howto_supplemental_reset_components_for_qsys.log ] || {
	set +x
	echo "ERROR: 'log' file does not exists"
	exit 1
}
grep \
	"Warning" \
	howto_supplemental_reset_components_for_qsys.log \
	> "${BUILD_LOGS:?}"/03_third_pdflatex.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }

pdflatex \
	-halt-on-error \
	howto_supplemental_reset_components_for_qsys.tex \
	> "${BUILD_LOGS:?}"/03_third_pdflatex.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

04|log_check|all)
set -x
[ -f howto_supplemental_reset_components_for_qsys.log ] || {
	set +x
	echo "ERROR: 'log' file does not exists"
	exit 1
}
grep \
	"Warning" \
	howto_supplemental_reset_components_for_qsys.log \
	> "${BUILD_LOGS:?}"/04_log_check.txt 2>&1 \
	&& { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

05|finale|all)
cat << EOF

The PDF file is ready for use.

Please see 'howto_supplemental_reset_components_for_qsys.pdf'.

EOF
;;&

clean)
set -x
rm \
	howto_supplemental_reset_components_for_qsys.aux \
	howto_supplemental_reset_components_for_qsys.log \
	howto_supplemental_reset_components_for_qsys.out \
	howto_supplemental_reset_components_for_qsys.pdf \
	howto_supplemental_reset_components_for_qsys.toc \
	> "${BUILD_LOGS:?}"/clean.txt 2>&1 \
	|| { set +x ; echo "ERROR: see logs" ; exit 1 ; }
set +x
;;&

*)
;;
esac
shift
done

exit 0

