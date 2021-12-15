(* Example 1 *)
Var
	Experiment : ARRAY[1..50] OF REAL; (*Unidimensional table*)
 
(* Example 2 *)
Var
	Table : ARRAY[1..50, 1..60] OF INTEGER; (*Twodimensional table*)
 
(* Example 3 *)
Const
	n = 50; m = 60;
Type
	Index = 1...n;
	Vector = ARRAY[Index] OF REAL;
 
Var
	a : Vector;
	Tab : ARRAY[1..n] OF ARRAY[1..m] OF INTEGER;
	(* A table element can be addressed through the program. *)

	(* Example *)
Var
	Assistant : Integer;
begin 
	Experiment[1] := 123.456;
	Assistant := Taulu[1,2];
	Tab[Assistant,m] := 32000;
end;
	(* If the reference is not correct and if the index refers outside the table, then it causes program execution error. *)