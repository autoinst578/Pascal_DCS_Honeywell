(**************************************************************************************
(*
(* 								H O N E Y W E L L / F I 0 6
(*
(* 								AUTHOR HMX
(* 								CREATION DATE 30.04.1999
(*
(**************************************************************************************
(*
(* Version history
(*
(* 30.04.1999 HMX / FI06 Original Version
(*
(*
(**************************************************************************************
(*
(* This is an example Pascal program provided with comments.
(*
(* The overall function of the block is described in this part.
(* Each procedure and function has its own header where their function is described.
(*
(* NOTE! - Try to use only one language in all commentation
. Library type files
(* 			(INCLUDE) always in english
(* 			- All names (constants, variables, pins, sub-routines, reserved names etc.)
(* 			  should always be expressed in a similar way (Upper/Lower case)
(* 			- tabulation 2-4 characters
(* 			- Only one statement per line
(* 			- Printout page setting from Block Editor is Landscape
(*
(*************************************************************************************)

unit PASCSUBR;
{$S-}
interface
	{$I \AC_CONF\INCLUDE\PASCINTE.INC}
	{$I \AC_CONF\INCLUDE\PASCREC.INC}
	
	const
		{$I M:\project\000\INCLUDE\CONSTINT.CON} 	(* Declaration of the project specific 	*)
													(* include-files. The declared include- *)
													(* files can include other standard or 	*)
													(* library type include-files. 			*)
													
			(* Include-files are stored in directory m:\Project directory\00x\INCLUDE or 	*)
			(* in its sub-directories if there are lot of include files. 					*)
			
	Empty_Timestamp = ' : : , '; 	(* Variable, constant and type names should be 			*)
									(* descriptive. Names can be longer than 3 or 8 		*)
									(* characters. 											*)
									
	type
		TArr_200_byte 	= array [ 1..200 ] of byte;
		TArr_20_byte 	= array [ 1..20 ] of byte;
		TArr_40_word 	= array [ 1..40 ] of word;
		TArr_12_char 	= array [ 1..12 ] of char;
		TArr_20_12_char = array [ 1..20 ] of TArr_12_char;
		
		(* Types are named Txxxxxxx 			*) 
		(* Enumerated types are named Exxxxxxxx *) 
		(* These rules need to be remembered 	*) 
		(* when giving other names. 			*)

TMessage = record					(* FSC message structure *)
	Tag_Number		: word;
	Alarm 			: byte;
	Milli_Seconds 	: byte;
	Deci_Seconds 	: byte;
	Seconds 		: byte;
	Minutes 		: byte;
	Hours 			: byte;
end;

procedure FSCDATJOIN;

var
	A_Buffer_Message, 								(* Buffered messages from serial ports *)
	B_Buffer_Message 	: TArr_200_byte;
	Tag_Order 			: TArr_40_word; 			(* Tag numbers in use *)
	A_Channel_Time, 								(* Alarm timestamps 	*)
	B_Channel_Time 		: TArr_12_char;
	
	Alarm1, Alarm2, Alarm3, Alarm4, Alarm5, 		(* Alarm queues 				*)
	Alarm6, Alarm7, Alarm8, Alarm9, Alarm10, 		(* Alarms 1 - 10 are for new 	*)
	Alarm11, Alarm12, Alarm13, Alarm14, Alarm15, 	(* alarms 						*)
	Alarm16, Alarm17, Alarm18, Alarm19, Alarm20, 	(* and 							*)
	Alarm21, Alarm22, Alarm23, Alarm24, Alarm25, 	(* alarms 11 - 20 are for 		*)
	Alarm26, Alarm27, Alarm28, Alarm29, Alarm30, 	(* alarm history. 				*)
	Alarm31, Alarm32, Alarm33, Alarm34, Alarm35,
	Alarm36, Alarm37, Alarm38, Alarm39, Alarm40 : TArr_20_byte;
	Alarms : array [ 1..40 ] of TArr_20_byte ABSOLUTE Alarm1;
	
	Time1, Time2, Time3, Time4, Time5, 				(* Alarm timestamps 			*)
	Time6, Time7, Time8, Time9, Time10, 			(* Times 1 - 10 are for new 	*)
	Time11, Time12, Time13, Time14, Time15, 		(* alarms 						*)
	Time16, Time17, Time18, Time19, Time20, 		(* and 							*)
	Time21, Time22, Time23, Time24, Time25, 		(* times 11 - 20 for 			*)
	Time26, Time27, Time28, Time29, Time30, 		(* alarm history 				*)
	Time31, Time32, Time33, Time34, Time35,
	Time36, Time37, Time38, Time39, Time40 : TArr_20_12_char;
	Times : array [ 1..40 ] of TArr_20_12_char ABSOLUTE Time1;
	
	Cold_Start : word;
	
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
			
				Alarms [ i, j ] := 0;
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
	( ( Message_Length mod ( SizeOf ( A_Buffer_Message ) ) = 0 ) then begin
	
	OK := Seize ( Alarm_Resource, MaxWord );
	
	while Message_Length > 0 do begin
	
		move ( A_Buffer_Message, Alarm_Message, SizeOf ( Alarm_Message ) );
		Message_Length := Message_Length - 8;
		
		with Alarm_Message do begin
		
		(* WORD bytes to Intel format *)
		Tag_Number := swap ( Tag_Number );
		
		Ascii_Time := Empty_Timestamp;
		
		Milli_Seconds_Count := Deci_Seconds * 100 + Milli_Seconds;
		str ( Milli_Seconds_Count:2, Ascii_Time );
		move ( Ascii_Time [ 1 ], A_Channel_Time [ 10 ], 2 );
		
		str ( Seconds:2, Ascii_Time );
		move ( Ascii_Time [ 1 ], A_Channel_Time [ 7 ], 2 );
		
		i := 0;
		repeat (* Search the place of the tags alarms in the vectors *)
			i := i + 1;
		until ( i > 40 ) or ( Tag_Order [ i ] = Tag_Number );
		
		if i in [ 1..40 ] then begin (* Known tag; a place is found *)
		
		Found := FALSE;
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
			move ( Alarms [ i, 1 ], Alarms [ i, 2 ], 9 );
			Alarms [ i, 1 ] := Alarm;
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



(**********************************************************)
	procedure FSCDATJOIN;

	begin
		BlockBegin;
		
			NewProcess ( A_Channel_Collect, 1, 100,'DAJoin' );
			
		BlockEnd;
	end;
	
													end.