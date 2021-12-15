(* Example *)
{$\AC_CONF\TMP\PASBEGI.PAS}
function sum ( 	a : real;
				b : real ) : real;
Begin
	sum := a + b;
end;
(*Block procedure begins here*)
procedure total (		Re1 : real;
						Re2 : real;
				  var Summa : real);
Begin
	Blockbegin;
		Sum := summa(Re1, Re2);
	Blockend;
end;
end.