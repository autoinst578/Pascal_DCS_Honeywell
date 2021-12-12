	Var
		clock : AxTimeRec;
		
	begin
		BlockBegin;
		
			Fillchar(Tim,sizeof(Tim),0); (* Zeroing *)
			GetTime(clock); (* Get the system time *)
			With clock do begin (* clock is a record *)
				Tim[10] := Tic;
				Tim[9] := Second;
				Tim[8] := Minute;
				Tim[7] := Hour;
			end;
		
		BlockEnd;
	end;
end.
	
