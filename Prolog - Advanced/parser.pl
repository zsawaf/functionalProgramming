% For this question, I will be using this modified database. If I call for example verb(put, X), it will shoot back verb(put). 
verb(X, verb(X)):- member(X, [put, pickup, stack, unstack]).
det(X, det(X)):- member(X, [the]).
adj(X, adj(X)):- member(X, [big, small, green, red, yellow, blue]).
noun(X, noun(X)):- member(X, [block, table]).
prep(X, prep(X)):- member(X, [on, from]).

% Return anything but the last element.
% Specifically for this question, clear the noun from the list, so you just have 
% adjective phrases.
removeNoun(L, L1) :-  append(L1, [_], L).

% Given a word list, return true and the parse tree of the list, otherwise, return false. 
parseTree(WordList, sentence(X)):- verb_phrase(WordList, X).
% This is the mother of all rules. verb_phrase glues together noun_phrase and prep_phrase.
verb_phrase([H|T], verb_phrase(X, Y, Z)):- verb(H, X), append(NP, PP, T), noun_phrase(NP, Y), prep_phrase(PP, Z).
% base case for noun phrases.
noun_phrase([H, T], noun_phrase(X, Y)):- det(H, X), noun(T, Y).
% The trick is to get the determiner out first, then realize that the noun is at the end of the list, and then adjective phrases are in between.
noun_phrase([H|T], noun_phrase(Det, AdjP, Noun)):- det(H, Det), last(T, Last), noun(Last, Noun), removeNoun(T, NewT), adj_phrase(NewT, AdjP).
% Base case on adj_phrase with just one adjective.
adj_phrase([H], adj_phrase(X)):- adj(H, X).
% Recursively nest the adjective phrase list. 
adj_phrase([H|T], adj_phrase(X, Y)) :- adj(H, X), adj_phrase(T, Y).
% A prep phrase expects a prep, followed by a noun phrase. 
prep_phrase([H|T], prep_phrase(X, Y)) :- prep(H, X), noun_phrase(T, Y).
