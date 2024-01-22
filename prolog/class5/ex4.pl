:- use_module(library(lists)).

% flight(origin, destination, company, code, hour, duration).
flight(porto, lisbon, tap, tp1949, 1615, 60). 
flight(lisbon, madrid, tap, tp1018, 1805, 75). 
flight(lisbon, paris, tap, tp440, 1810, 150). 
flight(lisbon, london, tap, tp1366, 1955, 165). 
flight(london, lisbon, tap, tp1361, 1630, 160). 
flight(porto, madrid, iberia, ib3095, 1640, 80). 
flight(madrid, porto, iberia, ib3094, 1545, 80). 
flight(madrid, lisbon, iberia, ib3106, 1945, 80). 
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145). 
flight(london, madrid, iberia, ib3163, 1030, 140). 
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).

% a) get_all_nodes(-ListOfAirports), which returns a list of all the airports served by the flights in the database, with no duplicates

get_all_nodes(L) :-
	setof(N, source_or_dest(N), L).


source_or_dest(N) :-
	flight(N, _, _, _, _, _).

source_or_dest(N) :-
	flight(_, N, _, _, _, _).

% c) find_flights(+Origin, +Destination, -Flights), which returns in Flights a list with one or more flights (their codes) connecting Origin to Destination. Use depth-first search, avoiding cycles

find_flights(Orig, Dest, Flights) :-
	dfs([Orig], Dest, Flights).

dfs([Dest | _], Dest, []).
dfs([Curr | T], Dest, [Code | T1]) :-
	flight(Curr, Next, _, _, Code, _),
	\+ member(Next, [Curr | T]),
	dfs([Next, Curr | T], Dest, T1).


% a) get_all_nodes(-ListOfAirports), which returns a list of all the airports served by the flights in the database, with no duplicatesge

t_get_all_nodes(L) :-
	findall(Airport, t_source_or_dest(Airport), Tmp),
	sort(Tmp, L).


t_source_or_dest(Airport) :- flight(Airport, _, _, _, _, _).
t_source_or_dest(Airport) :- flight(_, Airport, _, _, _, _).


% b) most_diversified(-Company), which returns the company with the most
% diversified destinations, i.e., largest number of cities it flies from/to (if more than one exist,
% new results should be returned via backtracking)

most_diversified(Company) :-
	get_all_companies(Companies),
	get_result(Companies, [], Results),
	keysort(Results, Tmp), reverse(Tmp, [BestVal-BestC | T]),
	include(same_val(BestVal), [BestVal-BestC | T], Ans),
	maplist(get_company, Ans, RealAns),
	member(Company, RealAns).

same_val(Val, Val-_).
get_company(_-C, C).

get_result([], Results, Results).
get_result([Curr | T], Acc, Results) :-
	findall(Air, t_source_or_dest_c(Curr, Air), Tmp),
	sort(Tmp, Tmp2),
	length(Tmp2, Len),
	get_result(T, [Len-Curr | Acc], Results).

t_source_or_dest_c(C, Airport) :- flight(Airport, _, C, _, _, _).
t_source_or_dest_c(C, Airport) :- flight(_, Airport, C, _, _, _).

get_all_companies(L) :-
	findall(C, flight(_, _, C, _, _, _), Tmp),
	sort(Tmp, L).


% c) find_flights(+Origin, +Destination, -Flights), which returns in Flights a list
% with one or more flights (their codes) connecting Origin to Destination. Use depth-first
% search, avoiding cycles

t_find_flights(Dest, Dest, _).
t_find_flights(Origin, Dest, Flights) :-
	flight(Origin, Next, _, _, Code, _),
	\+ member(Code, Flights),
	find_flights(Next, Dest, [Code | Flights]).

t_find_flights(Orig, Dest, Flights) :- t_find_flights_aux(Orig, Dest, [Orig], [], Flights).

t_find_flights_aux(Dest, Dest, _, Acc, Flights) :- reverse(Acc, Flights).
t_find_flights_aux(Orig, Dest, Visited, Acc, Flights) :-
	flight(Orig, Next, _, _, Code, _),
	\+ member(Next, Visited),
	t_find_flights_aux(Next, Dest, [Next | Visited], [Code | Acc], Flights).

% d) find_flights_bfs(+Origin, +Destination, -Flights), with the same meaning as
% before, but now using breadth-first search


% d) find_flights_bfs(+Origin, +Destination, -Flights), with the same meaning as
% before, but now using breadth-first search

t_find_flights_bfs(Orig, Dest, Flights) :-
	bfs([[Orig]-[]], Dest, Fs),
	reverse(Fs, Flights).

bfs([[Dest | _]-Flights | _], Dest, Flights).
bfs([[Curr | T]-Path | Rest], Dest, Flights) :-
	findall([Next, Curr | T]-[Code | Path],
	(
		flight(Curr, Next, _, _, Code, _),
		\+ member(Next, [Curr | T])
	), NextNodes),
	append(Rest, NextNodes, NewQueue),
	bfs(NewQueue, Dest, Flights).












