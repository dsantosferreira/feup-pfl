teaches(algorithms, adalberto).
teaches(databases, bernardete).
teaches(compilers, capitolino).
teaches(statistics, diogenes).
teaches(networks, ermelinda).

attends(algorithms, alberto).
attends(algorithms, bruna).
attends(algorithms, cristina).
attends(algorithms, diogo).
attends(algorithms, eduarda).

attends(databases, antonio).
attends(databases, bruno).
attends(databases, cristina).
attends(databases, duarte).
attends(databases, eduardo).

attends(compilers, alberto).
attends(compilers, bernardo).
attends(compilers, clara).
attends(compilers, diana).
attends(compilers, eurico).

attends(statistics, antonio).
attends(statistics, bruna).
attends(statistics, claudio).
attends(statistics, duarte).
attends(statistics, eva).

attends(networks, alvaro).
attends(networks, beatriz).
attends(networks, claudio).
attends(networks, diana).
attends(networks, eduardo).

% 2.a teaches(X, diogenes).
% 2.b teaches(_, felismina). 
% 2.c attends(X, claudio).  
% 2.d attends(_, dalmindo).
% 2.e teaches(_X, bernardete), attends(_X, eduarda).
% 2.f attends(_X, alberto), attends(_X, alvaro).

isStudent(S, P) :- teaches(X, P), attends(X, S). % Is S a student of professor P works for c) ii. and c) iii. if considering isStudent(+P, -S) and isStudent(+S, -P) respectively
bothTeach(P1, P2, S) :- teaches(X, P1), teaches(Y, P2), attends(X, S), attends(Y, S). % Both P1 and P2 teach S
isColleague(X, Y) :- teaches(_, X), teaches(_, Y), X @< Y.
isColleague(X, Y) :- teaches(A, _), attends(A, X), attends(A, Y), X @< Y. % Como eliminar repetidos entre cadeiras diferentes?
attendMoreThanOne(S) :- teaches(X, P1), teaches(Y, P2), X @< Y, attends(X, S), attends(Y, S).