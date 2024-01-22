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


% a) teachers(-T) which returns a list with all the teachers

teachers(T) :-
	findall(Teacher, teaches(_, Teacher), T).

% b) Use setof lol

% c) students_of(+T, -S) which returns a list with all the students of professor T

students_of(T, S) :-
	findall(Student, (teaches(Unit, T), attends(Unit, Student)), S).

% d) teachers_of(+S, -T) which returns a list with all teachers of student S

teachers_of(S, T) :-
	findall(Teacher, (attends(Unit, S), teaches(Unit, Teacher)), T). 

% e) common_courses(+S1, +S2, -C), which returns a list of all courses attended by both student S1 and S2

common_courses(S1, S2, C) :-
	findall(Course, (attends(Course, S1), attends(Course, S2)), C).

% f) more_than_one_course(-L), which returns a list of all students attending more than one course

more_than_one_course(L) :-
	setof(Student, [_Course, Courses, Size]^(attends(_Course, Student), all_courses(Student, Courses), length(Courses, Size), Size > 1), L).

all_courses(S, L) :-
	findall(Course, attends(Course, S), L).


% g) strangers(-L), which returns a list with all pairs of students who don’t know each other, i.e., don’t attend any course in common

strangers(L) :-
	findall(S1-S2, (attends(_, S1), attends(_, S2), S1 @< S2, common_courses(S1, S2, CC), length(CC, 0)), L).

% h) good_groups(-L), which returns a list with all the students who attend more than one course in common

good_groups(L) :-
	findall(S1-S2, (attends(_, S1), attends(_, S2), S1 @< S2, common_courses(S1, S2, CC), length(CC, Size), Size > 1), List),
	sort(List, L).





