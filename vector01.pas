var OldRng : byte;

procedure _101			(var Rng : arr_16_byte;	(* Running info *)
						 var rst : arr_16_byte;
						 var Orn : arr_16_real;
						 var Rut : arr_16_real;		(* Run time *)
						 var Stc : arr_16_real);(* Start count *)
						
var i : byte;

begin
	BlockBegin;
	
	(* RUN TIME COUNTER *)
	
	for i := 1 to 16 do if odd(Rng[i]) then Rut[i]:=Rut[i]+1;
	
	(* START TIME COUNTER *)
	for i := 1 to 16 do if Rng[i] > Orn[i] then Stc[i]:=Stc[i]+1;
	
	(* RESET COUNTER *)
	for i := 1 to 16 do
	begin
		if odd (Rst[i] then
			begin
			Rut[i]:=0;
			Stc[i]:=0;
			end;
		end;
	
	(* RESET COUNTER AND SAVE RNG-SIGNALS *)
	for i := 1 to 16 do
	begin
		Orn[i] := Rng[i];
		Rst[i] := 0;
	    end;
	
end;
