/*
 * Copyright (c) 2016-2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */
#ifndef __EVENT_TIMER_REGS_H__
#define __EVENT_TIMER_REGS_H__

#include <io.h>

#define IORD_EVENT_TIMER(base)	IORD(base, 0)

#define EVENT_TIMER_CAPTURE_TIMEOUT_COUNT_MASK	(0xFFFFFFFF)
#define EVENT_TIMER_CAPTURE_TIMEOUT_COUNT_OFST	(0)

#endif /* __EVENT_TIMER_REGS_H__ */
