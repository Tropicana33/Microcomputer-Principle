       DATAS  SEGMENT
       DATA1  DB        0DEH,0BCH,9AH
       DATA2  DB        34H,12H
      RESULT  DB        5 DUP(?)
       DATAS  ENDS

      STACKS  SEGMENT
      STACKS  ENDS

       CODES  SEGMENT
              ASSUME    CS:CODES,DS:DATAS,SS:STACKS
      START:
              MOV       AX,DATAS
              MOV       DS,AX
              MOV       CL,DATA2-DATA1
              MOV       CH,RESULT-DATA2

      LOOP1:  MOV       CL,DATA2-DATA1
      LOOP2:  LEA       SI,DATA1
              LEA       DI,DATA2
			  
              MOV       BL,CL
              ADD       SI,BX
              DEC       SI
              MOV       AL,[SI]

              MOV       BL,CH
              ADD       DI,BX
              DEC       DI
              MOV       BL,[DI]
              MUL       BL

              LEA       BX,RESULT
              ADD       BL,CL
              ADD       BL,CH
              DEC       BL
              ADD       [BX],AL
              ADC       AH,[BX-1]
              MOV       [BX-1],AH

              DEC       CL
              JNZ       LOOP2

              DEC       CH
              JNZ       LOOP1

              MOV       AH,4CH
              INT       21H
       CODES  ENDS
              END       START
