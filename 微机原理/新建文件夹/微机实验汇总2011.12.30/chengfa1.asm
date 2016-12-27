        DATA  SEGMENT
       DATA1  DB        9,9,9
       DATA2  DB        9,9
       DATA3  DB        7 DUP(?)
         CY1  DB        0
         CY2  DB        0
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       CL,DATA2-DATA1
              MOV       BX,OFFSET DATA3
              MOV       BP,BX
              MOV       SI,OFFSET DATA1
       REP1:  MOV       DI,OFFSET DATA2
              MOV       CH,DATA3-DATA2
       REP2:  MOV       AL,[SI]
             ; MUL       BYTE PTR [DI]
             ; AAM                   ;ax=18,ah=1,al=8
              ADD       AL,[BX]
             ; AAA
              MOV       [BX],AL
              MOV       AL,AH
              ADD       AL,CY1
            ;  AAA
              JNC       NEXT1
              INC       CY2
      NEXT1:  ADD       AL,[BX+1]
             ; AAA
              JNC       NEXT2
              INC       CY2
      NEXT2:  MOV       [BX+1],AL
              MOV       AL,CY2
              MOV       CY1,AL
              MOV       CY2,0
              INC       BX
              INC       DI
              DEC       CH
              JNZ       REP2
              INC       BP
              MOV       BX,BP
              INC       SI
              MOV       CY1,0
              DEC       CL
              JNZ       REP1
              MOV       BX,OFFSET DATA3
              MOV       CL,7
      LOOP1:  MOV       AL,[BX+6]
              ADD       AL,30H
              MOV       DL,AL
              MOV       AH,02H
              INT       21H
              DEC       BX
              DEC       CL
              JNZ       LOOP1
              MOV       AH,4CH
              INT       21H
        CODE  ENDS
              END       START
