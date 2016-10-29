% 1
head([H|T],H). 

%2
last([L],L).
last([H|T],L):-
	last(T,L).

%3
middle([H|T],M):-
	exclude_last(T,M).
exclude_last([L],[]):-
	!.
exclude_last([H|T],[H|M]):-
	exclude_last(T,M).

%4
member([M|_],M):-!.
member([_|L],M):-
	member(L,M).

%5
append_list([],[],[]).
append_list([],N,N).
append_list([H|T],N,[H|List]):-
	append_list(T,N,List).

%6
reverse([],[]).
reverse([H|T],Output):-
	reverse(T,Output_1),
	append_list(Output_1,[H],Output).

%7
reverse_1([],[]).
reverse_1([H|T],Output):-
	append_list(Output_1,[H],Output),
	reverse_1(T,Output_1).

%8
reverse_2([],List,List).
reverse_2([H|PassDown],List,Output):-
	reverse_2(PassDown,[H|List],Output).
	
%9
delete([Goal|Tail],Goal,Tail):-
	!.
delete([Head|Tail],Goal,[Head|Output]):-
	delete(Tail,Goal,Output).

%10
delete_all([],Goal,[]).
delete_all([Goal|Tail],Goal,Output):-
	delete_all(Tail,Goal,Output).
delete_all([Head|Tail],Goal,[Head|Output]):-
	delete_all(Tail,Goal,Output).

%11
replace([],Goal,Replace,[]).
replace([Goal|Tail],Goal,Replace,[Replace|Output]):-
	replace(Tail,Goal,Replace,Output).
replace([Head|Tail],Goal,Replace,[Head|Output]):-
	replace(Tail,Goal,Replace,Output).

%12
sub_list(List,[]):-!.
sub_list([],[]):-!.
sub_list(List,Sublist):-
	sub_test(List,Sublist,List,Sublist). 

sub_test(TempList,[],List,SubList):-!. 
sub_test([],[],List,SubList).
sub_test([Head|TempList],[Head|TempSubList],List,SubList):-
	sub_test(TempList,TempSubList,List,SubList).
sub_test([Head|TempList],[Head_1|TempSubList],[H|List],SubList):-
	sub_list(List,SubList). 

%13 
sieve([],Element,[]).	
sieve([Head|List],Element,[Head|Output]):-
	Head>=Element,
	sieve(List,Element,Output).
sieve([Head|List],Element,Output):-
	sieve(List,Element,Output).

%14
partition([],Size,Size,[],[]):-!.
partition(List,Size,Counter,List1,List2):-
	Counter=0,
	size(List,Size1),
	Counter1 is Counter+1,
	partition(List,Size1,Counter1,List1,List2).
partition([H|List],Size,Counter,[H|List1],List2):-
	Counter<Size/2,
	Counter1 is Counter+1,
	partition(List,Size,Counter1,List1,List2).
partition([H|List],Size,Counter,List1,[H|List2]):-
	Counter>=Size/2,
	Counter1 is Counter+1,
	partition(List,Size,Counter1,List1,List2).

size([],1).
size([Head|List],Size):-
	size(List,SizeR), 
	Size is SizeR+1.
	
%15
partition_qs([],Target,[],[]):-!.
partition_qs([H|List],Target,[H|List1],List2):-
	H<Target,
	partition_qs(List,Target,List1,List2).
partition_qs([H|List],Target,List1,[H|List2]):-
	H>=Target,
	partition_qs(List,Target,List1,List2).

%16
quicksort([],[]).
quicksort([H|[]],[H]).
quicksort([H|List],Output):-
	partition_qs(List,H,List1,List2),
	append_list(List1,[H],List1_App),
	quicksort(List1_App,Out1),
	quicksort(List2,Out2),
	append_list(Out1,Out2,Output).

%17
subset(List,[]):-!.
subset([H|List],[H|Subset]):-
	subset(List,Subset).
subset([H|List],[H1|Subset]):-
	subset(List,[H1|Subset]).
	
%18
intersection([],List2,[]):-!.
intersection([H|List1],List2,[H|ISection]):-
	member(List2,H), 
	delete_all(List1,H,List1New),
	intersection(List1New,List2,ISection).
intersection([H|List1],List2,ISection):-
	\+member(List2,H),
	delete_all(List1,H,List1New),
	intersection(List1New,List2,ISection).

%19
union([],List2,List2).
union([H|List1],List2,[H|Union]):-
	delete_all(List1,H,List1New),
	delete_all(List2,H,List2New),
	union(List1New,List2New,Union).

%run 
run(List1):-
	union([1,2,3,4,4,2,3,2],[1,1,3,6,7,8,4],List1).
