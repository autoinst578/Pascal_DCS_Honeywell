var 
	ManualCut, rSens, Sens : byte;
	Txt0 : arr_15_char;
	
										(	in1 : byte;
											in2 : byte;
											in3 : byte;
											in4 : byte;
											in5 : byte;
											in6 : byte;
											in7 : byte;
											in8 : byte;
											in9 : byte;
										var Tin : arr_8_char;
										var Din : arr_8_char;
											sbb : byte;
											cut : byte;		(* manual cut PB *)
											i10 : byte;
											i11 : byte;
											i12 : byte;		 	(* PB2 air cannon pb *)
											i13 : byte;		 	(* DB1 1/2D knockdown pb *)
											i14 : byte;		 	(* DB5 9/10D knockdown pb *)
											i15 : byte;		 	(* DB2 knockdown pb *)
											i16 : byte;		 	(* DB3 knockdown pb *)
											i17 : byte; 	 	(* DB4 knockdown pb *)
											i18 : byte;		 	(* DB5 knockdown pb *)
											i20 : byte;		 	(* Rope Switch D-B1 *)
											i21 : byte;		 	(* Rope Switch D-B5 *)
											i22 : byte;		 	(* Man. Knockdown from PB K-B1 *)
											i42 : byte;		 	(* 4D Cyl. 16 FS *)
											i72 : byte;		 	(* 7D Cyl. 32 FS *)
										var NBR : real;			
										var Tim : arr_8_char;	(* last Break time *)
										Var Dim : arr_8_char; 	(* last break time *)
										Var Ti1 : arr_8_char;
										Var Ti2 : arr_8_char;
										Var Ti3 : arr_8_char;
										Var Ti4 : arr_8_char;
										Var Ti5 : arr_8_char;
										var DUR : real;
										var DU1 : real;
										var DU2 : real;
										var DU3 : real;
										var DU4 : real;
										var brk : byte;
										var Txt : arr_15_char;
										var Tx1 : arr_15_char;
										var Tx2 : arr_15_char;
										var Tx3 : arr_15_char;
										var Tx4 : arr_15_char;
										var stc : byte;			(* start count *)
										var syo : byte;			(* system ON *)
										var Sen : arr_18_byte;
										var D1	: arr_8_char;
										var D2	: arr_8_char;
										var D3	: arr_8_char;
										var D4	: arr_8_char);
										
	begin
	BlockBegin:
	
(*		if not odd(Syo) then begin
		
			if odd(cut) then begin
				txt0:= 'Manual cut     ';
				Syo:=1;
			end;
			
			if odd(i12) then begin
				txt0:= 'Manual on PB2  ';
				Syo:=1;
			end;
			
			if odd(i13) then begin
				txt0:= 'Manual on DB1  ';
				Syo:=1;
			end;
			
			if odd(i14) then begin
				txt0:= 'Manual on DB5  ';
				Syo:=1;
			end;
			
			if odd(i15) then begin
				txt0:= 'Manual on DB2  ';
				Syo:=1;
			end;
			
			if odd(i16) then begin
				txt0:= 'Manual on DB3  ';
				Syo:=1;
			end;
			
			if odd(i17) then begin
				txt0:= 'Manual on DB4  ';
				Syo:=1;
			end;
			
			if odd(i18) then begin
				txt0:= 'Man Door Cyl.51';
				Syo:=1;
			end;
			
			if odd(i20) then begin
				txt0:= 'RopeSwitch 1-3D';
				Syo:=1;
			end;
			
			if odd(i21) then begin
				txt0:= 'Rope Switch 10D';
				Syo:=1;
			end;
			
			if odd(i22) then begin
				txt0:= 'Manual frm K-B1';
				Syo:=1;
			end;
			
		end;
*)		

		if odd(not Syo) then begin
		
			if odd(cut) then begin
				txt0:= 'Manual cut     '
				Syo:=1;
			end;
			
			if odd(in2) then begin
				txt0:= 'CYL. 6 BS      '
				Syo:=1;
			end;
			
			if odd(in3) then begin
				txt0:= 'CYL. 11 BS     '
				Syo:=1;
			end;
			
			if odd(in4) then begin
				txt0:= 'CYL. 16 BS     '
				Syo:=1;
			end;
			
			if odd(i42) then begin
				txt0:= 'CYL. 16 BS     '
				Syo:=1;
			end;
			
			if odd(in5) then begin
				txt0:= 'CYL. 32 BS     '
				Syo:=1;
			end;
			
			
			if odd(i72) then begin
				txt0:= 'CYL. 32 FS     '
				Syo:=1;
			end;
			
			if odd(in6) then begin
				txt0:= 'CYL. 45 BS     '
				Syo:=1;
			end;
			
			if odd(in7) then begin
				txt0:= 'CYL. 51 BS     '
				Syo:=1;
			end;
			
			if Odd(in8) then begin
				Txt0:= 'CYL. 51 BS     '
				Syo:=1;
			end;
			
			if Odd(in9) then begin
				Txt0:= 'CYL. 21 BS     '
				Syo:=1;
			end;
			
			if Odd(i10) then begin
				Txt0:= 'CYL. 26 BS     '
				Syo:=1;
			end;
			
			if Odd(i11) then begin
				Txt0:= 'CYL. 38 BS     '
				Syo:=1;
			end;
			
(*			Sens:= in1 or in2 or in3 or in4 or in5 or in6 or in7;	*)
(*			Sens:= Sens or i42 or i72;	*)
(*			sens:= Sens or in8 or in9 or i10 or i11;	*)

		if odd(not Sens) then begin
			txt0:= 'unknown       '
			Syo:=1;
		end;
	end;
	
		if not pdd(Stc) and odd(sbb) then begin
			d4:=d3;
			d3:=d2;
			d2:=d1;
			d1:=dim;
			dim:=din;
			du4:=du3;
			du3:=du2;
			du2:=du1;
			du1:=dur;
			dur:=0;
			tx4:=tx3;
			tx3:=tx2;
			tx1:=txt;
			txt:=tx0;
			ti5:=ti4;
			ti4:=ti3;
			ti2:=ti1;
			ti1:=tim;
			tim:=tin;
			Stc:=1;
		end;
		
		if odd(sbb) and odd(Stc) then dur:=dur + (1/60);
		
(*		rSens:= in1 or in2 or in3 or in4 or in5 or in6;	*)
(*		rSens:= rSens or i42 or i72; *)
(*		rSens:= rSens or in7 or in8 or in9 or i10 or i11; *)
(*		rSens:= rSens or i12 or i13 or i14 or i15 or i16 or i17 or i18 or i20 or i21 or i22; *)

		if not odd(sbb) and odd(Syo) then begin
			Syo:=0;
		end;
		
		if not odd(sbb) and odd(Stc) then begin
			Stc:=0;
		end;
		
	BlockEnd;
	end;
end.


										
										
										
