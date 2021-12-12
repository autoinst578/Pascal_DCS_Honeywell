unit PASCSUBR;
{$S-}
interface
	{$I \AC_CONF\INCLUDE\PASCINTE.INC}
	{$I \AC_CONF\INCLUDE\PASCREC.INC}

	const
		{$I M:\project\000\INCLUDE\CONSTINT.CON} 	(* Declaration of the project specific 		*)
													(* include-files. The declared include- 	*)
													(* files can include other standard or 		*)
													(* library type include-files. 				*)
													
				(* Include-files are stored in directory m:\Project directory\00x\INCLUDE or 	*)
				(* in its sub-directories if there are lot of include files. 					*)
		Empty_Timestamp = ' : : , '; 	(* Variable, constant and type names should be 			*)
										(* descriptive. Names can be longer than 3 or 8 		*)
										(* characters. 											*)

	type
		TArr_20_12_char = array [ 1..20 ] of TArr_12_char;
	
		TMessage = record					(* FSC message structure *)
			Milli_Seconds 	: byte;
			Deci_Seconds 	: byte;
			Seconds 		: byte;
			Minutes 		: byte;
			Hours 			: byte;
	end;
	
procedure FSCDATJOIN;

	var
		A_Channel_Time, 								(* Alarm timestamps 	*)
		B_Channel_Time 				: TArr_12_char;
		Time1, Time2, Time3, Time4 	: TArr_20_12_char;
		Times : array [ 1..40 ] of TArr_20_12_char ABSOLUTE Time1;
		
implementation

	{$I \AC_CONF\TMP\PASCSEGB.PAS}
	{$I \AC_CONF\INCLUDE\PASCLEV3.INC}
	{$I \AC_CONF\INCLUDE\PASCLEV1.INC}
	{$I \AC_CONF\TMP\PASCEXPI.PAS}
	
var
	OK 					: boolean;
	A_Message_Box,
	B_Message_Box 		: MailBoxRec;
	Alarm_Resource 		: ResourceRec;
	
{$R-} 
(************************************************************ 
(* 
(* 		Alarm and timestamp init. 
(* 
(* 		30.04.1999 HMX / FI06 Original version 
(* 
(* 
(************************************************************)

procedure Init_Variables;

var

	i, j : word; 	(* Loop variables are typically i, j and k. 	*)
					(* If a variable is used for other purposes 	*)
					(* the variable name has to be more descriptive *)
					
begin

	for i := 1 to 40 do begin
	
		for j := 1 to 20 do
			begin
			
				Times [ i, j ] := Empty_Timestamp;
				
			end;
			
	end;
	
end;

(*************************************************************************************** 
(* 
(* 		A message is read from the PLC and an alarm table is created. If the data
(* 		already exists in the vector pins the data is lost.
(* 		( The data is already read through B - channel ).
(* 		Otherwise the data is updated to pins. The alarm history is also studied to be sure
(* 		that the alarm has not yet been handled.
(* 		The alarm resource is seized for the time of the handling.
(*
(***************************************************************************************)
{$F+}
procedure A_Channel_Collect;
{$F-}

var
	i, j,
	Message_Length 			: word;
	Found 					: boolean;
	Alarm_Message 			: TMessage;
	Milli_Seconds_Count 	: word;
	Ascii_Time 				: string [ 2 ];
	Reference_Time 			: TArr_12_char;
	
begin

	AssignRC  ( Alarm_Resource, 'DatRes' );
	AssignMBX ( A_Message_Box, 'BufBoA' );
	CreateMBX ( A_Message_Box, 20 );
	
if Cold_Start = 0 then begin
	Init_Variables;
	Cold_Start := MaxWord;
end;

repeat

	(* If there is no room for the sub-routine parameters on same line *)
	(* all parameters are placed on different lines. 					*)
	Message_Length := ReadMBX ( A_Message_Box,
								A_Buffer_Message,
								SizeOf ( A_Buffer_Message ),
								MaxWord );
(* If there is a message that fits to the length message structure. *)
(* Length is a multiple of the message structure.					*)
if (Message_Length > 0 )
	Ascii_Time := Empty_Timestamp;
		
		Milli_Seconds_Count := Deci_Seconds * 100 + Milli_Seconds;
		str ( Milli_Seconds_Count:2, Ascii_Time );
		move ( Ascii_Time [ 1 ], A_Channel_Time [ 10 ], 2 );
		
		str ( Seconds:2, Ascii_Time );
		move ( Ascii_Time [ 1 ], A_Channel_Time [ 7 ], 2 );
		
		if i in [ 1..40 ] then begin (* Known tag; a place is found *)
		
		j := 1;
		
		(* Is the alarm already in the vector? *)
		repeat
		
			move ( Times [ i, j ], Reference_Time, SizeOf ( Reference_Time ) );
			
			Found := ( Reference_Time = A_Channel_Time )
				and ( Alarms [ i, j ] = Alarm );
				
			j := j + 1;

		until Found or ( j > 20 );
		
		if not Found then begin 	(* Alarm is not found, 		*)
									(* it is put in the vector. *)
									
			(* A new alarm is inserted in the beginning of the vector 	*)
			(* Elements 11 - 20 are not shifted because those are for 	*)
			(* alarm history. Those are handled in process 				*)
			(* Handle_Alarms. 											*)
			move ( Times [ i, 1, 1 ], Times [ i, 2, 1 ], 108 );
			Times [ i, 1 ] := A_Channel_Time;
			
		end;
end; (* if i in [ 1..40 ] .. *)

	end; (* with Alarm_Message ... *)
	
	move ( A_Buffer_Message [ 9 ],
	       A_Buffer_Message,
		( SizeOf ( A_Buffer_Message ) - 8 ) );

			end; (* while Message_Length > 0 ... *)
			Grant ( Alarm_Resource );
		end; (* if ( Message_Length > 0 ) and ... *)
	until FALSE;
end;