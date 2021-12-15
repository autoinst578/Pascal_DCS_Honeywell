for counter 			:= initial value to final value do statement;
In which initial value 	<= final value
for counter 			:= initial value downto final value do statement;
In which initial value 	>= final value

(* Example *)
const 
	VecLen 		= 100;
var 
	Vec 	:ARRAY[1..VecLen] OF REAL;
	Min 	: REAL;
	I 		: INTEGER;
Begin
	Min 	:= Vec[1];
	for I 	:=2 to VecLen do if Vec[I] < Min then Min:=Vec[I];
end;