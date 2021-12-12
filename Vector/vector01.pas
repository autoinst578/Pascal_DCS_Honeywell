var OldRng : byte;

procedure _101			(	rng : byte;	(* Running info *)
						var rst : byte;
						var RUT : real;	(* Run time *)
						var STC : real);(* Start count *)
						
var i : byte;

begin
	BlockBegin;
	
	(* RUN TIME COUNTER *)
	
	for i := 1 to 16 do if odd(Rng[i]) then RUT[i]:=RUT[i]+1;
	
	(* START TIME COUNTER *)
	for i := 1 to 16 do if Rng[i] > OldRng[i] then STC[i]:=STC[i]+1;
	
	(* RESET COUNTER *)
	for i := 1 to 16 do
	begin
		if odd (Rst[i] then
			begin
			RUT[i]:=0;
			STC[i]:=0;
			end;
		end;
	
	(* RESET COUNTER AND SAVE RNG-SIGNALS *)
	for i := 1 to 16 do
	begin
		OldRng[i] := Rng[i];
		Rst[i] := 0;
	    end;
end;
