% Define all the lexicals.
verb(X):- member(X, [put, pickup, stack, unstack]).
det(X):- member(X, [the]).
adj(X):- member(X, [big, small, green, red, yellow, blue]).
noun(X):- member(X, [block, table]).
prep(X):- member(X, [on, from]).

% Return true iff the sequence of words in L forms a true sentence that
% can be recognized by BlocksGrammar. 

isGrammatical(WordList):- verb_phrase(WordList).
% a verb phrase consists of a Verb, a Noun Phrase, and a Prep Phrase.
% Note that each sentence has to start with a verb. 
% I was having a hard time describing the tail, so I looked online for documentation
% about context free grammars, and it said that one way I could describe this is by
% using the following append trick.
verb_phrase([H|T]):- verb(H), append(NP, PP, T), noun_phrase(NP), prep_phrase(PP).
% A noun phrase can be two things, it can either start with a determiner then a noun
% or it can start with a determiner, followed by an adjective phrase then a noun. 
% first case:
noun_phrase([Det, Noun]):- det(Det), noun(Noun).
% second case has a few subcases. 
noun_phrase([H|T]):- det(H), isNounPhrase(T).
% This handles the case of multiple adjectives, we'll have to call the check again to check
% if there are more adjectives.
isNounPhrase([H|T]):- adj(H), isNounPhrase(T).
% base case when we're only left with an adjective and a noun.
isNounPhrase([H, T]):- adj(H), noun(T).
% base case for adjective phrases where there's only one adjective.
adj_phrase([H]) :- adj(H).
% we could have many adjectives, this handles that case.
adj_phrase([H|T]) :- adj(H), adj_phrase(T).
% handles the prep phase case. Where's it's a prep word followed by a noun phrase.
prep_phrase([H|T]) :- prep(H), noun_phrase(T).



