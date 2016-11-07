%
/*
check_repeat([]):-!.
check_repeat([H|List]):-
	\+member(H,List),
	check_repeat(List).
*/

check_repeat([],[]):-!.
check_repeat([H|List],StandardList):-
	member(H,StandardList),
	delete(StandardList,H,NewList),
	check_repeat(List,NewList).

check_rows([]):-!.
check_rows([H1,H2,H3,H4,H5,H6,H7,H8,H9|List]):-
	check_repeat([H1,H2,H3,H4,H5,H6,H7,H8,H9],[1,2,3,4,5,6,7,8,9]),
	check_rows(List).

transpose([],[],[],[],[],[],[],[],[],[]):-!.
transpose([H1,H2,H3,H4,H5,H6,H7,H8,H9|List],[H1|A],[H2|B],[H3|C],[H4|D],[H5|E],[H6|F],[H7|G],[H8|H],[H9|I]):-
	transpose(List,A,B,C,D,E,F,G,H,I).
transpose([],[],[],[]):-!.
transpose([H1,H2,H3|List],[H1|A],[H2|B],[H3|C]):-
	transpose(List,A,B,C).
get_3_columns([],[],[],[]):-!.
get_3_columns([H1,H2,H3,H4,H5,H6,H7,H8,H9|List],[H1,H2,H3|A],[H4,H5,H6|B],[H7,H8,H9|C]):-
	get_3_columns(List,A,B,C).
extract_box(List,Box1,Box2,Box3):-
	transpose(List,AT1,AT2,AT3),
	append(AT1,AT2,Temp),
	append(Temp,AT3,List1),
	get_3_columns(List1,Box1,Box2,Box3).

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

check_box(List):-
	get_3_columns(List,A,B,C),
	extract_box(A,Box1A,Box2A,Box3A),
	extract_box(B,Box1B,Box2B,Box3B),
	extract_box(C,Box1C,Box2C,Box3C),
	check_rows(Box1A),
	check_rows(Box2A),
	check_rows(Box3A),
	check_rows(Box1B),
	check_rows(Box2B),
	check_rows(Box3B),
	check_rows(Box1C),
	check_rows(Box2C),
	check_rows(Box3C).

check_sudoku(List):-
	check_rows(List),
	check_cols(List),
	check_box(List).

run(A2):-
	%check_sudoku([1,8,3,2,4,5,6,7,9,A,4,5,6,7,9,1,3,8,6,7,9,1,3,8,2,4,5,3,1,2,4,5,6,8,9,7,4,5,6,8,9,7,3,1,2,7,9,8,3,1,2,4,5,6,5,2,1,7,6,3,9,8,4,8,3,7,9,2,4,5,6,1,9,6,4,5,8,1,7,2,3]).
	check_sudoku([8,A2,A3,A4,A5,A6,A7,A8,A9,B1,B2,3,6,B5,B6,B7,B8,B9,C1,7,C3,C4,9,C6,2,C8,C9,D1,5,D3,D4,D5,7,D7,D8,D9,E1,E2,E3,E4,4,5,7,E8,E9,F1,F2,F3,1,F5,F6,F7,3,F9,G1,G2,1,G4,G5,G6,G7,6,8,H1,H2,8,5,H5,H6,H7,1,H9,I1,9,I3,I4,I5,I6,4,I8,I9]).
	
	

		
