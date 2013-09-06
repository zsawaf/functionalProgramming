% takeout(X, List, Res), where X is the member to be taken out of List, and Res is the resulted list. 
takeout(X,[X|R],R).
takeout(X,[F|R],[F|S]) :- takeout(X,R,S).

myreverse([], R, R).
myreverse([H|T], Z, W):- myreverse(T, [H|Z], W).

subset([X|R],S) :- member(X,S), subset(R,S).
subset([],_).

union([], Z, Z).
union([X|Y],Z,[X|W]) :- union(Y,Z,W).

%Exercise 2.7.5 Design and test 'delete(X,L,R)' which is intended to delete all occurrences of X from list L to produce result R. 
del(X, [X|L], L).
del(X, [F|T1], [F|T2]):- del(X, T1, T2).

%Design and test 'prefix(A,B)' which tests to see if A is a list prefix of B, and which can generate prefixes of a given list.
prefix([], _).
prefix([H|T], [H|T1]):- prefix(T, T1).


%Exercise 2.7.8 Design a Prolog predicate 'segment', that tests whether its first list argument is a contiguous segment contained anywhere within the second list argument.
segment(_, []).
segment(S, L):- prefix(S, L).
segment(S, [H|T]):- \+ prefix(S, [H|T]), segment(S, T).

% append list X to Y into Z.
myappend([], Z, Z).
myappend([H|T], Z, [H|T1]):- myappend(T, Z, T1). 


% Find the length of L
mylength([], 0).
mylength([_|T], N):- mylength(T, M), N is M + 1.
