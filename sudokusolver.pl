%
check_repeat([]):-!.
check_repeat([H|List]):-
	\+member(H,List),
	check_repeat(List).

check_rows([]):-!.
check_rows([H1,H2,H3,H4,H5,H6,H7,H8,H9|List]):-
	check_repeat([H1,H2,H3,H4,H5,H6,H7,H8,H9]),
	check_rows(List).

transpose([],[],[],[],[],[],[],[],[],[]):-!.
transpose([H1,H2,H3,H4,H5,H6,H7,H8,H9|List],[H1|A],[H2|B],[H3|C],[H4|D],[H5|E],[H6|F],[H7|G],[H8|H],[H9|I]):-
	transpose(List,A,B,C,D,E,F,G,H,I).

check_cols(List):-
	transpose(List,A,B,C,D,E,F,G,H,I),
	check_rows(A),
	check_rows(B),
	check_rows(C),
	check_rows(D),
	check_rows(E),
	check_rows(F),
	check_rows(G),
	check_rows(H),
	check_rows(I).

run(A,B,C,D,E,F,G,H,I):-
	transpose([1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9],A,B,C,D,E,F,G,H,I).
	
	

	
	
