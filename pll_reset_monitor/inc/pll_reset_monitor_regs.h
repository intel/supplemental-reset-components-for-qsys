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
#ifndef __PLL_RESET_MONITOR_REGS_H__
#define __PLL_RESET_MONITOR_REGS_H__

#include <io.h>

#define IORD_PLL_RESET_MONITOR(base)	IORD(base, 0)

#define PLL_RESET_MONITOR_UNLOCK_COUNT_MASK	(0xFF000000)
#define PLL_RESET_MONITOR_UNLOCK_COUNT_OFST	(24)

#define PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH_MASK	(0x00F00000)
#define PLL_RESET_MONITOR_LOCK_COUNTER_WIDTH_OFST	(20)

#define PLL_RESET_MONITOR_CAPTURE_LOCK_COUNT_MASK	(0xFFFFF)
#define PLL_RESET_MONITOR_CAPTURE_LOCK_COUNT_OFST	(0)

#endif /* __PLL_RESET_MONITOR_REGS_H__ */
