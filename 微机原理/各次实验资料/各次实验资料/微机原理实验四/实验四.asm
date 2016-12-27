        CODE  SEGMENT
              ASSUME    CS:CODE
              
      START:  MOV       AX,1999H
              MOV       BP,10
              XOR       BX,BX
              MOV       CH,4
      RETRY:  MOV       CL,4
              SHR       BX,CL
              MOV       DX,0
              DIV       BP
              MOV       CL,4
              ROR       DX,CL
              OR        BX,DX
              DEC       CH
              JNZ       RETRY
              MOV       AX,BX
              MOV       AH,4CH
              INT       21H
        CODE  ENDS
              END       START
