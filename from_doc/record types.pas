Description
	Name = Record
	Field1: Type;
	Field2: Type;
	Field3: Type;
end;

(* Example *)
Type
	Date = record
	Year :integer;
	Month :1..12;
	Date :1..31;
end;

	Measurement = record
	Date :Date;
	Press,Lpt :real;
end;

(* Example *)
Var
	Time : Date;
	Measurement table : Measurement;
	
begin 
	Time.Year := 2005;
	Measurement table.Time.Day := 14;
	Measurement table.Pressure := 1013.55;
end;