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
	get_3_columns(List1,Box1T,Box2T,Box3T),
	%Get Box1
	transpose(Box1T,Box11,Box12,Box13),
	append(Box11,Box12,Temp1),
	append(Temp1,Box13,Box1),
	%Get Box2
	transpose(Box2T,Box21,Box22,Box23),
	append(Box21,Box22,Temp2),
	append(Temp2,Box23,Box2),
	%Get Box3
	transpose(Box3T,Box31,Box32,Box33),
	append(Box31,Box32,Temp3),
	append(Temp3,Box33,Box3).

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

run():-
	check_box([1,8,3,2,4,5,6,7,9,2,4,5,6,7,9,1,3,8,6,7,9,1,3,8,2,4,5,3,1,2,4,5,6,8,9,7,4,5,6,8,9,7,3,1,2,7,9,8,3,1,2,4,5,6,5,2,1,7,6,3,9,8,4,8,3,7,9,2,4,5,6,1,9,6,4,5,8,1,7,2,3]).
	%check_box([1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9]).
	
	

		
