(* Example *)
Label ErrorExit;
var
	Error : Boolean;
begin
 …
	Error : true;
	If Error then goto ErrorExit;
 …
 ErrorExit:
 end;