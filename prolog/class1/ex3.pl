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

teamWins(T) :- team(X, T), won(X, _).