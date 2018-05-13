*-----------------------------------------------------------
* Title      :      HAMZA
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------

; 1k stack in address $3000
    ORG     $2C30
PROMPT      DC.B    'MONITOR441> ',0
;help subroutine messages
HHELP       DC.B    'HELP---list all the commands and there usage description',0
HMDSP       DC.B    'MDSP---Outputs the memory address and their contents in bytes from address 1 ',0
HMDSP2      DC.B    '       to address 2. Ex: MDSP $1000 $1008 or MDSP $1000',0
HSORTW      DC.B    'SORTW--Sorts a block of memory from address 1 to address 2.',0
HSORTW1     DC.B    '       A for assesnding and D for desending order Ex: SORTW $1000 $1008',0
HMM         DC.B    'MM-----Display memory and modify a byte(B),(W) or (L). Ex: MM $1000 ;B',0
HMS         DC.B    'MS-----Sets the data into the address. EX: MS $4000 $12',0
HMS1        DC.B    '       Data could be ASCII string or a hex number. Ex: MS $1000 hello',0
HBF         DC.B    'BF-----Fills a word block of memory from address 1 to address 2. ',0
HBF1        DC.B    '       The addresses must be even. BF $1000 $1008 2233---doenst do last byte',0
HBMOV       DC.B    'BMOV---Move(duplicate) a block of memory from one area to another. ',0
HBMOV1      DC.B    '       Ex: BMOV $1000 $1008 $2000.---doesnt do last one',0
HBTST       DC.B    'BTST---Tests a block of memory and tells you if there was an error',0
HBSCH       DC.B    'BSCH---Searches a string in memory block. EX: BSCH $1000 $2000 HELLO.',0
HGO         DC.B    'GO-----Starts execution from a given address',0
HDF         DC.B    'DF-----Displays formatted registers',0
HEXIT       DC.B    'EXIT---Exits MONITOR441',0
HCMPI       DC.B    'CMPI---Compares an immediate byte value to D1-D6 registers. Ex: CMPI 20 D5',0
HMOVEA      DC.B    'MOVEA--Moves an address into A1-A6 register. Ex: MOVEA $2000 A1',0

; LABEL FINISHED IN BMOV
;end help subroutine messages
DD0      DC.B    'D0: ',0
DD1      DC.B    'D1: ',0
DD2      DC.B    'D2: ',0
DD3      DC.B    'D3: ',0
DD4      DC.B    'D4: ',0
DD5      DC.B    'D5: ',0
DD6      DC.B    'D6: ',0
DD7      DC.B    'D7: ',0
AA0      DC.B    'A0: ',0
AR1      DC.B    'A1: ',0
AA2      DC.B    'A2: ',0
AA3      DC.B    'A3: ',0
AA4      DC.B    'A4: ',0
AA5      DC.B    'A5: ',0
AA6      DC.B    'A6: ',0
AA7      DC.B    'A7: ',0
SSR      DC.B    'SR: ',0
USSP     DC.B    'USP: ',0
PPC      DC.B    'PC: ',0
SPK      DC.B    ' ',0
;end DF messages

;MDSPS       DC.B    'Subroutine for MDSP',0
MBUSERR     DC.B    'BUS ERROR HAS OCCURED',0
MBUSERR1     DC.B    'Address Error has Occured',0
MBUSERR2     DC.B    'Illegal intruction ',0
MBUSERR3     DC.B    'Div by 0',0
MBUSERRA     DC.B    'Line A',0
MBUSERRF     DC.B    'Line F',0
MBUSERRP     DC.B    'PRIVILAGE',0
MBUSERRC     DC.B    'CHECK',0
YES         DC.B    'YES',0
NO          DC.B    'NO',0
TOOMANY     DC.B    'More than 8 characters in command.',0
MBTSTF      DC.B    'Block test failed',0
MBTSTP      DC.B    'Block test passed',0

BUFFER      DS.B    80
INPUT       DS.B    80
COMMAND     DS.B    80
ARG1        DS.B    80
ARG2        DS.B    80

    ORG     $2000       ; this is where all the commands are stored
HELP        DC.B    'HELP',0
    ORG     $2008
MDSP        DC.B    'MDSP',0
    ORG     $2010
SORTW       DC.B    'SORTW',0
    ORG     $2018
MM          DC.B    'MM',0
    ORG     $2020
MS          DC.B    'MS',0
    ORG     $2028
BF          DC.B    'BF',0
    ORG     $2030
BMOV        DC.B    'BMOV',0
    ORG     $2038
BTST        DC.B    'BTST',0
    ORG     $2040
BSCH        DC.B    'BSCH',0
    ORG     $2048
GO          DC.B    'GO',0
    ORG     $2050
DF          DC.B    'DF',0
    ORG     $2058
EXIT        DC.B    'EXIT',0
    ORG     $2060
MOVEA       DC.B    'MOVEA',0
    ORG     $2068
CMPI        DC.B    'CMPI',0
    ORG     $2070
INVALID     DC.B    'Invalid Command',0
INVALIDA    DC.B    'Invalid Arguments for ',0
NODOLP      DC.B    'NO $ sign',0
SNF         DC.B    'String not found',0
TESTBSCH    DC.B    'TEST BSCH',0
   
; SUBROUTINES
    ORG $2100
    ; subroutine for help
        LEA         HHELP,A1
        MOVE.B      #13,D0
        TRAP        #15
        
        LEA         HMDSP,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HMDSP2,A1
        MOVE.B      #13,D0
        TRAP        #15
        
        LEA         HSORTW,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HSORTW1,A1
        MOVE.B      #13,D0
        TRAP        #15
        
        LEA         HMM,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HMS,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HMS1,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HBF,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HBF1,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HBMOV,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HBMOV1,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HBTST,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HBSCH,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HGO,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HDF,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HEXIT,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HCMPI,A1
        MOVE.B      #13,D0
        TRAP        #15
        LEA         HMOVEA,A1
        MOVE.B      #13,D0
        TRAP        #15
        BRA         FINISHED
  ; end subroutine for help
    ORG $21D0
    ; subroutine for MDSP    
        MOVE.L      A0,D2
        CMPI.L      #$3006,D2
        BLE         ONEARG          ; there is only on arg
        
        CMPI.L      #$300C,D2       ; number of argument isn't correct
        BGT         EARG
        MOVEA.L     #$3000,A0       ; A0 now points to first arg
        BSR         ATOHEX
        MOVEA.L     A0,A2           ; A2 has the first address
        
        MOVEA.L     #$3006,A0       ; A0 now points to second arg
        BSR         ATOHEX
        MOVE.L      A0,A3           ; A3 has the second address

        SUBA.L      A2,A0           ; check to see if the second address is bigger or not
        BLT         EARG            ; invalid argumet
        
DIS     MOVE.L      A2,D1           ; to display address
        MOVE.B      #16,D2
        MOVE.B      #15,D0
        TRAP        #15
        
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        
        CLR.L       D1
        MOVE.B      (A2)+,D1         ; print the contents of memory
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15
        
        
        MOVE.B      #$0A,D1         ; print LF
        MOVE.B      #6, D0
        TRAP        #15
        
        MOVE.B      #$0D,D1         ; print CR
        MOVE.B      #6, D0
        TRAP        #15
        
        CMPA.L      A2,A3           
        BGE         DIS             ; if A3 >= A2, branch to DIS 
        BRA         FINISHED        ; otherwise go to finished
        
ONEARG  MOVEA.L     #$3000,A0
        BSR         ATOHEX          ; if there is only one argument, A3 will be A2+ 16 bytes
        MOVE.L      A0,A2
        MOVE.L      A2,D2
        MOVE.L      A2,A3
        MOVE.L      #16,D3
        ADDA.L      D3,A3           ; A3 is not A2 + 16
        BRA         DIS             ; to display the memory address and contents 

        
    ORG $2260
    ; subroutine for SORTW
        
        MOVE.L      A0,D2
        CMPI.L      #$300E,D2
        BGT         EARG
        
        MOVEA.L     #$3000,A0
        BSR         ATOHEX
        MOVEA.L     A0,A2           ; A2 has the first address
        MOVE.W      A2,D4
        BTST        #0,D4
        BNE         EARG            ; A2 needs to be even
        MOVEA.L     #$3006,A0
        BSR         ATOHEX
        MOVEA.L     A0,A3           ; A3 has the second address
        MOVE.W      A3,D4
        BTST        #0,D4
        BNE         EARG            ; A3 needs to be even
        CMPA.L      A2,A3
        BLT         EARG            ; second address is bigger than first
        MOVEA.L     A3,A4
        SUBA.L      A2,A4
        MOVE.W      A4,D4           ; D4 is the counter for sort
        CMPI.L      #4,D4
        BLT         EARG            ; the difference is less than 4. not big enough gap
        MOVEA.L     A2,A4           ; A4 has the backup coz a2 will be modified
        MOVEA.L      #$300C,A0      ; to check if it's A or D
        MOVE.B      (A0),D2
        CMPI.B      #$41,D2
        BEQ         ASC
        CMPI.B      #$44,D2
        BEQ         DESC
        BRA         EARG
        
               
ASC     MOVE.W      (A2)+,D2        ; D2 = 3000
        MOVE.W      (A2),D3         ; D3 = 3004
        CMP.W       D2,D3
        BLT         SWAP
        CMPA.L      A2,A3
        BEQ         RO              ; first round over
        BRA         ASC             ; branch back to ASC
SWAP    MOVE.W      D2,(A2)         ; D2 = 3004
        MOVE.W      D3,-(A2)        ; D3 = 3000
        ADDA.L      #2,A2
        CMPA.L      A2,A3
        BEQ         RO              ; first round over
        BRA         ASC
RO      SUBI.L      #2,D4
        BEQ         FINISHED
        MOVE.L      A4,A2
        SUBA.L      #2,A3
        BRA         ASC
        
DESC    MOVE.W      (A2)+,D2        ; D2 = 3000
        MOVE.W      (A2),D3         ; D3 = 3004
        CMP.W       D3,D2
        BLT         DSWAP
        CMPA.L      A2,A3
        BEQ         DRO              ; first round over
        BEQ         FINISHED
        BRA         DESC
DSWAP   MOVE.W      D2,(A2)         ; D2 = 3004
        MOVE.W      D3,-(A2)        ; D3 = 3000
        ADDA.L      #2,A2
        CMPA.L      A2,A3
        BEQ         DRO              ; first round over
        BRA         DESC
DRO     SUBI.L      #2,D4
        BEQ         FINISHED
        MOVE.L      A4,A2
        SUBA.L      #2,A3
        BRA         DESC  
        
    ORG $2330
    ; subroutine for MM  
        
        MOVE.L      A0,D2
        CMPI.L      #$3006,D2
        BLE         DIF             ; default case
        CMPI.L      #$3009,D2       ; if not $3009 then invalid args
        BGT         EARG
        MOVEA.L     #$3006,A0        ; this will give u $3006
        MOVE.B      (A0)+,D2        ; A0 points to 3007
        CMPI.B      #$3B,D2         ; compare it with semi-colon
        BNE         EARG
        MOVE.B      (A0),D7         ; find the next thing. A0 points to 3007
        SUBQ.L      #1,A0           ; A0 has 3006
        BRA         DEF
        
DIF     MOVEA.L     #$3000,A0        ; to get to $3000
        BSR         ATOHEX          ; now A0 has the address
        BRA         BYT
        
DEF     MOVEA.L     #$3000,A0       ; to get to $3000
        BSR         ATOHEX          ; now A0 has the address
        CMPI.B      #$42,D7
        BEQ         BYT             ; branch to BYT if it = B
        CMPI.B      #$57,D7         ; word
        BEQ         WOR
        CMPI.B      #$4C,D7         ; long
        BEQ         LON
        BRA         EARG
BYT     MOVE.B      #1,D7           ; D7 differentiates between byte,word,long. 1= byte
        BRA         DISP    
WOR     MOVE.B      #2,D7           ; D7=2 means its a word
        BRA         DISP
        
LON    MOVE.B      #3,D7           ; D7=3 means its a long

       
DISP    MOVE.B      D7,D4           ; D7 will not change
        MOVE.L      A0,D1           ; to display address
        MOVE.B      #16,D2
        MOVE.B      #15,D0
        TRAP        #15
        
COM     MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        
DIFT    CLR.L       D1
        MOVE.B      (A0),D1         ; print the contents of memory. different for each type
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15
        SUBI.B      #1,D4
        BEQ         SPA
        ADDA.L      #1,A0
        BRA         DIFT
        
SPA     MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        
        MOVE.B      #$2D,D1         ; print --
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$2D,D1         
        MOVE.B      #6, D0
        TRAP        #15
        
        MOVE.B      #$3E,D1         ; print >
        MOVE.B      #6, D0
        TRAP        #15
        
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        
        MOVEA.L     #$3B0,A1      ; so A1 is a even address
        MOVE.B      #2,D0           ; read string from keyboard
        TRAP        #15
        
        CMPI.B      #1,D7
        BNE         WORC            ; go to code for word
        CMPI.B      #$2E,(A1)       ; if it = to .
        BEQ         FINISHED           ; go to start
        CMPI.B      #$0,(A1)       ; if it is = to CR
        BEQ         SKP             ; skip that address
        ;;; could read string from keyboard. Change it to ASCII
        ; jump to sub to change 2 ascii char to HEX
        BSR         A2HEX
        CMPI.L      #0,D3           ; if D3=0, then sub failed
        BEQ         CHK            ; branch to chk
        MOVE.B      D3,(A0)+        ; otherwise write to mem and continue
        BRA         BYT
CHK     CMPI.B      #1,D7
        BEQ         BYT
        CMPI.B      #2,D7
        BEQ         WOR
        CMPI.B      #3,D7
        BEQ         LON
WORC    SUBA.L      #1,A0
        CMPI.B      #2,D7
        BNE         LONC            ; go to code for long
        CMPI.B      #$2E,(A1)       ; if it = to .
        BEQ         FINISHED           ; go to start
        CMPI.B      #$0,(A1)       ; if it is = to CR
        BEQ         SKPW             ; skip that address
        ;;; could read string from keyboard. Change it to ASCII
        ; jump to sub to change 2 ascii char to HEX
        MOVE.B      D7,D0           ; now D7 will not change
WR      BSR         A2HEX
        CMPI.L      #0,D3           ; if D3=0, then sub failed
        BEQ         CHK            ; branch to CHK
        MOVE.B      D3,(A0)+        ; otherwise write to mem and continue
        SUBI.B      #1,D0
        BEQ         CHK
        BRA         WR

LONC    SUBA.L      #1,A0
        CMPI.B      #$2E,(A1)       ; if it = to .
        BEQ         FINISHED           ; go to start
        CMPI.B      #$0,(A1)        ; if it is = to CR
        BEQ         SKPW            ; skip that address
        MOVE.B      D7,D0           ; D7 WILL NOT CHANGE
LR      BSR         A2HEX
        CMPI.L      #0,D3
        BEQ         CHK
        MOVE.B      D3,(A0)+
        SUBI.B      #1,D0
        BEQ         CHK
        BRA         LR
 
SKPW    ADDA.L      #1,A0   
SKP     ADDA.L      #1,A0
        BRA         CHK
        
    ORG $24C0
    ; subroutine for MS
        MOVE.L      A0,D2
        CMPI.L      #$3006,D2
        BLT         EARG
        CMPI.L      #$3030,D2
        BGT         EARG
        MOVEA.L     #$3000,A0
        BSR         ATOHEX
        MOVEA.L     A0,A2           ; A2 has the address
        MOVEA.L     #$3006,A3       ; A3 points to second arg
        MOVE.B      (A3),D2
        CMPI.B      #$24,D2         ; compare it with $
        BEQ         HEXI            ; it's a hex value
STRI    MOVE.B      (A3)+,D2
        MOVE.B      D2,(A2)+
        CMPI.B      #0,D2
        BNE         STRI
        BRA         FINISHED
HEXI    MOVEA.L     #$300C,A1        ; use A1 to store info
        ADDQ.L      #1,A3           ; A3 has the first char
        MOVE.B      (A3)+,(A1)+     ; save the 1st char in A1
        MOVE.B      (A3)+,(A1)       ; save second char in A2
        SUBQ.L      #1,A1           ; make A1 point to beginning
        MOVE.B      #2,D1           ; tell A2HEX to convert a byte
        BSR         A2HEX
        MOVE.B      D3,(A2)         ; write the result in memory
        BRA         FINISHED
        
    ORG $2520
    ; subroutine for BF
        MOVE.L      A0,D2
        CMPI.L      #$3011,D2
        BNE         EARG
        SUBA.L      #$11,A0          ; to get to $3000
        BSR         ATOHEX          ; A0 now has the first address
        MOVE.L      A0,D2
        BTST        #0,D2           ; if odd, then invalid argument
        BNE         EARG
        MOVE.L      A0,A2           ; A2 has the first address
        MOVE.L      #$3006,A0
        BSR         ATOHEX          ; A0 now has the second address
        MOVE.L      A0,D2
        BTST        #0,D2           ; if odd, then invalid argument
        BNE         EARG
        MOVE.L      A0,A3           ; A3 has the second address
        
        CMPA.L      A2,A3
        BLT         EARG            ; first address is bigger than second
        
        MOVE.L      #$300C,A1       ; to get the third argument. store in A1 coz subroutine needs it
WRB     MOVE.B      #2,D7           ; so the subroutine will know its a word
        MOVE.B      D7,D0           ; now D7 will not change
        MOVE.B      #4,D1
WRB1    BSR         A2HEX
        CMPI.L      #0,D3           ; if D3=0, then sub failed
        BEQ         EARG            ; branch to EARG
        MOVE.B      D3,(A2)+        ; otherwise write to mem and continue
        SUBI.B      #1,D0
        BEQ         CHKP
        BRA         WRB1
CHKP    ;ADDA.L      #1,A2
        CMPA.L      A2,A3
        BEQ         FINISHED
        BRA         WRB         
        
    ORG $25A0
    ; subroutine for BMOV     
        MOVE.L     A0,D2
        CMPI.L      #$3012,D2
        BGT         EARG            ; invalid arguments
        MOVEA.L     #$3000,A0        ; A0 points to $3000
        BSR         ATOHEX
        MOVEA.L     A0,A2           ; A2 has the first address
        MOVEA.L     #$3006,A0
        BSR         ATOHEX
        MOVEA.L     A0,A3           ; A3 has the second address
        MOVEA.L     #$300C,A0
        BSR         ATOHEX
        MOVEA.L     A0,A4           ; A4 has the second address
        CMPA.L      A2,A3           ; if second arg is less than first, then invalid args
        BLT         EARG
CMOV    MOVE.B      (A2)+,(A4)+
        CMPA        A2,A3
        BEQ         FINISHED
        BRA         CMOV            ; continue moving data
FINISHED    MOVEM.L         (A7)+,D0-D7/A0-A6       ; RESTORE DATA
            BRA             START
        
    ORG $2BC0
    ; subroutine for BTST
        MOVE.L      A0,D2
        CMPI.L      #$300C,D2
        BGT         EARG            ; invalid arguments
        MOVEA.L     #$3000,A0        ; A0 points to $3000
        BSR         ATOHEX
        MOVEA.L     A0,A2           ; A2 has the first address
        MOVE.L      A2,A4           ; A4 has the copy of A2
        MOVEA.L     #$3006,A0
        BSR         ATOHEX
        MOVEA.L     A0,A3           ; A3 has the second address
        
W       MOVE.B      #$AA,(A2)+      ; fill the memory with AA
        CMPA.L      A2,A3           ; see if we have reached the end
        BEQ         R               ; branch to read if yes
        BRA         W               ; otherwise branch back to write
R       MOVE.B      (A4)+,D2        ; read memory
        CMPI.B      #$AA,D2         ; compare it with $AA
        BNE         BTSTF           ; btst failed
        CMPA.L      A4,A3           ; check to see if we have reached the end
        BEQ         BTSTP           ; if yes, btst passed
        BRA         R               ; branch to R
BTSTF   LEA         MBTSTF,A1       ; print memory test failed
        MOVE.B      #13,D0
        TRAP        #15
        BRA         FINISHED
BTSTP   LEA         MBTSTP,A1       ; print memory test passed
        MOVE.B      #13,D0
        TRAP        #15
        BRA         FINISHED
        
    ORG $25F0
    ; subroutine for BSCH
        MOVE.L      A0,D2
        CMPI.L      #$300C,D2
        BLT         EARG            ; too few arguments
        CMPI.L      #$3020,D2
        BGT         EARG            ; string is too long
        MOVE.L      #$3000,A0        ; start from the first command
        BSR         ATOHEX
        MOVEA.L      A0,A2           ; A2 has the first address
        MOVE.L      #$3006,A0
        BSR         ATOHEX
        MOVEA.L     A0,A3           ; A3 has the second address
        MOVEA.L     #$300C,A0
        CMPA.L      A2,A3
        BLT         EARG            ; second address is less than 1st
        MOVE.W      #0,D3           ; D3 is the counter for the number of characters
        
KCOMP   MOVE.B      (A2)+,D2        ; move whats on first address to D2
        CMP.B       (A0),D2         ; compare it with whats on the stack
        BNE         NEQ             ; not equal
        CMPI.B      #$00,(A0)       ; check to see if the string reached the end
        BEQ         YEQ             ; yes the strings are equal
        ADD.W       #1,D3           ; increment counter
        CMPA.L      A2,A3
        BEQ         FIN             ; reached end of memory. not equal
        ADDA.L      #1,A0           ; to check the next value of stack
        BRA         KCOMP           ; keep comparing
NEQ     MOVE.W      #0,D3           ; reset the counter
        MOVEA.L     #$300C,A0       ; go back to the beginning of the string on stack
        CMPA.L      A2,A3
        BEQ         FIN             ; reached end of memory
        BRA         KCOMP           ; keep comparing
YEQ     SUBA.L      #1,A2
        SUBA.L      D3,A2           ; to get to the address that has the beginning of the string
        MOVE.B      #$24,D1         ; print $
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.L      A2,D1           ; print address
        MOVE.B      #16,D2          ; in hex
        MOVE.B      #15,D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVEA.L     #$300C,A1       ; print the string
        MOVE.B      #13,D0
        TRAP        #15
        MOVEM.L         (A7)+,D0-D7/A0-A6
        BRA         START
FIN     LEA         SNF,A1          ; reached the end, so they are not equal
        MOVE.B      #13,D0
        TRAP        #15
        MOVEM.L         (A7)+,D0-D7/A0-A6
        BRA         START        
        
    ORG $26B0
    ; subroutine for GO
        MOVE.L      A0,D2
        CMPI.L      #$3000,D2       ; no arguments typed
        BEQ         EARG
        CMPI.L      #$3006,D2       ; too many arguments typed
        BGT         EARG
        MOVEA.L     #$3000,A0        ; otherwise, it has 4 digits
        MOVE.L      A0,D2
        CMPI.L      #$3000,D2       ; some other error
        BNE         EARG
        BSR         ATOHEX          ; branch to subroutine to convert ASCII to HEX
        jmp          (A0)
        BRA         FINISHED
    ORG $2890
    ; subroutine for DF
        MOVEM.L         (A7)+,D0-D7/A0-A6     ; MOVE EVERYTHING FROM STACK
        MOVEM.L         D0-D7/A0-A6,-(A7)       ; SAVE ALL THE REGISTERS TO STACK AGAIN
        
        MOVE.L      A4,-(A7)        ; SAVE A4 INTO STACK 
        MOVEA.L     #$2F00,A4       ; SAVE ALL THE REGISTERS IN THIS ADDRESS EXCEPT A4 WHICH IS IN STACK
        MOVE.L      A1,(A4)+        ; SAVE A1 AT 2F00
        MOVE.L      D0,(A4)+        ; SAVE D0 AT 2F04
        MOVE.L      D1,(A4)+        ; SAVE D0 AT 2F08
        MOVE.L      D2,(A4)+        ; SAVE D2 AT 2F0C
        ; -------------------------------                
        LEA         DD0,A1          ; print the string D0 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVEA.L     #$2F04,A4     ; (A4) HAS THE CONTENTS OF D0   
        MOVE.L      (A4),D1         ; print the contents of D0
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------               
        LEA         DD1,A1          ; print the string D1 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVEA.L     #$2F08,A4     ; (A4) HAS THE CONTENTS OF D1
        MOVE.L      (A4),D1         ; print the contents of D1
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------               
        LEA         DD2,A1          ; print the string D2 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVEA.L     #$2F0C,A4     ; (A4) HAS THE CONTENTS OF D2
        MOVE.L      (A4),D1         ; print the contents of D2
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------               
        LEA         DD3,A1          ; print the string D3 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE.L      D3,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        ; -------------------  
        LEA         SPK,A1          ; GO TO NEXT LINE
        MOVE.B      #13,D0
        TRAP        #15
        ; -------------------                 
        LEA         DD4,A1          ; print the string D4 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE.L      D4,D1         ; print the contents of D4
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------               
        LEA         DD5,A1          ; print the string D5 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE.L      D5,D1         ; print the contents of D5
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------               
        LEA         DD6,A1          ; print the string D3 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE.L      D6,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------   
        LEA         DD7,A1          ; print the string D3 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE.L      D7,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        ; ------------------- 
        LEA         SPK,A1          ; GO TO NEXT LINE
        MOVE.B      #13,D0
        TRAP        #15
        ; -------------------   
        LEA         AA0,A1          ; print the string A0 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE.L      A0,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------   
        LEA         AR1,A1          ; print the string A1 
        MOVE.B      #14,D0
        TRAP        #15
        MOVEA.L     #$2F00,A4
        MOVE.L      (A4),D1         ; print the contents of A1
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------   
        LEA         AA2,A1          ; print the string A0 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE.L      A2,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------   
        LEA         AA3,A1          ; print the string A0 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE.L      A3,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        ; -------------------
        LEA         SPK,A1          ; GO TO NEXT LINE
        MOVE.B      #13,D0
        TRAP        #15
        ; -------------------   
        LEA         AA4,A1          ; print the string A0 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE.L      (A7)+,A4        ; restore A4
        MOVE.L      A4,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------   
        LEA         AA5,A1          ; print the string A0 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE.L      A5,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------   
        LEA         AA6,A1          ; print the string A0 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE.L      A6,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        ; ------------------- 
        LEA         SPK,A1          ; GO TO NEXT LINE
        MOVE.B      #13,D0
        TRAP        #15
        ; -------------------   
        LEA         AA7,A1          ; print the string A7 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE.L      A7,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------   
        LEA         SSR,A1          ; print the string A0 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE        SR,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------   
        LEA         USSP,A1          ; print the string A0 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE        USP,A1
        MOVE        A1,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        MOVE.B      #$20,D1         ; print space
        MOVE.B      #6, D0
        TRAP        #15
        ; -------------------   
        LEA         PPC,A1          ; print the string A0 
        MOVE.B      #14,D0
        TRAP        #15
        
        MOVE        USP,A1
        MOVE        A1,D1         ; print the contents of D3
        MOVE.B      #16,D2
        MOVE.B      #15, D0
        TRAP        #15    
        ; ------------------- 
        LEA         SPK,A1          ; GO TO NEXT LINE
        MOVE.B      #13,D0
        TRAP        #15
        ; -------------------
        
        MOVEM.L         (A7)+,D0-D7/A0-A6        ; RESTORE ALL THE REGISTERS
       
        BRA         START
    ORG $26F0
    ; subroutine for exit
        BRA END
    ORG $2700
    ; subroutine for MOVEA
        MOVEA.L         #$3000,A0
        BSR             ATOHEX          ; A0 HAS THE ADDRESS
    
        MOVEA.L         #$3006,A6
        MOVEA.L         A6,A1
        MOVE.B          #2,D1
        BSR             A2HEX
        MOVE.B          D3,D6       ; D6 HAS THE SECOND ARG

        CMPI.B          #$A1,D6
        BEQ             AAA1
        CMPI.B          #$A2,D6
        BEQ             AAA2
        CMPI.B          #$A3,D6
        BEQ             AAA3
        CMPI.B          #$A4,D6
        BEQ             AAA4
        CMPI.B          #$A5,D6
        BEQ             AAA5
        CMPI.B          #$A6,D6
        BEQ             AAA6
        BRA             EARG
AAA1    MOVEA.W         A0,A1
        BRA             REST
AAA2    MOVEA.W         A0,A2
        BRA             REST
AAA3    MOVEA.W         A0,A3
        BRA             REST
AAA4    MOVEA.W         A0,A4
        BRA             REST
AAA5    MOVEA.W         A0,A5
        BRA             REST
AAA6    MOVEA.W         A0,A6
REST    MOVEM.L         (A7)+,D0-D7/A0-A6
        BRA START   

    ORG $2780
    ; Subroutine for CMPI
    MOVEM.L         (A7)+,D0-D7/A0-A6             ; GET ALL THE ORIGINAL REGESTERS
    MOVEM.L         D0-D7/A0-A6,-(A7)             ; SAVE THEM ON STACK AGAIN COZ THEY MIGHT GET MODIFIED
        MOVEA.L         #$300C,A0
        MOVE.L          D3,(A0)+           ; D3 is in 300C
        MOVE.L          D6,(A0)+           ; d6 is in 30010
        MOVE.L          D1,(A0)+             ; D1 is iN 3014
        MOVE.L          D2,(A0)+             ; D2 is iN 3018
        CLR.L           D7
        MOVEA.L         #$3000,A0       ; To get the fist arg
        MOVEA.L         A0,A1
        MOVE.B          #2,D1
        BSR             A2HEX           
        MOVE.L          D3,D0           ; D0 HAS THE NUMBER
        
        MOVEA.L         #$3006,A6
        MOVEA.L         A6,A1
        MOVE.B          #2,D1
        BSR             A2HEX
        MOVE.B          D3,D6       ; D6 HAS THE SECOND ARG
        
        CMPI.B          #$D1,D6
        BEQ             DDD1
        CMPI.B          #$D2,D6
        BEQ             DDD2
        CMPI.B          #$D3,D6
        BEQ             DDD3
        CMPI.B          #$D4,D6
        BEQ             DDD4
        CMPI.B          #$D5,D6
        BEQ             DDD5
        CMPI.B          #$D6,D6
        BEQ             DDD6
        BRA             EARG
DDD1    MOVEA.L         #$3014,A4
        MOVE.L          (A4),D1
        CMP.B           D1,D0
        BNE             PNO
        MOVE.B          #1,D7
        BRA             PYES
DDD2    MOVEA.L         #$3018,A4
        MOVE.L          (A4),D2
        CMP.B           D2,D0
        BNE             PNO
        MOVE.B          #1,D7
        BRA             PYES
DDD3     MOVEA.L         #$300C,A4
        MOVE.L          (A4),D3
        CMP.B           D3,D0
        BNE             PNO
        MOVE.B          #1,D7
        BRA             PYES
DDD4     CMP.B           D4,D0
        BNE             PNO
        MOVE.B          #1,D7
        BRA             PYES
DDD5     CMP.B           D5,D0
        BNE             PNO
        MOVE.B          #1,D7
        BRA             PYES
DDD6     MOVEA.L         #$3010,A4
        MOVE.L          (A4),D6
        CMP.B           D6,D0
        BNE             PNO
        MOVE.B          #1,D7
        BRA             PYES
PYES    LEA         YES,A1       ; PRINT YES
        MOVE.B      #13,D0
        TRAP        #15
        BRA         RESET1
PNO     LEA         NO,A1       ; PRINT NO
        MOVE.B      #13,D0
        TRAP        #15
RESET1  MOVEM.L         (A7)+,D0-D7/A0-A6
        BRA             START

; END SUBROUTINES
    ORG    $1000

START:                  ; first instruction of program

COMP_TABL   EQU     $2000
COMP_ADDR   EQU     $20D0           ; list of addresses
STACK       EQU     $3000
; D6 is the index for list of commands at COMP_TABL
; A2 has input
; A3 has command
; A4 has COMP_TABL
; A5 has COMP_ADDR
; A0 has stack
    
    MOVEM.L         D0-D7/A0-A6,-(A7)
    
    ; update exception vector table
    MOVE.L  #BUS_ERR,$8
    MOVE.L  #ADS_ERR,$C
    MOVE.L  #IL_INST,$10
    MOVE.L  #DIV_Z,$14
    MOVE.L  #CHK_INST,$18
    MOVE.L  #PRI_VIO,$20
    MOVE.L  #LINE_A,$28
    MOVE.L  #LINE_F,$2C
    
        LEA         STACK,A0
        LEA         COMP_TABL,A4    ; A4 has the COMP_TABL
        LEA         COMP_ADDR,A5    ; A5 has the COMP_ADDR
        MOVE.W      #$2100,(A5)+    ; subroutine of help
        MOVE.W      #$21D0,(A5)+    ; subroutine of MDSP
        MOVE.W      #$2260,(A5)+    ; subroutine of SORTW
        MOVE.W      #$2330,(A5)+    ; subroutine of MM
        MOVE.W      #$24C0,(A5)+    ; subroutine of MS
        MOVE.W      #$2520,(A5)+    ; subroutine of BF
        MOVE.W      #$25A0,(A5)+    ; subroutine of BMOV
        MOVE.W      #$2BC0,(A5)+    ; subroutine of BTST
        MOVE.W      #$25F0,(A5)+    ; subroutine of BSCH
        MOVE.W      #$26B0,(A5)+    ; subroutine of GO
        MOVE.W      #$2890,(A5)+    ; subroutine of DF
        MOVE.W      #$26F0,(A5)+    ; subroutine for EXIT
        MOVE.W      #$2700,(A5)+    ; subroutine for MOVEA
        MOVE.W      #$2780,(A5)+    ; subroutine for CMPI
        LEA         COMP_ADDR,A5    ; reset pointer COMP_ADDR
        
        
        MOVE.W      #0,D7       ; D7 is the index for list of commands at COMP_TABL
* Put program code here

    ; output prompt
        LEA         PROMPT, A1
        MOVE.B      #14, D0 
        TRAP        #15
    ; read input
        LEA         INPUT, A1   ; INPUT has the command w/ args
        MOVE.B      #2,D0
        Trap        #15
    ; get only the command
        MOVE.B      #10,D5       ; MAKE D5 THE COUNTER FOR COMMAND.
        LEA         INPUT, A2
        LEA         COMMAND, A3
LOOP    MOVE.B      (A2)+,D1    ; D1 has a char from input
        MOVE.B      D1,(A3)+    ; move that char to command
        SUBI.L      #1,D5
        BEQ         MORE8       ; THERE ARE MORE THAN 8 CHAR IN THE COMMAND
        CMP.B       #$20,D1     ; if there is white space, then we have reached the end of word.
        BEQ         NUL         ; branch to NUL to add 0 at the end of command
        CMP.B       #0,D1       ; if the character is 0, we have reached the end of input
        BEQ         HCMP        ; brach to HCMP. no need to add 0 at the end.
        BRA         LOOP        ; otherwise go back to LOOP
        
NUL     MOVE.B      #0,-(A3)     ; place 0 at the end of command to mark the end
        ; check for aguments now
ARGS    MOVE.B      (A2)+,D1    ; D1 has a char from arg part of input
        MOVE.B      D1, (A0)+   ; move that char to Stack
        CMP.B       #$20,D1     ; if there is a white space, then we have reached the end of word.
        BEQ         ARGS2       ; branch to SARG to check second argument
        CMP.B       #0,D1       ; if the char is 0, we have reached the end of input
        BEQ         HCMP        ; go to HCMP to compare command to COMP_TABLE enteries   
        BRA         ARGS   
ARGS2   MOVEA.L     #$3006,A0   ; address for second argument
ARGS21  MOVE.B      (A2)+,D1    ; D1 has a char from arg2 part of input
        MOVE.B      D1, (A0)+   ; move that char to Stack2
        CMP.B       #$20,D1     ; if there is a white space, then we have reached the end of word.
        BEQ         ARGS3       ; branch to SARG to check second argument
        CMP.B       #0,D1       ; if the char is 0, we have reached the end of input
        BEQ         HCMP        ; go to HCMP to compare command to COMP_TABLE enteries   
        BRA         ARGS21 
ARGS3   MOVEA.L     #$300C,A0   ; address for third argument
ARGS31  MOVE.B      (A2)+,D1    ; D1 has a char from arg3 part of input
        MOVE.B      D1, (A0)+   ; move that char to Stack2
        ;CMP.B       #$20,D1     ; if there is a white space, then we have reached the end of word.
        ;BEQ         EARG        ; last letter shouldn't be space
        CMP.B       #0,D1       ; if the char is 0, we have reached the end of input
        BEQ         HCMP        ; go to HCMP to compare command to COMP_TABLE enteries   
        BRA         ARGS31
    ; compare input to commands       
HCMP    CLR.B       D5          ; CLEAR THE COUNTER D5
        LEA         COMMAND,A2          ; A2 has the comand
        LEA         (0,A4,D7.W),A3      ; A3 has the value of the 0th index of COMP_TABL
        CMPA.W      #$2070,A3           ; check to c if A3 has reached the end
        BEQ         ERROR               ; the command  wasn't in the list. Print invalid command
HCMP1   MOVE.B      (A2)+,D0      
        MOVE.B      (A3)+,D1
        CMP.B       D1,D0       ; compare command with enteries of COMPT_TABLE
        BNE         NEXT        ; NOT EQUAL, compare with next command
        CMP.B       #0,D0       ; check to see if command reached end
        BEQ         NCHK        ; command reached end
        BRA         HCMP1       ; command didn't reach end. compare next char
NCHK    CMP.B       #0,D1
        BNE         ERROR       ; command reached end but help did't reach end. not equal
        BRA         FOUND       ; found the command
    ; check the next command in the list.
NEXT    ADDI.W      #8,D7       ; to increment command table pointer
        ADDA.W      #2,A5       ; to increment subroutine table pointer
        BRA         HCMP

ERROR   LEA         INVALID,A1  ; invalid command
        MOVE.B      #13, D0
        TRAP        #15
        BRA FINISHED
MORE8   LEA         TOOMANY,A1  ; TOO MANNY ARGUMENTS
        MOVE.B      #13, D0
        TRAP        #15
        BRA DONE
EARG    LEA         INVALIDA,A1  ; invalid command
        MOVE.B      #14, D0
        TRAP        #15
        LEA         COMMAND,A1
        MOVE.B      #13, D0
        TRAP        #15
        BRA FINISHED
NODOL   LEA         NODOLP,A1  ; invalid command
        MOVE.B      #13, D0
        TRAP        #15
        BRA FINISHED     
    
    ; found the command
FOUND   LEA         COMMAND, A1     
        MOVE.B      #13, D0
        TRAP        #15             ; print what the command is first
        MOVEA.W     (A5),A6
        jmp         (A6)            ; jump to subroutine
        ; Subroutine for ASCII to HEX
ATOHEX  MOVE.B      (A0),D2        ; look for the $ sign
        CMPI.B      #$24,D2 
        BNE         NODOL           ; no dollar sign
        
        
        MOVE.L      (A0)+,D1         ; D1 has the address in ASCII concert it to hex
        LSL.L       #8,D1
        MOVE.B      (A0),D1         ; D1 the address at this point
        
        CMPI.B      #$0,D1
        BNE         OS              ; if last char is not a null, check if its space
TH      MOVE.L      #$30000000,D5   ; to make the most sig byte '0' of D1
        LSR.L       #8,D1           ; now we have (null)900 instead of 900(null)
        OR.L        D5,D1           ; now we have 0900 instead of (null)900
OS      CMPI.B      #$20,D1
        BEQ         TH              ; if it is space, then we have 3 digit address       
GA      CLR.L       D5
        MOVE.B      #0,D5           ; counter. use it when we only have 2 bytes left
        CLR.L       D2
        MOVE.B      D1, D2          ; D2 has the lowest byte
        
        BRA         SETCH           ; to find what value it is
CB      CMPI.B      #0,D5           ; do this the first time
        BNE         TWO
        MOVE.B      D2,D3           ; D3 has the lowest byte
        ADDI.B      #1,D5           ; increment counter
        LSR.L       #8,D1
        MOVE.B      D1,D2           ; now D2 has the next byte
        BRA         SETCH
TWO     CMPI.B      #1,D5
        BNE         THRE
        LSL.L       #8,D2
        OR.L        D2,D3           ; D3 has two bytes
        ADDI.B      #1,D5           ; increment counter
        CLR.L       D2
        LSR.L       #8,D1
        MOVE.B      D1,D2           ; D2 has the third byte
        BRA         SETCH
THRE    CMPI.B      #2,D5
        BNE         FOR
        LSL.L       #8,D2
        LSL.L       #8,D2
        OR.L        D2,D3           ; D3 has 3 bytes
        ADDI.B      #1,D5           ; increment counter
        CLR.L       D2
        LSR.L       #8,D1
        MOVE.B      D1,D2           ; D2 has the fourth byte
        BRA         SETCH
FOR     LSL.L       #8,D2
        LSL.L       #8,D2
        LSL.L       #8,D2
        OR.L        D2,D3           ; D3 has all 4 bytes
        CLR.L       D2
        MOVE.B      D3,D2           ; D2 has first byte
        LSR.L       #8,D3
        MOVE.B      D3,D5
        MULS.W      #16,D5
        ADD.L       D5,D2           ; D2 has the second byte
        LSR.L       #8,D3
        MOVE.B      D3,D5
        MULS.W      #256,D5
        ADD.L       D5,D2           ; d2 has the third byte
        CLR.L       D5
        LSR.L       #8,D3
        MOVE.B      D3,D5
        MULS.W      #4096,D5
        ADD.L       D5,D2
   
        MOVEA.L     D2,A0           ; A0 has the final address
        
        CLR.L       D1
        CLR.L       D2
        CLR.L       D3
        CLR.L       D5
        RTS

SETCH   CMPI.B      #$30,D2          ; if less than $30, then fail
        BLT         EARG
        CMPI.B      #$39,D2          ; if greater than $39 then it might b a A-F
        BGT         CHAR1
        SUBI.B      #$30,D2         ; if still here than its a digit. now lower byte is in hex
        BRA         CB
        
CHAR1   CMPI.B      #$46,D2         ; if it is bigger than F
        BGT         EARG
        CMPI.B      #$41,D2         ; if it is less than A
        BLT         EARG
        CMPI.B      #$41,D2         ; compare with A
        BEQ         AA1
        CMPI.B      #$42,D2         ; compare with B
        BEQ         BA1
        CMPI.B      #$43,D2         ; compare with C
        BEQ         CA1
        CMPI.B      #$44,D2         ; compare with D
        BEQ         DA1
        CMPI.B      #$45,D2         ; compare with E
        BEQ         EA1
        CMPI.B      #$46,D2         ; compare with F
        BEQ         FA1

AA1     MOVE.B      #$A,D2
        BRA         CB
BA1     MOVE.B      #$B,D2
        BRA         CB
CA1     MOVE.B      #$C,D2
        BRA         CB
DA1     MOVE.B      #$D,D2
        BRA         CB
EA1     MOVE.B      #$E,D2
        BRA         CB
FA1     MOVE.B      #$F,D2
        BRA         CB  
        
        
A2HEX   ; this subroutine changes 2 ASCII bytes to HEX. call it right after calling trap #2
        CLR.L       D2
        CLR.L       D3              ; 
        CMPI.W      #2,D1           ; to make sure it is only 2 char
        BNE         PFAIL            ;sub failed
        BRA         CUT
PFAIL   CMPI.B      #2,D7
        BNE         PFAIL2
        CMPI.W      #4,D1
        BNE         FAIL
        BRA         CUT
PFAIL2  CMPI.B      #3,D7
        BNE         FAIL
        CMPI.W      #6,D1
        BNE         FAIL
        BRA         CUTL
CUT     CMPI.B      #2,D7
        BEQ         CUTW
        BRA         REG
CUTL    CMPI.B      #3,D0
        BEQ         REG             ; FIRST TIME
        ADDQ.L      #2,A1
        MOVE.B      (A1),D2  
        CMPI.B      #2,D0       
        BEQ         REG            ; SECOND TIME
        CMPI.B      #1,D0
        BEQ         REG             ; 3RF TIME
        CMPI.B      #0,D0
        MOVE.B      (A1),D2         
        BEQ         REG2            ; SECOND TIME
                

CUTW    CMPI.B      #1,D0           
        BNE         REG             ; first time for word
        MOVE.L      (A1),D2         
        BRA         REG2
LREG    MOVE.L      (A1),D2         ; D2 HAS A LONG STRING IN ASCII
        BRA         REG
REG     MOVE.W      (A1),D2         ; D2 has the string in ASCII
REG2    CMPI.B      #$39,D2
        BGT         CHART           ; lower byte is not a digit
        CMPI.B      #$30,D2
        BLT         FAIL             ; it's invalid argument
        ; lower byte is a digit from 0 to 9
        SUBI.B      #$30,D2
        MOVE.B      D2,D3           ; D3 has the first number
SEC     LSR.L       #8,D2
        CMPI.B      #$39,D2
        BGT         CHART2          ; upper byte is not a digit
        CMPI.B      #$30,D2
        BLT         FAIL            ; it's invalid argument
        ; upper byte is a digit
        MULS.W      #16,D2
        OR.B         D2,D3          ; D3 has the result
        RTS                         ; return from sub
;        MOVE.B      D3,(A0)+
;        BRA         DISP
CHART   CMPI.B      #$46,D2         ; if it is bigger than F
        BGT         FAIL
        CMPI.B      #$41,D2         ; if it is less than A
        BLT         FAIL
        CMPI.B      #$41,D2         ; compare with A
        BEQ         AE1
        CMPI.B      #$42,D2         ; compare with B
        BEQ         B1
        CMPI.B      #$43,D2         ; compare with C
        BEQ         C1
        CMPI.B      #$44,D2         ; compare with D
        BEQ         DE1
        CMPI.B      #$45,D2         ; compare with E
        BEQ         E1
        CMPI.B      #$46,D2         ; compare with F
        BEQ         F1
BK1     OR.B        D2,D3
        BRA         SEC             ; look at the upper bit
AE1     MOVE.B      #$A,D2
        BRA         BK1
B1      MOVE.B      #$B,D2
        BRA         BK1
C1      MOVE.B      #$C,D2
        BRA         BK1
DE1     MOVE.B      #$D,D2
        BRA         BK1
E1       MOVE.B      #$E,D2
        BRA         BK1
F1       MOVE.B      #$F,D2   
        BRA         BK1 
CHART2  CMPI.B      #$46,D2         ; if it is bigger than F
        BGT         FAIL
        CMPI.B      #$41,D2         ; if it is less than A
        BLT         FAIL
        CMPI.B      #$41,D2         ; compare with A
        BEQ         A
        CMPI.B      #$42,D2         ; compare with B
        BEQ         B
        CMPI.B      #$43,D2         ; compare with C
        BEQ         C
        CMPI.B      #$44,D2         ; compare with D
        BEQ         D
        CMPI.B      #$45,D2         ; compare with E
        BEQ         E
        CMPI.B      #$46,D2         ; compare with F
        BEQ         F
BK      MULS.W      #16,D2
        OR.B        D2,D3           ; D3 has the result
        RTS                         ; return from sub
;        MOVE.B      D3,(A0)+
;        BRA         DISP
A       MOVE.B      #$A,D2
        BRA         BK
B       MOVE.B      #$B,D2
        BRA         BK
C       MOVE.B      #$C,D2
        BRA         BK
D       MOVE.B      #$D,D2
        BRA         BK
E       MOVE.B      #$E,D2
        BRA         BK
F       MOVE.B      #$F,D2   
        BRA         BK
FAIL    CLR.L       D3
        RTS
DONE    MOVEM.L         (A7)+,D0-D7/A0-A6
        BRA START
END
;EXCEPTIONS
            
    ORG $900
    MOVE.L      #$5000,D1   ;CHK
    MOVE.L      #$50010,D2
    CHK.W       D6,D7
    BRA FINISHED
    
     ORG $930
    MOVE.W     #$0,D0       ; div by 0
    MOVE.W      #$0,D1
    DIVU.W        D0,D2
    
     ORG $960
     
    MOVE.L    $2001,A1
    MOVE.W D0,(A1)            ; address error
    BRA $2000
    
    ORG $990
     
    ANDI.W  #$0700,SR          ; PRIV
    BRA FINISHED
    
        
        ORG $1440
     
BUS_ERR LEA         MBUSERR,A1          ; PRINT MESSAGE
        MOVE.B      #13,D0
        TRAP        #15
        BRA         $2890               ; branch to DF
ADS_ERR LEA         MBUSERR1,A1          ; PRINT MESSAGE
        MOVE.B      #13,D0
        TRAP        #15
        BRA         $2890               ; branch to DF
IL_INST LEA         MBUSERR2,A1          ; PRINT MESSAGE
        MOVE.B      #13,D0
        TRAP        #15
        BRA         $2890               ; branch to DF
DIV_Z   LEA         MBUSERR3,A1          ; PRINT MESSAGE
        MOVE.B      #13,D0
        TRAP        #15
        BRA         $2890               ; branch to DF
CHK_INST LEA         MBUSERRC,A1          ; PRINT MESSAGE
        MOVE.B      #13,D0
        TRAP        #15
        BRA         $2890               ; branch to DF
PRI_VIO LEA         MBUSERRP,A1          ; PRINT MESSAGE
        MOVE.B      #13,D0
        TRAP        #15
        BRA         $2890               ; branch to DF
LINE_A  LEA         MBUSERRA,A1          ; PRINT MESSAGE
        MOVE.B      #13,D0
        TRAP        #15
        BRA         $2890               ; branch to DF
LINE_F  LEA         MBUSERRF,A1          ; PRINT MESSAGE
        MOVE.B      #13,D0
        TRAP        #15
        BRA         $2890               ; branch to DF
        

        SIMHALT             ; halt simulator
              

* Put variables and constants here

    END    START        ; last line of source


































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
