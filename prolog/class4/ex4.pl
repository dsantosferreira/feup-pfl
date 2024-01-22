% max(+A, +B, +C, ?Max), which determines the maximum value between three numbers

max(A, B, C, A) :-
	A >= B,
	A >= C, !.

max(A, B, C, B) :-
	B >= C, 
	B >= A, !.

max(A, B, C, C) :-
	C >= A,
	C >= B.