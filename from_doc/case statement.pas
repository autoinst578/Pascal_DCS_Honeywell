case selector of
	L1 : statement1;
	L2 : statement2;
	L3 : statement3;
else
	statement4;
end;

(* Example *)
var
	Ordinalnumber : 1..106;
	Inertgas : (He,Ne,Ar,Kr,Xe,Rn,None);
case Ordinalnumber of
	2 : Inertgas 	:= He;
	10 : Inertgas 	:= Ne;
	18 : Inertgas 	:= Ar;
	36 : Inertgas 	:= Kr;
	54 : Inertgas 	:= Xe;
	86 : Inertgas 	:= rN;
	else Inertgas 	:= None;
end;