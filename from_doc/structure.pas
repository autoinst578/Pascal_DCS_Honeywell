{$I \AC_CONF\TMP\PASCBEGI.PAS}

label; const; type; var; (/Place the definitions first. These definitions are placed in fixed memory locations/)

(/-Local subroutines are placed here.-/)
procedure name (parameter declaration);

	begin
		statements;
	end;
	
	function name (parameter declaration) :type;

	begin
		statements;
	end;
	
	(*block procedure *)
	procedure block_name(block pins declaration);
	
	(/-A block's internal definitions are placed here. These temporary definitions are created in a stack.-/)
	label; const; type; var;
	begin
		Blockbegin;;
			statements;
		Blockend;;
	end;
end.