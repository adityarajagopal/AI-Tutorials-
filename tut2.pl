%
%Question1
/**
The following section of code defines the 6 different
actions that the AI can do
*/
/*
statechange(fill_7, (_,A), (7,A)).
statechange(fill_5, (A,_), (A,5)).
statechange(empty_7, (_,A), (0,A)).
statechange(empty_5, (A,_), (A,0)). 

statechange(pour_7, (A,B), (0,All)):-
	All is A+B,
	A=<5-B. 
statechange(pour_7, (A,B), (All,5)):-
	All is A+B-5,
	A>5-B.

statechange(pour_5, (A,B), (All,0)):-
	All is A+B, 
	All=<7. 
statechange(pour_5, (A,B), (7,All)):-
	All is A+B-7, 
	All > 0.
goal_state((4,0)).
*/

%Question2
/*
statechange(rule_1,State1,State2):-
	append(List,['S'],State1),
	append(State1,['N'],State2).
statechange(rule_2,State1,State2):-
	append(['I'],List,State1),
	append(State1,List,State2).
statechange(rule_3,State1,State2):-
	append(List,['S','S','S'|List1],State1),
	append(List,['N'|List1],State2).
statechange(rule_4,State1,State2):-
	append(List,['N','N'|List1],State1),
	append(List,List1,State2).
goal_state((['I','N'])).
*/
%Question3
/*
split(List,A,B,C):- 
	append(Temp,C,List),
	append(A,B,Temp),
	length(A,N),
	length(B,N),
	length(C,N1),
	N\=0.

sum([],0).
sum([a|List],Weight):-
	sum(List,Weight1),
	Weight is Weight1+1.
sum([b|List],Weight):-
	sum(List,Weight1),	
	Weight is Weight1+1.1.

statechange(split_l,(Left,_,_,l,N),(Left1,Right1,Out1,u,N)):-
	split(Left,Left1,Right1,Out1).
statechange(split_r,(_,Right,_,r,N),(Left1,Right1,Out1,u,N)):-
	split(Right,Left1,Right1,Out1).
statechange(split_o,(_,_,Out,o,N),(Left1,Right1,Out1,u,N)):-
	split(Out,Left1,Right1,Out1).
statechange(select_left,(Left,Right,_,u,N),(Left,Right,Out,l,N1)):-
	N<3,
	sum(Left,WL),
	sum(Right,WR),
	WL>WR,
	N1 is N+1.
statechange(select_right,(Left,Right,_,u,N),(Left,Right,Out,r,N1)):-
	N<3,
	sum(Left,WL),
	sum(Right,WR),
	WL<WR,
	N1 is N+1.
statechange(select_out,(Left,Right,Out,u,N),(Left,Right,Out,o,N1)):-
	N<3,
	sum(Left,WL),
	sum(Right,WR),
	WL=WR,
	N1 is N+1.

goal_state(([b],_,_,l,_)).
goal_state((_,[b],_,r,_)).
goal_state((_,_,[b],o,_)).
*/

%Question4
member([M|_],M):-!.
member([_|L],M):-
	member(L,M).

delete([Goal|Tail],Goal,Tail):-
	!.
delete([Head|Tail],Goal,[Head|Output]):-
	delete(Tail,Goal,Output).

bridge_1(w,y).
bridge_1(y,w).
bridge_2(w,y).
bridge_2(y,w).
bridge_3(y,z).
bridge_3(z,y).
bridge_4(z,x).
bridge_4(x,z).
bridge_5(x,w).
bridge_5(w,x).
bridge_6(x,w).
bridge_6(w,x).
bridge_7(w,z).
bridge_7(z,w).

statechange(cross_bridge_1,(Island,Bridges_not_crossed),(NewPlace,New_List)):-
	member(Bridges_not_crossed,b1),
	delete(Bridges_not_crossed,b1,New_List),
	bridge_1(Island,NewPlace).
statechange(cross_bridge_2,(Island,Bridges_not_crossed),(NewPlace,New_List)):-
	member(Bridges_not_crossed,b2),
	delete(Bridges_not_crossed,b2,New_List),
	bridge_2(Island,NewPlace).
statechange(cross_bridge_3,(Island,Bridges_not_crossed),(NewPlace,New_List)):-
	member(Bridges_not_crossed,b3),
	delete(Bridges_not_crossed,b3,New_List),
	bridge_3(Island,NewPlace).
statechange(cross_bridge_4,(Island,Bridges_not_crossed),(NewPlace,New_List)):-
	member(Bridges_not_crossed,b4),
	delete(Bridges_not_crossed,b4,New_List),
	bridge_4(Island,NewPlace).
statechange(cross_bridge_5,(Island,Bridges_not_crossed),(NewPlace,New_List)):-
	member(Bridges_not_crossed,b5),
	delete(Bridges_not_crossed,b5,New_List),
	bridge_5(Island,NewPlace).
statechange(cross_bridge_6,(Island,Bridges_not_crossed),(NewPlace,New_List)):-
	member(Bridges_not_crossed,b6),
	delete(Bridges_not_crossed,b6,New_List),
	bridge_6(Island,NewPlace).
statechange(cross_bridge_7,(Island,Bridges_not_crossed),(NewPlace,New_List)):-
	member(Bridges_not_crossed,b7),
	delete(Bridges_not_crossed,b7,New_List),
	bridge_7(Island,NewPlace).

goal_state((_,[])).


%General Graph Search Engine
/**
make_node creates a new node in the tree

The 3rd argument can be used to add heuristic
information when dealing with more advanced searches 
such as A* search

state_of returns the state from a node
*/
make_node(Rule,State,_,(Rule,State)). 
state_of((_,State),State). 

/**
loop_check ensures that the new state that we 
move to isn't already in the path that is passed
in as second argument, ensuring that we aren't in 
a loop
*/
loop_check(_,[]). 
loop_check(State,[H|T]):-
	state_of(H,AState), 
	State \= AState,
	loop_check(State,T). 

/**
choose takes in a list containing multiple paths 
and returns the FIRST path in the list and 
the remaining paths as a list of lists called Paths.
This function varies between different search algorithms
*/
%DF algorithm and BF algorithm
choose([Path|Paths], Path, Paths).  

/**
this adds a new path to the set of all possible paths 
This function also varies between different search algorithms
*/
%DF algorithm
add_to_paths(NewPath,OldPath,AllPaths):- 
	append(NewPath,OldPath,AllPaths).
%BF algorithm
/*
add_to_paths(NewPath,OldPath,AllPaths):-
	append(OldPath,NewPath,AllPaths).
*/

/**
one_step_extentions takes the first node of a path 
and returns a list of lists which contain new paths 

The findall function works by saying the new return value
is a path which has a NewNode appended to the head of it
The goal of the findall has 3 statements in it :
	it gets a new state from the statechanges specifed, there 
	can be multiple valid new states so findall will consider all 
	it then checks the new state taken is not in a loop 
	it creates a new node with this new state and that is added to 
	the new path that is returned
*/
one_step_extentions([Node|Path],NewPaths):-
	state_of(Node,State),
	%write("OSE_state: "),write(State),nl,
	findall([NewNode,Node|Path],
			(statechange(Rule,State,NewState),
			loop_check(NewState,[Node|Path]),
			make_node(Rule,NewState,_,NewNode)),
			NewPaths).


%Generic version which can be used with most algorithms
/**
base case for search 
Paths is a list of lists with different paths 
the base case matched the head of the current path with 
the goal state
*/
/*
search(Paths,[Node|Path]):-
	choose(Paths,[Node|Path],_),
	state_of(Node,State),
	goal_state(State).
*/
/**
main definition of the search function 
chooses a new path from the list of paths 
extends the current path by 1 to get a new path 

puts new paths at the start of the list of all paths 
(this last step is what makes this algorithm DF 
as it keeps searching the current path till the end)
*/
/*
search(Paths,SolnPath):-
	choose(Paths,Path,OtherPaths),
	one_step_extentions(Path,NewPaths),
	add_to_paths(NewPaths,OtherPaths,AllPaths), 
	search(AllPaths,SolnPath).
*/

%Lite version which can only be used with DF algorithm
/**
The lite version relies on the fact that prolog's default 
search is top-down and DF. This means that everytime state_change
is called,it will return the new state as is specified by DF.
So rather than storing all the paths at a particular depth 
and then selecting the head of that list each time using the 
choose function, we just select one path which is the path we 
wish to expand fully and rely on the default prolog search engine 
to backtrack and try the next deepest path automatically. 
*/
/**
base case for search
*/
/*
search([Node|Path],[Node|Path]):-
	state_of(Node,State),
	goal_state(State).
*/
/**
main definition of search function
again, there is no choosing paths or the one_step_extention
which results in a list of paths
you take in a path and return a new list which is your extended 
path
*/
/*
search([Node|Path],SolnPath):-
	state_of(Node,State),
	statechange(Rule,State,NewState),
	loop_check(NewState,[Node|Path]),
	make_node(Rule,NewState,_,NewNode),
	search([NewNode,Node|Path],SolnPath).
*/

%IDDF version of search 
/*
Base case where goal state is reached
*/
search(Paths,[Node|Path],Depth):-
	choose(Paths,[Node|Path],_),
	state_of(Node,State),
	goal_state(State).
/*
Case when you reach a node at depth = depth limit 
Everytime the search predicate is called, there is 
a choice point where any of the 3 definitions can be 
taken. The cut in this case means that once a "leaf"
node is hit, you end that recursive path and don't try 
any other versions of the predicate search, as in most
cases the 3rd predicate would also match. 
*/
search(Paths,SolnPath,Depth):-
	choose(Paths,Path,OtherPaths),
	length(Path,PathLength),
	PathDepth is PathLength-1,
	PathDepth = Depth,!,
	search(OtherPaths,SolnPath,Depth).
search(Paths,SolnPath,Depth):-
	choose(Paths,Path,OtherPaths),
	one_step_extentions(Path,NewPaths),
	%write(NewPaths),nl,
	add_to_paths(NewPaths,OtherPaths,AllPaths),
	search(AllPaths,SolnPath,Depth).
iddf_search(Paths,SolnPath,Depth):-
	search(Paths,SolnPath,Depth). 
iddf_search(Paths,SolnPath,Depth):-
	Depth1 is Depth+1,
	write("Depth: "),write(Depth1),nl,
	iddf_search(Paths,SolnPath,Depth1).

/*
%IDDF version with Lite GGSE for DF
NOT WORKING!!!
search([],[],[]).
search([Node|Path],[Node|Path],_):-
	state_of(Node,State),
	goal_state(State).
search(Path,SolnPath,Depth):-
	length(Path,PathLength), 
	PathDepth is PathLength-1, 
	Depth = PathDepth.
search([Node|Path],SolnPath,Depth):-
	write("here1"),
	state_of(Node,State), 
	statechange(Rule,State,NewState),
	loop_check(State,[Node|Path]),
	make_node(Rule,NewState,_,NewNode),
	search([NewNode,Node|Path],SolnPath,Depth).
iddf_search(Paths,SolnPath,Depth):-
	write("here"),nl,
	search(Paths,SolnPath,Depth).
iddf_search(Paths,SolnPath,Depth):-
	Depth1 is Depth+1, 
	write("depth: "),write(Depth1),nl,
	iddf_search(Paths,SolnPath,Depth1).
*/
