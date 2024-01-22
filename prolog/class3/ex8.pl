:- use_module(library(lists)).

pascal(N, Lines) :- N > 0, pascal_aux(N, 1, [1], [[1]], Lines).

pascal_aux(N, N, _, Acc, Lines) :- reverse(Acc, Lines).
pascal_aux(Lim, N, Curr, Acc, Lines) :-
	N < Lim,

	get_next_line(Curr, [], NewCurr),

	N1 is N + 1,
	pascal_aux(Lim, N1, NewCurr, [NewCurr | Acc], Lines).


get_next_line([_], Acc, [1 | NewCurr]) :- reverse([1 | Acc], NewCurr).
get_next_line([H1, H2 | T], Acc, NewCurr) :-
	NewEl is H1 + H2,
	get_next_line([H2 | T], [NewEl | Acc], NewCurr).