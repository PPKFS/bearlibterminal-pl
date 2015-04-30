 :- module(bearlibterminal, []).

:- use_foreign_library('lib/blt.so').

color_to_term(Col, Term) :-
	blt_color_to_term(Col, Term).

terminal_open(Result) :-
	blt_open(Result).

terminal_open :-
	blt_open(_).

terminal_close :-
	blt_close.

terminal_set(Config, Result) :-
	blt_set(Config, Result).

terminal_set(Config) :-
	blt_set(Config, _).

terminal_color(color(R, G, B, A)) :-
	blt_color_from_argb(A, R, G, B, Col),
	blt_color(Col).

terminal_color(Col) :-
	Col \= color(_, _, _, _),
	blt_color(Col).

terminal_bkcolor(color(R, G, B, A)) :-
	blt_color_from_argb(A, R, G, B, Col),
	blt_bkcolor(Col).

terminal_bkcolor(Col) :-
	Col \= color(_, _, _, _),
	blt_bkcolor(Col).

terminal_composition(OnOff) :-
	(
		OnOff = on
		;
		OnOff = off
	),
	blt_composition(OnOff).

terminal_layer(Layer) :-
	blt_layer(Layer).

terminal_clear :-
	blt_clear.

terminal_clear_area(X, Y, W, H) :-
	blt_clear_area(X, Y, W, H).

terminal_crop(X, Y, W, H) :-
	blt_crop(X, Y, W, H).

terminal_refresh :-
	blt_refresh.

terminal_put(X, Y, Code) :-
	blt_put(X, Y, Code).

terminal_pick(X, Y, Index, Code) :-
	blt_pick(X, Y, Index, Code).

terminal_pick_color(X, Y, Index, Col) :-
	blt_pick_color(X, Y, Index, Int),
	color_to_term(Int, Col).

terminal_pick_bkcolor(X, Y, Col) :-
	blt_pick_bkcolor(X, Y, Int),
	color_to_term(Int, Col).

terminal_put_ext(X, Y, DX, DY, Code, TL, BL, TR, BR) :-
	blt_put_ext(X, Y, DX, DY, Code, TL, BL, TR, BR).

terminal_put_ext(X,Y, DX, DY, Code) :-
	blt_put_ext(X, Y, DX, DY, Code).

terminal_print(X, Y, Str, Size) :-
	blt_print(X, Y, Str, Size).

terminal_measure(Str, Size) :-
	blt_measure(Str, Size).

terminal_state(Slot, State) :-
	blt_state(Slot, State).

terminal_check(Slot, State) :-
	blt_check(Slot, State).

terminal_has_input :-
	blt_has_input(1).

terminal_read(Event) :-
	blt_read(Event).

terminal_peek(Event) :-
	blt_peek(Event).

terminal_read_str(X, Y, Buffer, Max, Size) :-
	blt_read_str(X, Y, Buffer, Max, Size).

terminal_delay(Delay) :-
	blt_delay(Delay).

color_from_name(Name, Col) :-
	blt_color_from_name(Name, Col2),
	blt_color_to_term(Col2, Col).

color_from_argb(A, R, G, B, Col) :-
	blt_color_from_argb(A, R, G, B, Col).

go :-
	blt_open(_),
	blt_composition(on),
	blt_refresh.