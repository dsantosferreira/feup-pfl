%class(Course, ClassType, DayOfWeek, Time, Duration)
class(pfl, t, '2 Tue', 15, 2).
class(pfl, tp, '2 Tue', 10.5, 2).
class(lbaw, t, '3 Wed', 10.5, 2).
class(lbaw, tp, '3 Wed', 8.5, 2).
class(ipc, t, '4 Thu', 14.5, 1.5).
class(ipc, tp, '4 Thu', 16, 1.5).
class(fsi, t, '1 Mon', 10.5, 2).
class(fsi, tp, '5 Fri', 8.5, 2).
class(rc, t, '5 Fri', 10.5, 2).
class(rc, tp, '1 Mon', 8.5, 2).

% a) same_day(+Course1, +Course2), which succeeds if there are classes of both Course1 and Course2 taking place on the same day

same_day(Course1, Course2) :-
	class(Course1, _, Day, _, _),
	class(Course2, _, Day, _, _).

% b) daily_courses(+Day, -Courses), which receives a day of the week and returns a list with all the courses taking place on that day

daily_courses(Day, Courses) :-
	setof(Course, class(Course, _, Day, _, _), Courses), !.

% c) short_classes(-L), which returns in L a list of all classes with a duration of less than 2 hours (list of terms in the format UC-Day/Time)

short_classes(L) :-
	bagof(Course-Day/Time, (class(Course, _, Day, Time, Duration), Duration < 2), L).


% d) course_classes(+Course, -Classes), which receives a course and returns a list of all the classes from that course (list of terms in the format Day/Time-Type)

course_classes(Course, Classes) :-
	findall(Day/Time-Type, class(Course, Type, Day, Time, _), Classes).

% e) courses(-L), which returns a list of all existing courses. Avoid repeated results.

courses(L) :-
	setof(Course, [_Type, _Day, _Time, _Duration]^class(Course, _Type, _Day, _Time, _Duration), L).







