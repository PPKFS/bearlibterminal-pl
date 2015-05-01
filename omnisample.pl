:- module(main, [go/0]).

:- use_module(bearlibterminal).

testBasicOutput :-
	terminal_set("window.title='Omni: Basic Output'"),
	terminal_clear,
	terminal_color(color(255, 255, 255, 255)),
	terminal_print(2, 1, "[color=orange]1.[/color] Wide color range: ", Size),
	forall((string_codes("antidisestablishmentarianism.", Codes), length(Codes, Len), Len2 is Len-1, between(0, Len2, Index)), 
		(nth0(Index, Codes, I), Factor is Index/Len, 
		Red is floor((1-Factor)/255), Green is floor(Factor*255), 
		terminal_color(color(Red, Green, 0, 255)),
		X is 2+Index+Size,
		terminal_put(X, 1, I))),
	terminal_color(color(255, 255, 255, 255)),
	terminal_print(2, 3, "[color=orange]2.[/color] Backgrounds: [color=black][bkcolor=gray] grey [/bkcolor] [bkcolor=red] red "),
	terminal_print(2, 5, "[color=orange]3.[/color] Unicode support: Кириллица Ελληνικά α=β²±2°"),
	terminal_print(2, 7, 
		"[color=orange]4.[/color] Tile composition: a + [color=red]/[/color] = a[+][color=red]/[/color], a vs. a[+][color=red]¨[/color]"),
	terminal_print(2, 9, "[color=orange]5.[/color] Box drawing symbols:"),
	terminal_print(5, 11, "   ┌────────┐  \n   │!......s└─┐\n┌──┘........s.│\n│............>│\n│...........┌─┘\n│<.@..┌─────┘  \n└─────┘        \n"),
	terminal_refresh,
	repeat,
	terminal_read(Key),
	(Key = 0x29 ; Key = 0xE0).

testNotImplemented :-
	terminal_set("window.title='Omni: Sorry"),
	terminal_clear,
	terminal_color(color(255, 255, 255, 255)),
	terminal_print(2, 1, "[color=orange]Not implemented. Should work though! [/color]", Size),
	terminal_refresh,
	repeat,
	terminal_read(Key),
	(Key = 0x29 ; Key = 0xE0).

testTilesets :-
	terminal_set("window.title='Omni: tilesets'"),
	terminal_composition(on),
	terminal_set("U+E100: Media/Runic.png, size=8x16"),
	terminal_set("U+E200: Media/Tiles.png, size=32x32, align=top-left"),
	terminal_set("U+E300: Media/fontawesome-webfont.ttf, size=24x24, bbox=3x2, codepage=Media/fontawesome-codepage.txt"),
	terminal_set("U+E400: Media/Zodiac-S.ttf, size=24x24, bbox=3x2, codepage=437"),
	terminal_clear,
	terminal_color("white"),
	terminal_print(2, 1, "[color=orange]1.[/color] Of course, there is default font tileset."),
	terminal_print(2, 3, "[color=orange]2.[/color] You can load some arbitrary tiles and use them as glyphs:"),
	terminal_print(5, 4,
"Fire rune ([color=red][U+E102][/color]), Water rune ([color=lighter blue][U+E103][/color]), Earth rune ([color=darker green][U+E104][/color])"),
	terminal_print(2, 6, "[color=orange]3.[/color] Tiles are not required to be of the same size as font symbols:"),
	terminal_put(5, 7, 0xE207),
	terminal_put(10, 7, 0xE208),
	terminal_put(15, 7, 0xE209),
	terminal_print(2, 10, "[color=orange]4.[/color] Like font characters, tiles may be freely colored and combined:"),
	terminal_put(5, 11, 0xE208),
	terminal_color("lighter orange"),
	terminal_put(10, 11, 0xE208),
	terminal_color("orange"),
	terminal_put(15, 11, 0xE208),
	terminal_color("dark orange"),
	terminal_put(20, 11, 0xE208),
	terminal_color("white"),
	terminal_refresh,
	repeat,
	terminal_read(Key),
	(Key = 0x29 ; Key = 0xE0),
	terminal_set("U+E100: none; U+E200: none; U+E300: none; U+E400: none"),
	terminal_composition(off).

print_entry(Text, Index) :-
	(Index < 9, Num is 49+Index ; Num is 88 + Index),
	I2 is Index+1,
	format(string(Str), "[color=orange]~c.[/color] [color=gray]~s", [Num, Text]),
	terminal_print(2, I2, Str).

reset :-
	terminal_set("window: size=80x25, cellsize=auto, title='Omni: Menu'; font=default"),
	terminal_color(color(255, 255, 255, 255)).

end :-
	terminal_close.

run(Entries) :-
	terminal_clear,
	forall((member(entry(Text, Pred), Entries), nth0(I, Entries, entry(Text, Pred))), print_entry(Text, I)),
	terminal_print(2, 23, "[color=orange]ESC.[/color] Exit"),
	terminal_refresh,
	terminal_read(Key),
	(
		between(0x04, 0x26, Key),
		(Key >= 0x1E, Index is Key - 0x1E ; Index is 9 + (Key - 0x04)),
		Index >= 0,
		length(Entries, Len),
		Index < Len,
		nth0(Index, Entries, entry(Text, Pred)),
		call(Pred),
		reset,
		run(Entries)
		;
		(Key = 0x29 ; Key = 0xE0), ! %%quit
		;
		run(Entries)
	).

go :-
	terminal_open,
	reset,
	run([
		entry("Basic output", testBasicOutput),
		entry("Default font", testNotImplemented),
		entry("Tilesets", testTilesets),
		entry("Sprites", testSprites),
		entry("Manual cellsize", testManualCellsize),
		entry("Auto-generated tileset", testAutoGenerated),
		entry("Multiple fonts", testMultipleFonts),
		entry("Text alignment", testTextAlignment),
		entry("Formatted log", testFormattedLog),
		entry("Layers", testLayers),
		entry("Extended 1: basics", testExtendedBasics),
		entry("Extended 2: smooth scroll", testExtendedSmoothScroll),
		entry("Dynamic sprites", testDynamicSprites),
		entry("Speed", testSpeed),
		entry("Input 1: keyboard", testKeyboard),
		entry("Input 2: mouse", testMouse),
		entry("Input 3: text input", testTextInput),
		entry("Input 4: filtering", testInputFiltering),
		entry("Window resizing", testWindowResize),
		entry("Examining cell contents", testPick)]),
	end, !.