      IOPORT  EQU       0EC00H-0280H
    OUTPORT1  EQU       IOPORT+2A0H
    OUTPORT2  EQU       IOPORT+2A8H
        CODE  SEGMENT
              ASSUME    CS:CODE
      START:
              MOV       DX,OUTPORT1
              OUT       DX,AL
              CALL      DELAY       ;����ʱ�ӳ���
              MOV       DX,OUTPORT2
              OUT       DX,AL
              CALL      DELAY       ;����ʱ�ӳ���
              MOV       AH,1
              INT       16H
              JE        START
              MOV       AH,4CH
              INT       21H
       DELAY  PROC      NEAR        ;��ʱ�ӳ���
              MOV       BX,2000
        LLL:  MOV       CX,0
         LL:  LOOP      LL
              DEC       BX
              JNE       LLL
              RET
       DELAY  ENDP
        CODE  ENDS
              END       START
