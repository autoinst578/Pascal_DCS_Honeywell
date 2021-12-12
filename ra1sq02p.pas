var     act,act1,c11,c12,c13: byte;
        Ost,Ost1            : word;
        CYC,MES,ME2         : real;
        i,fse,sse,edsto     : byte;
        re1,re2,re3,re4     : real; (* ressources from sequences *) 
        v                   : array[1..6] of byte;
        edrrs,E310,E410,E510 : byte;
        edrst,edrin,edrsp   : byte;
        edlst,edlin,edlsp   : byte;
    
    
    procedure RA1SQ02P                                (var enx : byte;      (* END FROM LOOP *)
                                                       var lst : byte;      (* LOCAL START *)
                                                       var lin : byte;      (* LOCAL INTERRUPT *)
                                                       var lsp : byte;      (* LOCAL STOP *)
                                                       var mst : byte;      (* MANUAL START FROM SCREEN *)
                                                       var min : byte;      (* MANUAL INTERRUPT FROM SCREEN *)
                                                       var msp : byte;      (* MANUAL STOP FROM SCREEN *)
                                                       var stt : byte;      (* START *)
                                                       var int : byte;      (* INTERRUPT *)
                                                       var sto : byte;      (* STOP *)
                                                       var sti : byte;      (* START AFTER INTERRUPT *)
                                                       var c01 : byte;      
                                                       var c02 : byte;      (* EMERGENCY STOP *)
                                                       var c03 : byte;      (* TANK C08TKA510 EMPTY *)
                                                       var Tx1 : arr_30_char;(* ALARM TEXT 1 *)
                                                       var al1 : byte;      (* ALARM 1 *)
                                                       var Tx2 : arr_30_char;(* ALARM TEXT 2 *)
                                                       var al2 : byte;      (* ALARM 2 *)
                                                       var ok  : byte;      (* STATUS *)
                                                       var rdy : byte;      (* SEQUENCE FINISHED *)
                                                       var RES : real;      (* RESSOURCE WATER *)
                                                       var c04 : byte;      
                                                       var rst : byte;      (* REQUEST TO START ON *)
                                                       var rsp : byte;      (* REQUEST TO STOP ON *)
                                                       var c05 : byte;      
                                                       var sed : byte;      (* SEQUENCE DEFECT *)
                                                       var rng : byte;      
                                                       var col : byte);     (* FILLING SCREEN START *)

    
    
    
   procedure StartTxt (i:byte);
   
   begin
            case i of
                1: Tx2:='Ressourse in circuit          ';
                2: Tx2:='Emergency stop on             ';
                3: Tx2:='Tank RA1TKE310 empty          ';
                4: Tx2:='Tank RA1TKE410 full           ';
                5: Tx2:='                              ';
                6: Tx2:='                              ';
            end;
   end;
    
   procedure Alarmtxt (i:byte);
         
   begin
            case i of
                1: Tx1:='Motor stopped                 ';
                2: Tx1:='Tank RA1TKE310 empty          ';
                3: Tx1:='                              '; 
                4: begin
                    case Ost of
                      2: Tx1:='Step  2 time check defect     ';
                      4: Tx1:='Step  4 time check defect     ';
                      6: Tx1:='Step  6 time check defect     ';
                      8: Tx1:='Step  8 time check defect     ';
                     10: Tx1:='Step 10 time check defect     ';
                     12: Tx1:='Step 12 time check defect     ';
                     14: Tx1:='Step 14 time check defect     ';
                     90: Tx1:='Step 90 time check defect     '; 
                    end;
                   end;
            end;
    end;
        
    begin
        BlockBegin;

        act:=get__RA1SQ02_act_byte_2s and 1;
        Ost:=get__RA1SQ02_Ost_word_2s;
        
        (* RESETTING VARIABLES *)
        if Ost=0 then begin
            int:=0;sto:=0;
            Tx1:='                              ';
            Tx2:='                              ';
            edsto:=0;
        end;
        stt:=0;sti:=0;OK:=1;
        if Ost=100 then int:=0;
        
        (* CHECKING CONDITIONS OF START *)
        c11:=0;
        c12:=0;
        c13:=0;
        c01:=1;c02:=1;c03:=1;c04:=1;
        al1:=0;al2:=0;
        if odd(c13) or odd(c11) or odd(c12) then v[1]:=0 else v[1]:=1;  (* checking ressources *)
        v[2]:=1;           (* emergency stop *)
        v[3]:=not (get__RA1LIE210_lls_byte_2s);   (* RA1TKE310 empty *)
        v[4]:=not (get__RA1LIE320_uls_byte_2s);   (* RA1TKE410 full *)
        c01:=v[1];c02:=v[2];c03:=v[3];c04:=v[4];
        for i:=1 to 4 do if odd(not v[i]) then begin
            OK:=0;
            StartTxt(i);
        end;
        
        (* LOCAL CONTROLS *)
        if odd(lst) and odd(not edlst) and odd(not act) then stt:=1;
        if odd(lin) and odd(not edlin) then int:=1;
        if odd(lsp) and odd(not edlsp) then sto:=1;
        if odd(lst) and odd(not edlst) and odd(act) and (ost=100) then sti:=1;
        
        (* MANUAL CONTROLS *)
        if odd(mst) and odd(not act) then stt:=1;
        if odd(min) then int:=1;
        if odd(msp) then sto:=1;
        if odd(mst) and odd(act) and (ost=100) then sti:=1;
        
        (* REQUEST TO START ON OR STOP*)
        E310:=get__RA1LIE210_h2s_byte_2s;
        E410:=get__RA1LIE320_l2s_byte_2s;
        if odd(mst) then begin rst:=1;rsp:=0;end;
        if odd(msp) then begin rst:=0;rsp:=1;end;
        if odd(E310) and odd(E410) and odd(not act) then stt:=1;
        
        (* SCREEN BUTTOMS FILL *)
        if odd(sed) then col:=2 else begin
            if odd(rst) then col:=4 else col:=2;
        end;
                
        if odd(stt) or odd(sto) or odd(sti) then sed:=0;
        if Ost=12 then sto:=0;
        
        (* RESERVING RESSOURCES *)
        re1:=0;
        re2:=0;
        re3:=0;
        re4:=0;
                
        (* CHECKING STEPS WHEN RUNNING *)  
        fse:=get__RA1EME311C_fse_byte_2s;
        sse:=get__RA1EME311C_sse_byte_2s; 
        v[ 1]:=1;  
        if (ost=10) then begin
            if odd(fse) then v[ 1]:=get__RA1EME311_rng_byte_2s;
            if odd(sse) then v[ 1]:=get__RA1EME312_rng_byte_2s;
        end;      
        v[ 2]:=1;
        v[ 3]:=1;
        v[ 4]:=(not get__RA1SQ02_cte_byte_2s);
        if Ost=10 then v[ 4]:=1;
        if Ost in [2..89] then for i:=1 to 4 do if odd(not(v[i])) then begin
            AlarmTxt(i);
            al1:=1;
            sed:=1;
            sto:=1;
            rsp:=1;
            rst:=0;
        end;
        
        (* RUNNING INFORMATION *)
        if Ost in [2..10] then rng:=1 else rng:=0; 

        (* STOP FROM LOOP *)
        if odd(enx) then sto:=1;
        enx:=0;
        
        (* DEFECTS RESETTING *)
        if odd(mst) or odd(msp) or odd(min) then sed:=0;
        
        (* COPYING VARIABLES *);
        edlst:=lst;edlin:=lin;edlsp:=lsp;
        mst:=0;min:=0;msp:=0;
       
        BlockEnd;
    end;
end.