:- use_module(library(lists)).
:- use_module(library(between)).

% a) print_n(+N, +S) which prints symbol S to the terminal N times

print_n(N, S) :-
	between(1, N, _),
	write(S),
	fail.

print_n(_, _).

% b) print_text(+Text, +Symbol, +Padding) which prints the text received in the first argument 
%(using double quotes) with the padding received in the third argument
%(number of spaces before and after the text), and surrounded by Symbol.

print_text(Text, Symbol, Padding) :-
	write(Symbol),
	print_n(Padding, ' '),
	print_string(Text),
	print_n(Padding, ' '),
	write(Symbol).

print_string([]).
print_string([H | T]) :-
	put_code(H),
	print_string(T).


% c) print_banner(+Text, +Symbol, +Padding) which prints the text received in the first argument (using double quotes) using the format of the example below

print_banner(Text, Symbol, Padding) :-
	length(Text, L),
	Len is Padding * 2 + 2 + L,
	Len2 is Len - 2,
	print_n(Len, Symbol), nl,
	write(Symbol), print_n(Len2, ' '), write(Symbol), nl,
	print_text(Text, Symbol, Padding), nl,
	write(Symbol), print_n(Len2, ' '), write(Symbol), nl,
	print_n(Len, Symbol), nl.

