% a) Invert a list, rev(+List1, ?List2)

% Without tail recursion
/*
rev([], []).
rev([H | T], Rev) :- 
	rev(T, Rev1).
	append(Rev1, [H], Rev).
*/

rev(L, Rev) :- revAux(L, [], Rev).

revAux([], Rev, Rev).
revAux([H | T], Acc, Rev) :-
	revAux(T, [H | Acc], Rev).

invert(L1, L2) :- invert_aux(L1, [], L2).

invert_aux([], L2, L2).
invert_aux([H | T], Acc, L2) :-
	invert_aux(T, [H | Acc], L2).

% b Delete the first element in the list, del_one(+Elem, +List1, ?List2)

del_one(Elem, [Elem | T], T).

del_one(Elem, [H | T], [H | T1]) :-
	del_one(Elem, T, T1).

test_del_one(El, [El | T], T) :- !.
test_del_one(El, [H | T], [H | T1]) :-
	test_del_one(El, T, T1).


% c) del_all(+Elem, +List1, ?List2), deletes all occurences of Elem in List1 resulting in List2

del_all(_, [], []).
del_all(El, [El | T1], T2) :-
	del_all(El, T1, T2).
del_all(El, [H | T1], [H | T2]) :-
	H \= El,
	del_all(El, T1, T2).

test_del_all(_, [], []).
test_del_all(El, [El | T], T1) :-
	test_del_all(El, T, T1).
test_del_all(El, [H | T], [H | T1]) :-
	El \= H,
	test_del_all(El, T, T1).


% d) del_all_list(+ListElems, +List1, ?List2), deletes all occurences of ListElems in List1 resulting in List2

del_all_list([], L, L).
del_all_list([El | T], L1, L2) :-
	del_all(El, L1, L3),
	del_all_list(T, L3, L2).


test_del_all_list([], L1, L1).
test_del_all_list([El | T], L1, L2) :-
	test_del_all(El, L1, L3),
	test_del_all_list(T, L3, L2).

% e) del_dups(+List1, ?List2), deletes repeated values from List1

del_dups([], []).
del_dups([H | T], L2) :-
	del_dups(T, L3),
	checkSeen(H, L3, L2).

checkSeen(El, Seen, [El | Seen]) :-
	\+ member(El, Seen).

checkSeen(El, Seen, Seen) :-
	member(El, Seen).


test_del_dups(L1, L2) :- test_del_dups_aux(L1, [], L2).

test_del_dups_aux([], L2, L2).
test_del_dups_aux([H | T], Seen, T1) :-
	member(H, Seen),
	test_del_dups_aux(T, Seen, T1).
test_del_dups_aux([H | T], Seen, T1) :-
	\+ member(H, Seen),
	test_del_dups_aux(T, [H | Seen], T1).



% f) list_perm(+L1, +L2), true if L2 is a permutation of L1

list_perm([], []).
list_perm(L1, [H | T]) :-
	del_one(H, L1, L2),
	list_perm(L2, T).


test_list_perm(L1, L2) :- length(L1, L), length(L2, L), test_list_perm_aux(L1, L2).

test_list_perm_aux([], []).
test_list_perm_aux([H | T], L2) :-
	test_del_one(H, L2, NewL2),
	test_list_perm_aux(T, NewL2).

% g) replicate(+Amount, +Elem, ?List) which generates a List with Amount repetitions of Elem

replicate(Amount, Elem, List) :- replicateAux(Amount, Elem, [], List).

replicateAux(0, _, List, List) :- !.
replicateAux(Amount, Elem, Acc, List) :-
	Amount > 0,
	Amount1 is Amount - 1,
	replicateAux(Amount1, Elem, [Elem | Acc], List).


test_replicate(0, _, []) :- !.
test_replicate(Amount, Elem, [Elem | T1]) :-
	Amount > 0,
	Amount1 is Amount - 1,
	test_replicate(Amount1, Elem, T1).


% h) intersperse(+Elem, +List1, ?List2)

intersperse(_, [], []).
intersperse(_, [El], [El]) :- !.
intersperse(El, [H | T], [H, El | T2]) :-
	intersperse(El, T, T2).


test_intersperse(_, [], []).
test_intersperse(_, [_H], [_H]) :- !.
test_intersperse(Elem, [H | T], [H, Elem | T1]) :-
	test_intersperse(Elem, T, T1).

% i) insert_elem(+Index, +List1, +Elem, ?List2) which inserts Elem into List1 at position Index, resulting in List2

insert_elem(1, L1, _Elem, [_Elem | L1]).
insert_elem(Index, [H | T], Elem, [H | T1]) :-
	Index > 1,
	Index1 is Index - 1,
	insert_elem(Index1, T, Elem, T1).


test_insert_elem(0, L1, El, [El | L1]) :- !.
test_insert_elem(Index, [H | T], El, [H | T1]) :-
	Index > 0,
	Index1 is Index - 1,
	test_insert_elem(Index1, T, El, T1).

% j) delete_elem(+Index, +List1, ?Elem, ?List1) which removes the element at position Index from List1 (which is unified with Elem), resulting in List2


delete_elem(1, [H | T], H, T).
delete_elem(Index, [H | T], Elem, [H | T1]) :-
	Index > 1,
	Index1 is Index - 1,
	delete_elem(Index1, T, Elem, T1).











