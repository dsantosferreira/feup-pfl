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

% X is an ancestor of Y, ancestor(?X, ?Y)

ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

% descendant_of(?X, ?Y), X is an descendant of Y

descendant_of(X, Y) :- parent(Y, X).
descendant_of(X, Y) :- parent(Z, X), descendant_of(Z, Y).



