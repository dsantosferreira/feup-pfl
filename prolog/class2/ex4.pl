% Exercice 1 - factorial of a number factorial(+N, -F)

/* "Normal" recursion
factorial(0, 1).
factorial(N, F) :- 	N >= 0,
					N1 is N - 1,
					factorial(N1, F1),
					F is F1 * N.
*/

% Tail recursion

factorial(N, F) :- factorial(N, F, 1).
factorial(0, F, F).

factorial(N, F, Acc) :- 
	N >= 0,
	Acc1 is Acc * N,
	N1 is N - 1,
	factorial(N1, F, Acc1).

test_factorial(N, F) :- N > -1, test_factorial_aux(N, 1, F).

test_factorial_aux(0, F, F) :- !.
test_factorial_aux(N, Acc, F) :-
	Acc1 is Acc * N,
	N1 is N - 1,
	test_factorial_aux(N1, Acc1, F).

% Exercice 2 - summation from 1 to N rec_sum(+N, -Sum)

/*
rec_sum(1, 1).
rec_sum(N, Sum) :-
	N > 1,
	N1 is N - 1,
	rec_sum(N1, Sum1),
	Sum is Sum1 + N.
*/

% Tail recursion

rec_sum(N, F) :- rec_sum(N, 1, F).
rec_sum(1, F, F).
rec_sum(N, Acc, F) :-
	N > 1,
	N1 is N - 1,
	Acc1 is Acc + N,
	rec_sum(N1, Acc1, F).

test_rec_sum(N, F) :- N > 0, test_rec_sum_aux(N, 0, F).

test_rec_sum_aux(0, F, F) :- !.
test_rec_sum_aux(N, Acc, F) :-
	Acc1 is Acc + N,
	N1 is N - 1,
	test_rec_sum_aux(N1, Acc1, F).

% Exercice 3 - raise X to the power of Y pow_rec(+X, +Y, -P). Solução mais eficiente seria a cada passo diminuir a variável Y para Y//2 e multiplicar P * P, em vez de P * X.

/*
pow_rec(X, 0, 1).
pow_rec(X, Y, P) :-
	Y > 0,
	Y1 is Y - 1,
	pow_rec(X, Y1, P1),
	P is P1 * X.
*/

% Tail recursion

pow_rec(X, Y, P) :- pow_rec(X, Y, 1, P).
pow_rec(_, 0, P, P).
pow_rec(X, Y, Acc, P) :-
	Y > 0,
	Y1 is Y - 1,
	Acc1 is Acc * X,
	pow_rec(X, Y1, Acc1, P).

test_pow_rec(X, Y, P) :- Y > -1, test_pow_rec_aux(X, Y, 1, P).

test_pow_rec_aux(_, 0, P, P) :- !.
test_pow_rec_aux(X, Y, Acc, P) :-
	Acc1 is Acc * X,
	Y1 is Y - 1,
	test_pow_rec_aux(X, Y1, Acc1, P).

% Exercice 4 - Calculate square of a number without using multiplications square_rec(+N, -S)

/*
square_rec(N, S) :- N1 is abs(N), square_rec(N1, N1, S).

square_rec(_, 0, 0).
square_rec(N, T, S) :-
	T > 0,
	T1 is T - 1,
	square_rec(N, T1, S1),
	S is S1 + N.
*/

% Tail recursion

square_rec(N, S) :- N1 is abs(N), square_rec(N1, N1, 0, S).

square_rec(_, 0, S, S).
square_rec(N, T, Acc, S) :-
	T > 0,
	T1 is T - 1,
	Acc1 is Acc + N,
	square_rec(N, T1, Acc1, S).

test_square_rec(N, S) :- N1 is abs(N), test_square_rec_aux(N1, N1, 0, S).

test_square_rec_aux(_, 0, S, S) :- !.
test_square_rec_aux(N, T, Acc, S) :-
	Acc1 is Acc + N,
	T1 is T - 1,
	test_square_rec_aux(N, T1, Acc1, S).

% Exercice 5 - Determine the Nth number of the fibonacci sequence fibonacci(+N, -F)

/*
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, F) :- 
	N > 1,
	N1 is N - 1,
	N2 is N - 2,
	fibonacci(N1, F1),
	fibonacci(N2, F2),
	F is F1 + F2.
*/

% Another solution with tail recursion

fibonacci(N, F) :- fibonacci(N, 0, 0, 1, F).

fibonacci(N, N, F, _, F).

fibonacci(N, Iter, A, B, F) :-
	Iter < N,
	Tmp is A + B,
	A1 is B,
	B1 is Tmp,
	Iter1 is Iter + 1,
	fibonacci(N, Iter1, A1, B1, F).

test_fibonacci(0, 1).
test_fibonacci(1, 1).
test_fibonacci(N, F) :-
	N > 1,
	N1 is N - 1,
	N2 is N - 2,
	test_fibonacci(N1, F1),
	test_fibonacci(N2, F2),
	F is F1 + F2.

% Exercice 6 - Determine the number of steps to reach 1 following these rules: if N is even, N = N//2 in the next iter, else N = 3 * N + 1 collatz(+N, -S)

collatz(1, 0).
collatz(N, S) :-
	N > 1,
	N mod 2 =:= 0,
	N1 is N//2,
	collatz(N1, S1),
	S is S1 + 1.

collatz(N, S) :-
	N > 1,
	N mod 2 =:= 1,
	N1 is N*3 + 1,
	collatz(N1, S1),
	S is S1 + 1.

% Exercice 7 - Determine if X is prime, is_prime(+X)
is_prime(X) :- is_prime(X, 2).

is_prime(X, X).

is_prime(X, D) :-
	D > 1,
	D < X,
	X mod D =\= 0,
	D1 is D + 1,
	is_prime(X, D1).


/* QUESTÃO QUE JÁ SAIU EM EXAME DIFICIL

most_gates(N, C) :-
	gates(N, C),

	\+ ((
		gates(_, C1),
		C1 > C
	)).

second_most_gates(N, C) :-
	most_gates(_, MAX),
	gates(N, C),
	C < MAX,
	\+ ((
		gates(_, C1),
		C1 < MAX,
		C1 > C
	)).
*/


