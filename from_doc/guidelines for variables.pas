//Value ranges for integer variables
(* Example 1 *)
var TruthValue : boolean;
	procedure BYTE_TEST (s : byte); 
	begin
		BlockBegin;
		s := byte(TruthValue);
		BlockEnd;
	end;
end.

(* Example 2 *)
procedure CALC_TEST (	s1 : byte; 
						s2 : byte; 
						W1 : word; 
						W2 : word; 
						I1 : integer; 
						I2 : integer; 
						Li1 : longint; 
						Li2 : longint; 
						var s : byte; 
						var W : word; 
						var I : integer; 
						var Li : longint);
	begin
		BlockBegin;
			s := byte(s1 + s2);
			W := W1 + W2;
			I := I1 + I2;
			Li := Li1 + Li2;
		BlockEnd;
	end;
end.

(* Example 3 *)
procedure WORD_TEST (	W1 : word; 
						I1 : integer; 
					 var I : integer); 
	begin
		BlockBegin;
			I := integer(I1 + W1);
		BlockEnd;
	end;
end.

(* Example 4 *)
procedure INT_TEST (	W1 : word; 
						I1 : integer; 
					 var W : word); 
	begin
		BlockBegin;
			W := word(I1 + W1);
		BlockEnd;
	end;
end.

//Division by zero
(* Example 5 *)
procedure ZERO_TEST (	s1 : byte; 
						s2 : byte; 
						W1 : word; 
						W2 : word; 
						I1 : integer; 
						I2 : integer; 
						Li1 : longint; 
						Li2 : longint; 
						var s : byte; 
						var W : word; 
						var I : integer; 
						var Li : longint; 
						var Ss : arr_30_char;
						var Ws : arr_30_char;
						var Is : arr_30_char;
						var Lis : arr_30_char);
	begin
		BlockBegin;
			if (s2 = 0) then begin
				s := 0;
				Ss := 'Division by zero ! ';
			end
			else begin 
				s := s1 div s2;
				Ss := ' ';
			end; 
			if (W2 = 0) then begin
				W := 0;
				Ws := 'Division by zero ! ';
			end
			else begin
			W := W1 div W2;
			Ws := ' ';
			end;
			if (I2 = 0) then begin
				I := 0;
				Is := ' Division by zero ! ';
			end
			else begin 
				I := I1 div I2;
				Is := ' ';
			end;
			if (Li2 = 0) then begin
				Li := 0;
				Lis := ' Division by zero ! ';
			end
			else begin 
				Li := Li1 div Li2;
				Lis := ' ';
			end;
		BlockEnd;
 end;
end.

//Testing the value of signal variables
(* Example 6 *)
procedure SNG_TEST (s1 : byte; 
					var s : byte; 
					var Ss : arr_30_char);
	begin
		BlockBegin;
			if ((s1 and 1) = 1) then begin
				s := 1;
				Ss := 'Signal value is one ! ';
			end
			else begin 
				s := 0;
				Ss := 'Signal value is zero ! ';
			end; 
		BlockEnd;
	end;
end.

(* Alternatively: *)
procedure SNG_TEST (s1 : byte; 
					var s : byte; 
					var Ss : arr_30_char);
	begin
		BlockBegin;
			if odd(s1) then begin
				s := 1;
				Ss := 'Signal value is one ! ';
			end
			else begin 
				s := 0;
				Ss := 'Signal value is zero ! ';
			end; 
		BlockEnd;
	end;
end.