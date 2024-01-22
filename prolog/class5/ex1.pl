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
male(mitchell).
% ...

female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
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

% a) children(+Person, -Children), which returns in the second argument a list with the children of Person

test(L) :- bagof(Child, parent(Parent, Child), Children).

children(Person, Children) :-
	findall(Child, parent(Person, Child), Children).

% b) children_of(+ListOfPeople, -ListOfPairs), which returns in the second argument a list with pairs in the format P-C, where P is an element of ListOfPeople and C is a list containing their children

children_of(ListOfPeople, ListOfPairs) :-
	findall(P-C, ( member(P, ListOfPeople), children(P, C) ), ListOfPairs).

% c) family(-F), which returns a list with all the people in the family

family(F) :-
	findall(F, female(F), Female),
	findall(M, male(M), Male),
	append(Female, Male, F).

% d) couple(?C), which unifies C with a couple of people (in the format X-Y) who have at least one child in common

couple(P1-P2) :-
	parent(P1, _C),
	parent(P2, _C),
	P1 \= P2.

% e) couples(-List), which returns a list of all couples with children, avoiding duplicate results

couples(L) :-
	setof(C, couple(C), L).

% f) spouse_children(+Person, -SC), which returns in SC a pair Spouse/Children with a spouse of Person, and the children they have together

spouse_children(Person, S/C) :-
	couple(Person-S),
	children(Person, C).

% g) immediate_family(+Person, -PC), which returns in PC a pair A-B, where A is a list with the parents of Person and B is a list with the spouses and respective children

immediate_family(Person, P-C) :-
	findall(Parent, parent(Parent, Person), P),
	setof(SC, spouse_children(Person, SC), C).

% h) parents_of_two(-Parents), which returns in Parents the list of people who have at least two children

parents_of_two(Parents) :-
	setof(P, [Test, C, N]^(parent(P, Test), children(P, C), length(C, N), N > 1), Parents).
