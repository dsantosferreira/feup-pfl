% a) list_append(?L1, ?L2, ?L3) where L3 is the concatenation of lists L1 and L2

list_append(L1, L2, L3) :-
	append(L1, L2, L3).

% b) list_member(?Elem, ?List), which verifies if Elem is a member of List, using solely the append predicate exactly once

list_member(Elem, List) :-
	append(_, [Elem | _], List).

% c) list_last(+List, ?Last), which unifies Last with the last element of List, using solely the append predicate exactly once

list_last(List, Last) :-
	append(_, [Last], List).

% d) list_nth(?N, ?List, ?Elem), which unifies Elem with the Nth element of List, using only the append and length predicates

list_nth(N, List, Elem) :-
	append(L1, [Elem | _], List),
	length(L1, N).

% e) list_append(+ListOfLists, ?List), which appends a list of lists
list_append([], []).
list_append([H | T], L) :-
	list_append(T, L1),
	append(H, L1, L).

% f) list_del(+List, +Elem, ?Res), which eliminates an occurrence of Elem from List, unifying the result with Res, using only the append predicate twice
list_del(List, Elem, Rest) :-
	append(L1, [Elem | L2], List),
	append(L1, L2, Rest).

% g) list_before(?First, ?Second, ?List), which succeeds if the first two arguments are members of List, and First occurs before Second, using only the append predicate twice
list_before(First, Second, List) :-
	append(_, [First | L1], List),
	append(_, [Second | _], L1).

% h) list_replace_one(+X, +Y, +List1, ?List2), which replaces one occurrence of X in List1 by Y, resulting in List2, using only the append predicate twice
list_replace_one(X, Y, L1, L2) :-
	append(Left, [X | Right], L1),
	append(Left, [Y | Right], L2).

% i) list_repeated(+X, +List), which succeeds if X occurs repeatedly (at least twice) in List, using only the append predicate twice
list_repeated(X, List) :-
	append(_, [X | L1], List),
	append(_, [X | _], L1).

% j) list_slice(+List1, +Index, +Size, ?List2), which extracts a slide of size Size from List1 starting at index Index, resulting in List2, using only the append and length predicates
list_slice(L1, Index, Size, L2) :-
	append(Left, Right, L1),
	Index1 is Index - 1,
	length(Left, Index1),
	append(L2, _, Right),
	length(L2, Size).

% k) list_shift_rotate(+List1, +N, ?List2), which rotates List1 by N elements to the left, resulting in List2, using only the append and lenght predicates
list_shift_rotate(L1, N, L2) :-
	append(Left, Right, L1),
	length(Left, N),
	append(Right, Left, L2).
















t_list_append([], L2, L2).
t_list_append([H | T], L2, [H | T1]) :-
	t_list_append(T, L2, T1).


t_list_member(Elem, List) :-
	append(_, [Elem | _], List).


t_list_last(List, Last) :-
	append(_, [Last], List).


t_list_nth(N, L, El) :-
	ground(N),
	append(L1, [El | _], L),
	length(L1, N), !.

t_list_nth(N, L, El) :-
	append(L1, [El | _], L),
	length(L1, N).


t_list_append([], []).
t_list_append([H | T], T2) :-
	t_list_append(T, T1),
	append(H, T1, T2).


t_list_del(L, El, Res) :-
	append(L1, [El | L2], L),
	append(L1, L2, Res).

t_list_before(F, S, L) :-
	append(_, [F | Rest], L),
	append(_, [S | _], Rest).

t_replace_one(X, Y, L1, L2) :-
	append(L, [X | R], L1),
	append(L, [Y | R], L2).

t_list_repeated(X, L) :-
	append(_, [X | Rest], L),
	append(_, [X | _], Rest).































