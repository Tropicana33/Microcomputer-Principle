        DATA  SEGMENT
       ARRAY  DB        2,3,4,6,8,5,1,7,0,9     ;Ҫ�������
         LEN  EQU       $-ARRAY     ;Ԫ�ظ���
        DATA  ENDS
        
      STACK1  SEGMENT
              DB        200 DUP(0)
      STACK1  ENDS
      
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,SS:STACK1
      START:  MOV       AX,DATA
              MOV       DS,AX
              LEA       SI,ARRAY    ;��ʾδ��������
              MOV       CL,LEN
              CALL      OSTR
          ;    MOV       AH,02H
           ;   MOV       DL,0DH
           ;   INT       21H
              MOV       DL,0AH
              INT       21H
              CALL      SORTP       ;���������ӳ���
              MOV       CL,LEN
              LEA       SI,ARRAY    ;��ʾ���������
              CALL      OSTR
              MOV       AH,4CH      ;����DOS
              INT       21H
        OSTR  PROC                  ;��ʾ�ַ��ӳ���
       LOP1:  MOV       AL,[SI]
              ADD       AX,30H      ;ת��ASCII��
              MOV       DL,AL
              MOV       AH,02H      ;��ʾ�ַ�
              INT       21H
            
              INC       SI
              MOV       DL,','
              MOV       AH,02H
              INT       21H
              LOOP      LOP1
              RET
        OSTR  ENDP
       SORTP  PROC                  ;�����ӳ���
              LEA       DI,ARRAY
              MOV       BX,-1       ;��־-1����BC
       LOP2:  CMP       BX,-1       ;BX=-1����û�Ƚ���
             
              JNE       SEND        ;BX������-1����ȽϽ���
              XOR       BX,BX
              MOV       SI,DI
              MOV       CL,LEN      ;�Ƚϴ���
              DEC       CL
       LOP3:  MOV       AL,[SI]
              CMP       AL,[SI+1]
              JLE       CHE         ;[SI]С�ڵ���[SI+1]��������
              XCHG      [SI+1],AL   ;���򽻻�
              MOV       [SI],AL
              MOV       BX,-1
        CHE:  ADD       SI,1
              LOOP      LOP3
              JMP       LOP2        ;������������һ������
       SEND:  RET
       SORTP  ENDP
       
        CODE  ENDS
              END       START
