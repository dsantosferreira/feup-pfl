:- use_module(library(lists)).

% a) rle(+List1, ?List2), which produces in List2 the run-length encoding of List1 using pairs of values

is_same(X, X).

rle([], []).
rle([H | T], [H-Size | L]) :-
	group(is_same, H, [H | T], Front, Rest),
	length(Front, Size),
	rle(Rest, L).

% un_rle(+List1, ?List2), which decodes List1 into List2

un_rle([], []).
un_rle([Letter-Number | T], Res) :-
	un_rle(T, Res1),
	append_ntimes(Letter, Number, Res2),
	append(Res2, Res1, Res).

append_ntimes(_, 0, []) :- !.
append_ntimes(Letter, N, [Letter | Res]) :-
	N > 0,
	N1 is N - 1,
	append_ntimes(Letter, N1, Res).