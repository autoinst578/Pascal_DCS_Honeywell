
(* SCREEN BUTTONS FILL *)

if odd(sed) then vol := 2 else begin
	if odd(rst) then col := 4 else col := 2;
end; 

if odd(stt) or odd(sto) or odd(sti) then sed := 0;
if Ost = 12 then sto := 0;

(* CHECKING STEPS WHEN RUNNING *)
v[1] := 1;
if (ost=10) then begin
	if odd(fse) then v[1] := get__PPM5_RA1EMJ811_rng_byte_2s;
	if odd(sse) then v[1] := get__PPM5_RA1EMJ812_rng_byte_2s;
end;

(* fse := get__RA1EME311C_fse_byte_2s;*)
(* sse := get__RA1EME311C_sse_byte_2s;*)

v[1] := 1;
if (ost=10) then begin
	v[1] := get__PPM5_RA1EMB311_rng_byte_s2;
end;