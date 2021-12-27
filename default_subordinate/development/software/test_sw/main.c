/*
 * Copyright (c) 2021 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */

#include "alt_types.h"

#define DEBUG_ADDR	(0x00000014)
#define WR_DEBUG(x)	*((volatile alt_u32*)(DEBUG_ADDR)) = (x)

#define INF_LOOP_INST	(0x0000006f)
#define INF_LOOP_ADDR	(0x00000018)
#define JUMP_INF_LOOP	*(volatile alt_u32*)(INF_LOOP_ADDR) = INF_LOOP_INST;\
			((void (*)(void))(INF_LOOP_ADDR))();

#define LOOP_COUNT_ADDR	(0x0000001C)
#define READ_LOOP_COUNT	*((volatile alt_u32*)(LOOP_COUNT_ADDR))
#define INCR_LOOP_COUNT	*((volatile alt_u32*)(LOOP_COUNT_ADDR)) += 1

#define DEFSUB_0_BASE	(0x00021000)
#define DEFSUB_1_BASE	(0x00022000)
#define DEFSUB_2_BASE	(0x00023000)
#define DEFSUB_3_BASE	(0x00024000)
#define DEFSUB_4_BASE	(0x00025000)
#define WR_DEFSUB(x)	*((volatile alt_u32*)(x)) = 0
#define RD_DEFSUB(x)	*((volatile alt_u32*)(x))
#define JMP_DEFSUB(x)	((void (*)(void))(x))()

void alt_main(void) {

	while(1) {
		switch(READ_LOOP_COUNT) {
			case 0:		// READ THEN WRITE DEFSUB_0
				INCR_LOOP_COUNT;
				RD_DEFSUB(DEFSUB_0_BASE);
				WR_DEFSUB(DEFSUB_0_BASE);
				JUMP_INF_LOOP
			case 1:		// WRITE THEN READ DEFSUB_0
				INCR_LOOP_COUNT;
				WR_DEFSUB(DEFSUB_0_BASE);
				RD_DEFSUB(DEFSUB_0_BASE);
				JUMP_INF_LOOP
			case 2:		// JUMP TO DEFSUB_0
				INCR_LOOP_COUNT;
				JMP_DEFSUB(DEFSUB_0_BASE);
				JUMP_INF_LOOP
			case 3:		// READ DEFSUB_1 SLVERR
				INCR_LOOP_COUNT;
				RD_DEFSUB(DEFSUB_1_BASE);
				JUMP_INF_LOOP
			case 4:		// WRITE DEFSUB_1 SLVERR
				INCR_LOOP_COUNT;
				WR_DEFSUB(DEFSUB_1_BASE);
				JUMP_INF_LOOP
			case 5:		// JUMP DEFSUB_1 SLVERR
				INCR_LOOP_COUNT;
				JMP_DEFSUB(DEFSUB_1_BASE);
				JUMP_INF_LOOP
			case 6:		// READ DEFSUB_2 DECERR
				INCR_LOOP_COUNT;
				RD_DEFSUB(DEFSUB_2_BASE);
				JUMP_INF_LOOP
			case 7:		// WRITE DEFSUB_2 DECERR
				INCR_LOOP_COUNT;
				WR_DEFSUB(DEFSUB_2_BASE);
				JUMP_INF_LOOP
			case 8:		// JUMP DEFSUB_2 DECERR
				INCR_LOOP_COUNT;
				JMP_DEFSUB(DEFSUB_2_BASE);
				JUMP_INF_LOOP
			case 9:		// READ DEFSUB_3 DECERR
				INCR_LOOP_COUNT;
				RD_DEFSUB(DEFSUB_3_BASE);
				JUMP_INF_LOOP
			case 10:	// WRITE DEFSUB_3 DECERR
				INCR_LOOP_COUNT;
				WR_DEFSUB(DEFSUB_3_BASE);
				JUMP_INF_LOOP
			case 11:	// JUMP DEFSUB_3 DECERR
				INCR_LOOP_COUNT;
				JMP_DEFSUB(DEFSUB_3_BASE);
				JUMP_INF_LOOP
			case 12:	// READ DEFSUB_4 DECERR
				INCR_LOOP_COUNT;
				RD_DEFSUB(DEFSUB_4_BASE);
				JUMP_INF_LOOP
			case 13:	// WRITE DEFSUB_4 DECERR
				INCR_LOOP_COUNT;
				WR_DEFSUB(DEFSUB_4_BASE);
				JUMP_INF_LOOP
			case 14:	// JUMP DEFSUB_4 DECERR
				INCR_LOOP_COUNT;
				JMP_DEFSUB(DEFSUB_4_BASE);
				JUMP_INF_LOOP
			default:
				JUMP_INF_LOOP
		}
	}
}

alt_u32 handle_trap(alt_u32 cause, alt_u32 epc, alt_u32 tval) __attribute__ ((section (".exceptions")));
alt_u32 handle_trap(alt_u32 cause, alt_u32 epc, alt_u32 tval)
{
	WR_DEBUG(cause);
	WR_DEBUG(epc);
	WR_DEBUG(tval);
	JUMP_INF_LOOP
	return 0;
}

