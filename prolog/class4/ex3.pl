immature(X):- adult(X), !, fail.
immature(_X).
adult(X):- person(X), !, age(X, N), N >=18.
adult(X):- turtle(X), !, age(X, N), N >=50.
adult(X):- spider(X), !, age(X, N), N>=1.
adult(X):- bat(X), !, age(X, N), N >=5.

% The cut on the 'immature' predicate is red since erasing it from the code makes the predicate return different solutions
% (the second rule will always be called and give the value true)
% The rest of the cuts are green, since being a person, a turtle, a spider or a bat are mutually exclusive. Only
% one of the rules will run, regardless of having the cuts or not