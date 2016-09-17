/*
 * Copyright (c) 2016 Intel Corporation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */
#ifndef __RESET_DEBOUNCER_REGS_H__
#define __RESET_DEBOUNCER_REGS_H__

#include <io.h>

#define IORD_RESET_DEBOUNCER(base)	IORD(base, 0)

#define RESET_DEBOUNCER_ASSERTION_EDGE_COUNT_MASK	(0xE0000000)
#define RESET_DEBOUNCER_ASSERTION_EDGE_COUNT_OFST	(29)

#define RESET_DEBOUNCER_DEASSERTION_EDGE_COUNT_MASK	(0x1F000000)
#define RESET_DEBOUNCER_DEASSERTION_EDGE_COUNT_OFST	(24)

#define RESET_DEBOUNCER_CAPTURE_DEBOUNCE_COUNT_MASK	(0x00FFFFFF)
#define RESET_DEBOUNCER_CAPTURE_DEBOUNCE_COUNT_OFST	(0)

#endif /* __RESET_DEBOUNCER_REGS_H__ */
