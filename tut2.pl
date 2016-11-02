%
%Question1
/**
The following section of code defines the 6 different
actions that the AI can do
*/
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
%
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
/*
%DF algorithm
add_to_paths(NewPath,OldPath,AllPaths):- 
	append(NewPath,OldPath,AllPaths).
*/
%BF algorithm
add_to_paths(NewPath,OldPath,AllPaths):-
	append(OldPath,NewPath,AllPaths).
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
	findall([NewNode,Node|Path],
			(statechange(Rule,State,NewState),
			loop_check(NewState,[Node|Path]),
			make_node(Rule,NewState,_,NewNode)),
			NewPaths).

goal_state((4,0)).

%Generic version which can be used with all algorithms
/**
base case for search 
Paths is a list of lists with different paths 
the base case matched the head of the current path with 
the goal state
*/
search(Paths,[Node|Path]):-
	choose(Paths,[Node|Path],_),
	state_of(Node,State),
	goal_state(State).
/**
main definition of the search function 
chooses a new path from the list of paths 
extends the current path by 1 to get a new path 

puts new paths at the start of the list of all paths 
(this last step is what makes this algorithm DF 
as it keeps searching the current path till the end)
*/
search(Paths,SolnPath):-
	choose(Paths,Path,OtherPaths),
	one_step_extentions(Path,NewPaths),
	add_to_paths(NewPaths,OtherPaths,AllPaths), 
	search(AllPaths,SolnPath).

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








