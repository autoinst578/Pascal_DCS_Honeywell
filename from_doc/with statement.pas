(* Example *)
with nowday do begin
	if mon = 12 then begin
		mon :=1;
		yea := yea + 1,
	end else mon := mon + 1;
end;

(* Corresponds to: *)
if nowday.mon = 12 then begin
	nowday.mon:=1;
	nowday.yea := nowday.yea + 1;
end else nowday.mon:= nowday.mon + 1;