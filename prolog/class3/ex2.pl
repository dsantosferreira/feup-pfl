% a) list_size(+List, ?Size), determines the size of List

% Recursion
list_size([], 0).
list_size([_ | T], Size) :-
	list_size(T, Size1),
	Size is Size1 + 1.

% Tail recursion

list_size2(L, S) :- list_sizeAux(L, 0, S).

list_sizeAux([], S, S).
list_sizeAux([_ | T], Acc, S) :-
	Acc1 is Acc + 1,
	list_sizeAux(T, Acc1, S).

test_list_size(L, S) :- test_list_size_aux(L, 0, S).

test_list_size_aux([], S, S).
test_list_size_aux([H | T], Acc, S) :-
	Acc1 is Acc + 1,
	test_list_size_aux(T, Acc1, S).

% b) list_sum(+List, ?Sum), determines the sum of the elements in the List

list_sum(L, S) :- list_sumAux(L, 0, S).

list_sumAux([], S, S).
list_sumAux([H | T], Acc, S) :-
	Acc1 is Acc + H,
	list_sumAux(T, Acc1, S).

test_list_sum(L, S) :- test_list_sum_aux(L, 0, S).

test_list_sum_aux([], S, S).
test_list_sum_aux([H | T], Acc, S) :-
	Acc1 is Acc + H,
	test_list_size_aux(T, Acc1, S).

% c) list_prod(+List, ?Prod), determines the product of all numbers in the List

list_prod(L, P) :- list_prodAux(L, 1, P).

list_prodAux([], P, P).
list_prodAux([H | T], Acc, P) :-
	Acc1 is Acc * H,
	list_prodAux(T, Acc1, P).

test_list_prod(L, Prod) :- test_list_prod_aux(L, 1, Prod).

test_list_prod_aux([], Prod, Prod).
test_list_prod_aux([H | T], Acc, Prod) :-
	Acc1 is Acc * H,
	test_list_prod_aux(T, Acc1, Prod).

% d) inner_product(+List1, +List2, ?Result), determines the inner product of two vectors

inner_product(L1, L2, R) :- inner_productAux(L1, L2, 0, R).

inner_productAux([], [], R, R).
inner_productAux([H1 | T1], [H2 | T2], Acc, R) :-
	Acc1 is Acc + H1 * H2,
	inner_productAux(T1, T2, Acc1, R).

test_inner_product(L1, L2, S) :- length(L1, L), length(L2, L), test_inner_product_aux(L1, L2, 0, S).

test_inner_product_aux([], [], S, S).
test_inner_product_aux([H1 | T1], [H2 | T2], Acc, S) :-
	Acc1 is Acc + H1 * H2,
	test_inner_product_aux(T1, T2, Acc1, S).


% e) count(+Elem, +List, ?N), counts the number of times that Elem occurs in the List

count(El, L, N) :- countAux(El, L, 0, N).

countAux(_, [], N, N).
countAux(El, [El | T], Acc, N) :-
	Acc1 is Acc + 1,
	countAux(El, T, Acc1, N).
countAux(El, [H | T], Acc, N) :-
	El \= H,
	countAux(El, T, Acc, N).

test_count(El, L, N) :- test_count_aux(El, L, 0, N).

test_count_aux(_, [], N, N).
test_count_aux(El, [El | T], Acc, N) :-
	Acc1 is Acc + 1,
	test_count_aux(El, T, Acc1, N).
test_count_aux(El, [H | T], Acc, N) :-
	H \= El,
	test_count_aux(El, T, Acc, N).

