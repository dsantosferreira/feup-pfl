% a) is_ordered(+List), which succeeds if List is a proper list of integers, in increasing order

is_ordered([]).
is_ordered([_ | []]).
is_ordered([H1, H2 | T]) :-
	H1 =< H2,
	is_ordered([H2 | T]).

% b) insert_ordered(+Value, +List1, ?List2), which inserts Value into List1 (assumed to be ordered), maintaining the ordering of the elements, resulting in List2

insert_ordered(Value, [], [Value]).
insert_ordered(Value, [H | T], [Value, H | T]) :- Value < H, !.
insert_ordered(Value, [H | T], [H | Rest]) :-
	Value >= H,
	insert_ordered(Value, T, Rest).

% c) insert_sort(+List, ?OrderedList), which orders List, resulting in OrderedList

insert_sort(L, Ol) :- insert_sort_aux(L, [], Ol).

insert_sort_aux([], Ol, Ol).
insert_sort_aux(L, Acc, Ol) :-
	extract_max(L, Max, Rest),
	!,
	get_next_acc(Acc, Max, NewAcc),
	insert_sort_aux(Rest, NewAcc, Ol).

get_next_acc(Acc, Max, Acc) :-
	member(Max, Acc).

get_next_acc(Acc, Max, [Max | Acc]) :-
	\+ member(Max, Acc).

extract_max([H | T], Max, Rest) :-
	get_max([H | T], H, Max),
	delete_max([H | T], Max, Rest).

get_max([], Max, Max).

get_max([H | T], Curr, Max) :-
	Curr > H,
	get_max(T, Curr, Max).

get_max([H | T], Curr, Max) :-
	Curr =< H,
	get_max(T, H, Max).

delete_max([Max | T], Max, T).
delete_max([H | T], Max, [H | Res]) :-
	delete_max(T, Max, Res).