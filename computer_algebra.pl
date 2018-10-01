:- initialization(main).

main :-
	derivative(Z*2,Z,B),
	writeln(B).

power_to_mul(A*B,A1*B1) :-
	power_to_mul(A,A1),
	power_to_mul(B,B1).
power_to_mul(A^B,C) :-
	integer(B),
	B > 1,
	D is B - 1,
	power_to_mul(A^D,D1),
	C = A*D1.
power_to_mul(A^B,A) :-
	B = 1.
power_to_mul(A,A) :-
	atom(A),
	number(A).

atom_or_number(A) :-
	atom(A);
	number(A).

distribute_multiplication(A*B,A1*B1) :-
	A \= _+_,
	B \= _+_,
	writeln([A,B]),
	distribute_multiplication(A,A1),
	distribute_multiplication(B,B1).
distribute_multiplication(A*(B+C),D) :-
	distribute_multiplication(A,A1),
	distribute_multiplication(B,B1),
	distribute_multiplication(C,C1),
	distribute_multiplication(A1*B1+A1*C1,D).
distribute_multiplication(A,A) :-
	atom_or_number(A).
distribute_multiplication((A+B)*C,D) :-
	distribute_multiplication(C*(A+B),D).
distribute_multiplication(A+B,A1+B1) :-
	distribute_multiplication(A,A1),distribute_multiplication(B,B1).

derivative(X,X,1) :-
	var(X).
derivative(A,_,0) :-
	number(A).
derivative(A*B,X,C) :-
	derivative(A,X,A1),
	derivative(B,X,B1),
	C = A*B1+B*A1.
derivative(A/B,X,C) :-
	derivative(A,X,A1),
	derivative(B,X,B1),
	C = (B*A1-A*B1)/(B1*B1).
derivative(A-B,X,A1-B1) :-
	derivative(A,X,A1),
	derivative(B,X,B1).
derivative(A+B,X,A1+B1) :-
	derivative(A-B,X,A1-B1).
