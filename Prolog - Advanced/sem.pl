% isA(X,TYPE) -- entity X is of type TYPE (arm, table, or block)
isA(a1,arm).
isA(t1,table).
isA(b1,block).
isA(b2,block).
isA(b3,block).
isA(b4,block).
isA(b5,block).
isA(b6,block).
isA(b7,block).
isA(b8,block).
% color(B,COLOR) -- color of block B is COLOR (red, yellow, green, or blue)
color(b1,red).
color(b2,yellow).
color(b3,green).
color(b4,blue).
color(b5,red).
color(b6,yellow).
color(b7,green).
color(b8,blue).
% size(B,SIZE) -- size of block B is SIZE (small or big)
size(b1,small).
size(b2,small).
size(b3,small).
size(b4,small).
size(b5,big).
size(b6,big).
size(b7,big).
size(b8,big).

% Helper function that keeps track of actions.
isAction(X):- member(X, [pickup, putdown, stack, unstack]).


% This might be a bad implementation, but it's the only implementation I could think of. 
% first case is when we only have the object after the determiner.
refersTo([Det, Object], X):- det(Det), isA(X, Object).
% second case is when we get a size after the determiner, and the object after. 
refersTo([Det, Size, Object], X):- det(Det), size(X, Size), isA(X, Object).
% third case is when we get a size after the determiner, followed by color followed by object.
refersTo([Det, Size, Color, Object], X):- det(Det), size(X, Size), color(X, Color), isA(X, Object).
% last case when we get color after determiner followed by size then object.
refersTo([Det, Color, Size, Object], X):- det(Det) ,color(X, Color), size(X, Size), isA(X, Object).


%Find the prep index of a given list. 
prepIndex([H|_], 0):- prep(H).
prepIndex([H|T], N):- \+prep(H), prepIndex(T, I), N is I + 1.

% A is the list before the prep, B is the list after and including the prep.
% C is the given list, and L is the index of the prep.
prepSplit(A,B,C,L):- length(A, L), append(A, B, C).

% first makes sure it's grammaticaly correct. 
% second find the index of the prep word.
% next we need to split the list into two and call part a on them both.
means([[Action|T]], [Action, Object1, Object2]):- isGrammatical([Action|T]), prepIndex(T, N), prepSplit(A, [_|BT], T, N),
	refersTo(A, Object1), refersTo(BT, Object2).













