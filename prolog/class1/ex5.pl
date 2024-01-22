job(technician, eleuterio).
job(technician, juvenaldo).
job(analyst, leonilde).
job(analyst, marciliano).
job(engineer, osvaldo).
job(engineer, porfirio).
job(engineer, reginaldo).
job(supervisor, sisnando). 
job(chief_supervisor, gertrudes). 
job(secretary, felismina).
job(director, asdrubal). 
supervised_by(technician, engineer).
supervised_by(engineer, supervisor). 
supervised_by(analyst, supervisor). 
supervised_by(supervisor, chief_supervisor). 
supervised_by(chief_supervisor, director). 
supervised_by(secretary, director).

% a) i. o sisnando supervisiona qualquer analista
% a) ii. Qual trabalho supervisiona os que supervisionam os técnicos
% a) iii. trabalhadores e respetivos trabalhos que são supervisionados por supervisers
% a) iv. Todas as pessoas que são diretamente supervisionadas pelo asdrubal

% b) i. yes
% b) ii. supervisor
% b) iii. J = analyst, P = leonilde
% b) iv. P = gertrudes

% c) i.

direct_supervisor(X, Y) :-
	job(_JX, X), 
	job(_JY, Y),
	supervised_by(_JY, _JX).

% c) ii.

same_supervised(X, Y) :-
	job(_JX, X),
	job(_JY, Y),
	supervised_by(_JX, _JZ),
	supervised_by(_JY, _JZ).

% c) iii.

supervise_more_than_one(X) :-
	job(JX, X),
	supervised_by(JY, JX),
	supervised_by(JZ, JX),
	JY \= JZ, !.

% c) iv.
is_supervisor_of(X, Y) :-
	job(JY, Y),
	job(JX, X),
	supervised_by(JY, _JZ),
	supervised_by(_JZ, JX).