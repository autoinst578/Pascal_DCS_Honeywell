var
	A, B, C : real;
	I, J, K : integer;
	Numbers : 0..9;
	Measures : Vector;
 
(* Example *)
{$ \AC_CONF\TMP\PASCBEGI.PAS}

Var
	Coating : arr_20_char;
	
procedure PASTA (si1		: byte;
				 si2  		: byte;
				 var Mak 	: arr_20_char;)
	
	
Begin
	Blockbegin;
		Mak := si1 + si2
	Blockend;
end;
end
 
(* Example *)
{$ \AC_CONF\TMP\PASCBEGI.PAS}
procedure PASTA (si1		: byte; 
				 si2		: byte; 
				 var Mak 	: arr_20_char;)
 
Var
	I, J : integer;
Begin
	Blockbegin;
		for I := 1 to 10 do begin
			for J := 1 to 20 do begin
				(* do something *)
			end;
		end;
	Blockend;
end;
end.
 