%
%Question1
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

make_node(Rule,State,_,(Rule,State)). 
state_of((_,State),State). 

loop_check(_,[]). 
loop_check(State,[H|T]):-
	state_of(H,AState), 
	State \= AState,
	loop_check(State,T). 

choose([Path|Paths], Path, Paths). 

add_to_paths(NewPath,OldPath,AllPaths):- 
	append(NewPath,OldPath,AllPaths).

one_step_extentions([Node|Path],NewPaths):-
	state_of(Node,State), 
	findall([NewNode,Node|Path],
			(statechange(Rule,State,NewState),
			loop_check(NewState,[Node|Path]),
			make_node(Rule,NewState,_,NewNode)),
			NewPaths).

goal_state((4,0)).

search(Paths,[Node|Path]):-
	choose(Paths,[Node|Path],_),
	state_of(Node,State),
	goal_state(State).
search(Paths,SolnPath):-
	choose(Paths,Path,OtherPaths),
	one_step_extentions(Path,NewPaths),
	add_to_paths(NewPaths,OtherPaths,AllPaths), 
	search(AllPaths,SolnPath).

