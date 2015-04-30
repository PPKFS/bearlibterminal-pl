#define PROLOG_MODULE "bearlibterminal"
#include <SWI-cpp.h>
#include <SWI-Prolog.h>
#include "BearLibTerminal.h"

PlTerm color_to_term(color_t col)
{
	return PlCompound("color", PlTermv((long)(col >> 16), (long)(col >> 8), (long)(uint8_t)col, (long)(col >> 24)));
}

PREDICATE(blt_color_to_term, 2)
{
	return A2 = color_to_term((color_t)(long)A1);
}

PREDICATE(blt_open, 1)
{
	return A1 = terminal_open();
}

PREDICATE(blt_close, 0)
{
	terminal_close();
	return TRUE;
}

PREDICATE(blt_set, 2)
{
	return A2 = terminal_set((char*)A1);
}

PREDICATE(blt_color, 1)
{
	terminal_color((int)A1);
	return TRUE;
}

PREDICATE(blt_bkcolor, 1)
{
	terminal_bkcolor((int)A1);
	return TRUE;
}

PREDICATE(blt_composition, 1)
{
	terminal_composition((strcmp((char*)A1, "on") == 0));
	return TRUE;
}

PREDICATE(blt_layer, 1)
{
	terminal_layer((int)A1);
	return TRUE;
}

PREDICATE(blt_clear, 0)
{
	terminal_clear();
	return TRUE;
}

PREDICATE(blt_clear_area, 4)
{
	terminal_clear_area((int)A1, (int)A2, (int)A3, (int)A4);
	return TRUE;
}

PREDICATE(blt_crop, 4)
{
	terminal_crop((int)A1, (int)A2, (int)A3, (int)A4);
	return TRUE;
}

PREDICATE(blt_refresh, 0)
{
	terminal_refresh();
	return TRUE;
}

PREDICATE(blt_put, 3)
{
	terminal_put((int)A1, (int)A2, (int)A3);
	return TRUE;
}

PREDICATE(blt_pick, 4)
{
	return A4 = color_to_term(terminal_pick((int)A1, (int)A2, (int)A3));
}

PREDICATE(blt_pick_color, 4)
{
	return A4 = color_to_term(terminal_pick_color((int)A1, (int)A2, (int)A3));
}

PREDICATE(blt_pick_bkcolor, 3)
{
	return A3 = color_to_term(terminal_pick_color((int)A1, (int)A2));
}

PREDICATE(blt_put_ext, 9)
{
	color_t colors[] = {(color_t)(long)A6, (color_t)(long)A7, (color_t)(long)A8, (color_t)(long)A9};
	terminal_put_ext((int)A1, (int)A2, (int)A3, (int)A4, (int)A5, colors);
	return TRUE;	
}

PREDICATE(blt_put_ext, 5)
{
	terminal_put_ext((int)A1, (int)A2, (int)A3, (int)A4, (int)A5, NULL);
	return TRUE;	
}

PREDICATE(blt_print, 4)
{
	return A4 = terminal_print((int)A1, (int)A2, (char*)A3);
}

PREDICATE(blt_measure, 2)
{
	return A2 = terminal_measure((char*)A1);
}

PREDICATE(blt_state, 2)
{
	return A2 = terminal_state((int)A1);
}

PREDICATE(blt_check, 2)
{
	return A2 = terminal_check((int)A1);
}

PREDICATE(blt_has_input, 1)
{
	return A1 = terminal_has_input();
}

PREDICATE(blt_read, 1)
{
	return A1 = terminal_read();
}

PREDICATE(blt_peek, 1)
{
	return A1 = terminal_peek();
}

PREDICATE(blt_read_str, 5)
{
	char* buffer = NULL;
	color_t len = terminal_read_str((int)A1, (int)A2, buffer, (int)A4);
	if(A5 = color_to_term(len))
		return A3 = buffer;
	else
		return FALSE;
}

PREDICATE(blt_delay, 1)
{
	terminal_delay((int)A1);
	return TRUE;
}

PREDICATE(blt_color_from_name, 2)
{
	return A2 = (long)color_from_name((char*)A1);
}

PREDICATE(blt_color_from_argb, 5)
{
	return A5 = (long)color_from_argb((int)A1, (int)A2, (int)A3, (int)A4);
}