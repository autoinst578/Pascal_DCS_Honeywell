(* Example *)
procedure sums (	a : real;
					b : real;
				var c : real);
				
Begin
	c := a + b;
end;
(*Block procedure begins here*)
procedure total ( 	Re1 : real;
					Re2 : real;
				var Sum : real);
Begin
	Blockbegin;
	Sums(Re1, Re2, Sum);
	Blockend;
end;
end