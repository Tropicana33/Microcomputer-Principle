;*******************************;
;*        8255方式1实验2       *;
;*******************************;

        CODE  SEGMENT
              ASSUME    CS:CODE
      START:
              MOV       AX,CS
              MOV       DS,AX
              MOV       DX,OFFSET INT_PROC
              MOV       AX,250BH
              INT       21H
              MOV       DX,21H
              IN        AL,DX
              AND       AL,0F7H
              OUT       DX,AL
              MOV       DX,28BH
              MOV       AL,0B8H
              OUT       DX,AL
              MOV       AL,09H
              OUT       DX,AL
              MOV       BL,8
         LL:  JMP       LL
   INT_PROC:
              MOV       DX,288H
              IN        AL,DX
              MOV       DL,AL
              MOV       AH,02H
              INT       21H
              MOV       DL,0DH
              INT       21H
              MOV       DL,0AH
              INT       21H
              MOV       DX,20H
              MOV       AL,20H
              OUT       DX,AL
              DEC       BL
              JNZ       NEXT
              IN        AL,21H
              OR        AL,08H
              OUT       21H,AL
              STI
              MOV       AH,4CH
              INT       21H
       NEXT:  IRET
        CODE  ENDS
              END       START
