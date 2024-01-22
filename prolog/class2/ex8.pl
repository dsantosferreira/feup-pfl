pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(maclean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

team(lamb, breitling).
team(besenyei, redbull).
team(chambliss, redbull).
team(maclean, mediterranean).
team(mangold, cobra).
team(jones, matador).
team(bonhomme, matador).

drives(lamb, mx2).
drives(besenyei, edge540).
drives(chambliss, edge540).
drives(maclean, edge540).
drives(mangold, edge540).
drives(jones, edge540).
drives(bonhomme, edge540).

circuit(instanbul).
circuit(budapest).
circuit(porto).

won(jones, porto).
won(mangold, budapest).
won(mangold, instanbul).

hasGates(instanbul, 9).
hasGates(budapest, 6).
hasGates(porto, 5).

% a) most_gates(?X) unifies X with the circuit that has the highest number of gates

most_gates(X) :-
	hasGates(X, G),

	\+ (
		hasGates(_, G1),
		G1 > G
	).

test_most_gates(X) :-
	hasGates(X, G),

	\+ (
		hasGates(_, G1),
		G1 > G
	).

% b) least_gates(?X) unifies X with the circuit that has the least gates

least_gates(X) :-
	hasGates(X, G),
	\+ (
		hasGates(_, G1),
		G1 < G
	).

test_least_gates(X) :-
	hasGates(X, G),

	\+ (
		hasGates(_, G1),
		G1 < G
	).

% c) gate_diff(?X) unifies X with the difference of the number of gates

gate_diff(X) :-
	most_gates(M),
	least_gates(L),
	hasGates(M, G1),
	hasGates(L, G2),
	X is G1 - G2.
	
second_most_gates(X) :-
	test_most_gates(MX),
	hasGates(X, G),
	MX \= X,

	\+ (
		hasGates(TX, G1),
		TX \= MX,
		G1 > G
	).






