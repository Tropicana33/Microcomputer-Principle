        DATA  SEGMENT
           X  DB        '1','2','3','4','$'     ;��ű�����
           Y  DB        '*','2','3','4','5','=',0DH,0AH,'$' ;��ų���
           Z  DB        8 DUP(0)
              DB        0DH,0AH,'$' ;��Ž��
        DATA  ENDS

      STACK1  SEGMENT   PARA STACK 'STACK1'
              DB        100 DUP (?)
      STACK1  ENDS

        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,SS:STACK1,ES:DATA   ;�ַ����Ƚ�����
        MAIN  PROC      FAR
      START:
              MOV       AX,DATA
              MOV       DS,AX
              MOV       ES,AX
              MOV       AX,STACK1
              MOV       SS,AX
              LEA       DX,X
              MOV       AH,9
              INT       21H
              LEA       DX,Y
              MOV       AH,9
              INT       21H
    
              MOV       DI,4        ;����ָ��
    NEXTOUT:                        ;��ѭ��

              MOV       CX,4
              MOV       SI,3        ;������ָ��
     NEXTIN:                        ;��ѭ��
    
              MOV       AL,X[SI]
              MOV       BL,Y[DI]
              AND       AL,0FH
              AND       BL,0FH
              MUL       BL
              AAM
              CALL      ADDS
              DEC       SI
              LOOP      NEXTIN
    
              DEC       DI
              JNZ       NEXTOUT
    
              MOV       CX,8
              MOV       SI,7
    
      TURNS:                        ;�ѽ��ת����ASCII��
    
              MOV       AL,Z[SI]
              OR        AL,30H
              MOV       Z[SI],AL
              DEC       SI
              LOOP      TURNS
    
              MOV       CX,8
              MOV       SI,0
    
      FINDZ:                        ;��ָ�붨λ������ĵ�һ�����㴦
    
              MOV       AL,Z[SI]
              CMP       AL,'0'
              JNE       EXIT1
              INC       SI
              LOOP      FINDZ

      EXIT1:
              LEA       DX,Z[SI]
              MOV       AH,9
              INT       21H
              MOV       AH,4CH
              INT       21H
              RET
        MAIN  ENDP

        ADDS  PROC      NEAR
              PUSH      SI
              PUSH      DI
              PUSH      CX
              MOV       CX,2        ;��2������˺����λ��
            ;��һλ������Z
              MOV       DX,SI
              MOV       BX,DI
              ADD       BX,DX
              MOV       SI,BX       ;��λָ��
              MOV       DI,SI       ;���Zָ��
              MOV       BX,AX       ;BX����2�����˺���
              CLC
              ADD       AL,Z[SI]
              AAA
              MOV       Z[SI],AL
              JC        CARRY

       NEXT:                        ;��һλ������Z
              DEC       SI
              MOV       DI,SI
              MOV       AL,BH
              CLC
              ADD       AL,Z[SI]
              AAA
              MOV       Z[SI],AL
              JC        CARRY
              JNC       EXIT2
    
      CARRY:
              DEC       DI
              MOV       AL,Z[DI]
              CLC
              ADD       AL,1
              AAA
              MOV       Z[DI],AL
              JC        CARRY
              DEC       CX
              JCXZ      EXIT2
              JMP       NEXT
    
      EXIT2:
              POP       CX
              POP       DI
              POP       SI
              RET       3
        ADDS  ENDP
        CODE  ENDS
              END       START

