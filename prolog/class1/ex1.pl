/*
PFL - Sheet TP7 - Beginning of exercise 1
By: Gonçalo Leão
*/

%%% a
male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(joe).
male(manny).
male(cameron).
male(bo).
male(dylan).
male(alex).
male(luke).
male(rexford).
male(calhoun).
male(george).
% ...

female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(mitchell).
female(pameron).
female(haley).
female(lily).
female(poppy).
% ...


parent(grace,phil).
parent(frank,phil).

parent(dede,claire).
parent(jay,claire).
parent(dede,mitchell).
parent(jay,mitchell).

parent(jay,joe).
parent(gloria,joe).

parent(gloria,manny).
parent(javier,manny).

parent(barb,cameron).
parent(merle,cameron).
parent(barb,pameron).
parent(merle,pameron).

parent(phil,haley).
parent(claire,haley).
parent(phil,alex).
parent(claire,alex).
parent(phil,luke).
parent(claire,luke).

parent(mitchell,lily).
parent(cameron,lily).
parent(mitchell,rexford).
parent(cameron,rexford).

parent(pameron,calhoun).
parent(bo,calhoun).

parent(dylan,george).
parent(haley,george).
parent(dylan,poppy).
parent(haley,poppy).

married(jay, gloria, 2008).
married(jay, dede, 1968).

father(X, Y) :- male(X), parent(X, Y).
mother(X, Y) :- female(X), parent(X, Y).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandmother(X, Y) :- female(X), grandparent(X, Y).
siblings(X, Y) :- parent(P, X), parent(P, Y), parent(Z, X), parent(Z, Y), Z @< P, X \= Y.
halfsiblings(X, Y) :- parent(A, X), parent(A, Y), parent(B, X), parent(C, Y), B \= A, C \= A, B \= C.
cousins(X, Y) :- parent(_P1, X), parent(_P2, Y), parent(_GP1, _P1), parent(_GP2, _P1), parent(_GP1, _P2), parent(_GP2, _P2), _GP1 @< _GP2, \+parent(_P2, X), \+parent(_P1, Y), X @< Y.

arecurrentlymarried(S1, S2, Y) :- married(S1, S2, X), X =< Y, \+divorced(S1, S2, _). 
arecurrentlymarried(S1, S2, Y) :- married(S1, S2, X), X =< Y, divorced(S1, S2, Z), Z >= X.