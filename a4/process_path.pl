%% Given an element and a nested list, return true, return true iff X is equal to the first element of the first list in the nested list. 
checkPath(X, [[H|_]|_]):- X==H.


%% Given a path return true if a path is valid or false otherwise. A path is valid iff the last element of a list is the same as the first 
%% element in the proceeding list.
% Base case when inputing an empty list. 
validPath([]).
% Our base case when path has just one element. 
validPath([_]).
% In other cases, we want to check that the last element of the head of the list is equal to the first element of the second list. 
validPath([First | Rest]):-
	last(First, X),
	checkPath(X, Rest), 
	validPath(Rest). 

%% Given L, return all the elements of L into L2 except the last one. 
dropLastElement(L, L1) :-  
 append(L1, [_], L).

%% Given a path, I have two base cases, one is the trivial empty list base case, and the other is 
%% the base case where the reverse is actually checked. In the recursive call, we are finding the 
%% last element in Path, checking if its the reverse of H1, then recursively calling Path1 except
%% for the last element and T1. 
returnPath([], []).
returnPath([A,B,C], [C,B,A]).
returnPath(Path, [H1|T1]):-
	last(Path, Last), returnPath(Last, H1), dropLastElement(Path, RecPath), returnPath(RecPath, T1).

