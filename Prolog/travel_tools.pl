
noHighwaysHelper([], _, 0).
noHighwaysHelper([[_, HW, _]|T], HWList, N):-
	member(HW, HWList), noHighwaysHelper(T, HWList, N).
noHighwaysHelper([[_, HW, _]|T], HWList, N):-
	not(member(HW, HWList)), append([HW], HWList, NewList),
	noHighwaysHelper(T, NewList, N1), N is N1 + 1.

%% Base case, no path implies no highways. 
noHighways([], 0).
noHighways(Path, N):-
	noHighwaysHelper(Path, [], N).



%% Given a city, return the tax at that city. 
getTax(City, Tax):- city(City, Tax, _).

%% Given a city, return the time delay at that city. 
getDelay(City, Delay):- city(City, _, Delay).

%% Given a highway, return the duration of that highway.
getDuration(F, HW, T, Duration):- highway(F, HW, T, _, Duration).

%% Given a highway, return the price of that highway.
getPrice(F, HW, T, Price):- highway(F, HW, T, Price, _).

%% Given a path, get the final destination of that path.
getLast([[_,HW,Last]], HW, Last).
getLast([_|T], X, Y):-
	getLast(T,X, Y).

%% Given a path, and a highway, and a cost, return a new modified cost iff 
%% the highway is different form the path highway.
addCost(Cost, HW, [From, NewHW,To], NewCost):-
	% this means highway didnt change. So cost stays the same.
	HW == NewHW,
	getPrice(From, NewHW, To, Price),
	NewCost is Cost + Price.
	
addCost(Cost, HW, [From, NewHW, To], NewCost):-
	HW \= NewHW,
	getTax(From, Tax),
	getPrice(From, NewHW, To, Price),
	NewCost is Cost + Tax + Price.

%% Given a path and an initial duration, return the modified duration of the 
%% path.
addDuration(Duration, [From, NewHW, To], NewDuration):-
	getDuration(From, NewHW, To, X),
	getDelay(From, Delay),
	NewDuration is Duration + Delay + X.
	

addPart([Cost, Duration, _, Path], Dest, HW, [NewCost, NewDuration, FinalHWs, FPath]):-
	getLast(Path, LastHW, Last),
	append(Path, [[Last, HW, Dest]], FPath),
	% Now we have constructed our full new path.
	% Now lets start adding to the cost. Note that there will only be a change in 
	% cost iff the highway is different than the previous highway. 
	addCost(Cost, LastHW, [Last, HW, Dest], NewCost), 
	addDuration(Duration, [Last, HW, Dest], NewDuration),
	% Now modify the number of Highways.
	noHighways(FPath, FinalHWs).
